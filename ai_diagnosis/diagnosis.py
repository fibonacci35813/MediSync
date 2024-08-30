import streamlit as st
import pandas as pd
from sentence_transformers import SentenceTransformer
from sklearn.metrics.pairwise import cosine_similarity
import numpy as np

# Improved data loading function with error handling
def safe_load_csv(file_path):
    try:
        df = pd.read_csv(file_path, encoding='utf-8')
        st.write(f"Successfully loaded {file_path}")
        st.write(df.head())
        st.write(df.columns)
        return df
    except Exception as e:
        st.error(f"Error loading {file_path}: {str(e)}")
        return pd.DataFrame()

# Load data
@st.cache_data
def load_data():
    symptom_description = safe_load_csv('symptom_Description.csv')
    symptom_precaution = safe_load_csv('symptom_precaution.csv')
    symptom_severity = safe_load_csv('Symptom-severity.csv')
    disease_symptom = safe_load_csv('dataset.csv')
    return symptom_description, symptom_precaution, symptom_severity, disease_symptom

symptom_description, symptom_precaution, symptom_severity, disease_symptom = load_data()

# Initialize sentence transformer model
@st.cache_resource
def load_model():
    return SentenceTransformer('all-MiniLM-L6-v2')

model = load_model()

# Create disease description embeddings
disease_desc_dict = dict(zip(symptom_description['Disease'], symptom_description['Description']))
disease_desc_embeddings = {disease: model.encode(desc) for disease, desc in disease_desc_dict.items()}

# Create disease precaution embeddings with error handling
disease_precaution_dict = symptom_precaution.set_index('Disease').to_dict('index')
disease_precaution_embeddings = {}
for disease, prec in disease_precaution_dict.items():
    precaution_text = ' '.join([str(value) for value in prec.values() if pd.notna(value)])
    if precaution_text:
        disease_precaution_embeddings[disease] = model.encode(precaution_text)
    else:
        st.warning(f"No valid precautions for disease: {disease}")

# Create symptom severity mapping
symptom_severity_dict = dict(zip(symptom_severity['Symptom'], symptom_severity['weight']))

# Create disease-symptom mapping
disease_symptom_dict = {}
for _, row in disease_symptom.iterrows():
    disease = row['Disease']
    symptoms = [sym for sym in row.iloc[1:] if isinstance(sym, str)]
    if disease in disease_symptom_dict:
        disease_symptom_dict[disease].extend(symptoms)
    else:
        disease_symptom_dict[disease] = symptoms

# Get unique symptoms from the dataset
all_symptoms = set()
for symptoms in disease_symptom_dict.values():
    all_symptoms.update(symptoms)

def get_closest_symptoms(input_symptom, top_n=5):
    input_embedding = model.encode(input_symptom)
    symptom_embeddings = {symptom: model.encode(symptom) for symptom in all_symptoms}
    similarities = {symptom: cosine_similarity([input_embedding], [emb])[0][0] 
                    for symptom, emb in symptom_embeddings.items()}
    return sorted(similarities, key=similarities.get, reverse=True)[:top_n]

def get_disease_from_symptoms(symptoms):
    disease_scores = {}
    for disease, disease_symptoms in disease_symptom_dict.items():
        score = sum(symptom in disease_symptoms for symptom in symptoms)
        disease_scores[disease] = score
    
    # Sort diseases by score in descending order
    sorted_diseases = sorted(disease_scores.items(), key=lambda x: x[1], reverse=True)
    
    # Return top 3 diseases
    return [disease for disease, score in sorted_diseases[:3] if score > 0]

def calculate_severity(symptoms):
    return sum(symptom_severity_dict.get(symptom, 0) for symptom in symptoms)

def get_precautions_from_disease(disease):
    return disease_precaution_dict.get(disease, {})

def diagnose(symptoms):
    possible_diseases = get_disease_from_symptoms(symptoms)
    if not possible_diseases:
        return "No matching diseases found for the given symptoms."
    
    severity = calculate_severity(symptoms)
    
    results = []
    for disease in possible_diseases:
        precautions = get_precautions_from_disease(disease)
        description = disease_desc_dict.get(disease, "No description available.")
        matching_symptoms = set(disease_symptom_dict[disease]).intersection(set(symptoms))
        results.append({
            "disease": disease,
            "description": description,
            "precautions": precautions,
            "severity": severity,
            "matching_symptoms": list(matching_symptoms),
            "match_score": len(matching_symptoms) / len(symptoms)
        })
    
    # Sort results by match score
    results.sort(key=lambda x: x['match_score'], reverse=True)
    
    return results[:3]  # Return top 3 results

# Streamlit UI
st.title("Medical Symptom Checker")

st.write("Enter your symptoms below. The system will match them to the closest known symptoms and provide a diagnosis.")

# Input symptoms
num_symptoms = st.number_input("How many symptoms do you want to enter?", min_value=1, max_value=10, value=3)

selected_symptoms = []
for i in range(num_symptoms):
    symptom_input = st.text_input(f"Symptom {i+1}")
    if symptom_input:
        closest_symptoms = get_closest_symptoms(symptom_input)
        selected_symptom = st.selectbox(f"Did you mean:", closest_symptoms, key=f"symptom_{i}")
        selected_symptoms.append(selected_symptom)

if st.button("Get Diagnosis"):
    if selected_symptoms:
        diagnosis_results = diagnose(selected_symptoms)
        
        if isinstance(diagnosis_results, str):
            st.write(diagnosis_results)
        else:
            for result in diagnosis_results:
                st.subheader(f"Possible Disease: {result['disease']}")
                st.write(f"Match Score: {result['match_score']:.2f}")
                st.write(f"Matching Symptoms: {', '.join(result['matching_symptoms'])}")
                st.write(f"Description: {result['description']}")
                st.write("Precautions:")
                for i, precaution in result['precautions'].items():
                    st.write(f"- {precaution}")
                st.write(f"Severity Score: {result['severity']}")
                st.write("---")
    else:
        st.write("Please enter at least one symptom.")

st.warning("This is a demonstration tool and should not be used for actual medical diagnosis. Always consult with a healthcare professional for medical advice.")