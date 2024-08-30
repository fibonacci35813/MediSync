import pandas as pd
import numpy as np
from typing import List, Dict
import torch
from transformers import LlamaTokenizer, LlamaForCausalLM, TrainingArguments, Trainer
from datasets import Dataset
from langchain.vectorstores import FAISS
from langchain.embeddings import HuggingFaceEmbeddings
from langchain.chains import RetrievalQA
from langchain.llms import HuggingFacePipeline
from sklearn.model_selection import train_test_split

# 1. Data Preparation
def load_and_preprocess_data():
    symptom_precaution = pd.read_csv('symptom_precaution.csv')
    symptom_description = pd.read_csv('symptom_Description.csv')
    symptom_severity = pd.read_csv('Symptom-severity.csv')
    disease_symptom = pd.read_csv('disease_symptom.csv')
    
    # Combine data into a single DataFrame
    combined_data = pd.merge(disease_symptom, symptom_description, on='Disease')
    combined_data = pd.merge(combined_data, symptom_precaution, on='Disease')
    
    # Create text for RAG
    combined_data['text'] = combined_data.apply(lambda row: f"Disease: {row['Disease']}\nDescription: {row['Description']}\nSymptoms: {', '.join([col for col in row.index if col.startswith('Symptom_') and pd.notna(row[col])])}\nPrecautions: {', '.join([row[col] for col in row.index if col.startswith('Precaution_') and pd.notna(row[col])])}", axis=1)
    
    return combined_data, symptom_severity

# 2. Model Setup
def setup_model(model_name: str):
    tokenizer = LlamaTokenizer.from_pretrained(model_name)
    model = LlamaForCausalLM.from_pretrained(model_name)
    return tokenizer, model

# 3. Data Preparation for Fine-tuning
def prepare_dataset(data: pd.DataFrame, tokenizer) -> Dataset:
    def tokenize_function(examples):
        return tokenizer(examples["text"], padding="max_length", truncation=True, max_length=512)

    dataset = Dataset.from_pandas(data)
    tokenized_dataset = dataset.map(tokenize_function, batched=True)
    return tokenized_dataset

# 4. Fine-tuning
def fine_tune_model(model, tokenizer, dataset):
    training_args = TrainingArguments(
        output_dir="./results",
        num_train_epochs=3,
        per_device_train_batch_size=4,
        learning_rate=1e-5,
        warmup_steps=500,
        weight_decay=0.01,
        logging_dir="./logs",
    )

    trainer = Trainer(
        model=model,
        args=training_args,
        train_dataset=dataset,
    )

    trainer.train()
    return model

# 5. RAG Setup
def setup_rag(texts: List[str]):
    embeddings = HuggingFaceEmbeddings()
    vectorstore = FAISS.from_texts(texts, embeddings)
    retriever = vectorstore.as_retriever()
    return retriever

# 6. Inference Pipeline
def setup_inference_pipeline(model, tokenizer, retriever):
    pipeline = HuggingFacePipeline.from_model_id(
        model_id="./results",
        task="text-generation",
        model_kwargs={"temperature": 0.7, "max_length": 512}
    )
    qa_chain = RetrievalQA.from_chain_type(pipeline, retriever=retriever)
    return qa_chain

# 7. Safety Integration (Mock implementation - replace with actual Llama Guard when available)
class MockLlamaGuard:
    def check_input(self, text: str) -> bool:
        # Implement input checking logic
        return True

    def check_output(self, text: str) -> bool:
        # Implement output checking logic
        return True

guard = MockLlamaGuard()

def safe_generate(qa_chain, prompt: str) -> str:
    if guard.check_input(prompt):
        response = qa_chain.run(prompt)
        if guard.check_output(response):
            return response
        else:
            return "I apologize, but I can't provide that information."
    else:
        return "I'm sorry, but I can't process that request."

# 8. Main Application
class MedicalDiagnosisSystem:
    def __init__(self, qa_chain, symptom_severity: pd.DataFrame):
        self.qa_chain = qa_chain
        self.symptom_severity = symptom_severity

    def diagnose(self, symptoms: List[str]) -> Dict[str, any]:
        # Calculate severity
        severity = sum(self.symptom_severity.loc[self.symptom_severity['Symptom'].isin(symptoms), 'weight'].fillna(0))
        
        # Generate prompt
        prompt = f"Given the following symptoms: {', '.join(symptoms)}, what is the most likely diagnosis? Please provide the diagnosis, a brief explanation, and potential precautions."
        
        # Get diagnosis
        response = safe_generate(self.qa_chain, prompt)
        
        return {
            "symptoms": symptoms,
            "severity": severity,
            "diagnosis": response
        }

# 9. Evaluation
def evaluate_model(system: MedicalDiagnosisSystem, test_cases: List[Dict[str, any]]) -> float:
    correct = 0
    for case in test_cases:
        diagnosis = system.diagnose(case['symptoms'])
        if case['disease'].lower() in diagnosis['diagnosis'].lower():
            correct += 1
    return correct / len(test_cases)

# Main execution
if __name__ == "__main__":
    # Load and preprocess data
    combined_data, symptom_severity = load_and_preprocess_data()

    # Setup model
    model_name = "meta-llama/Llama-3.1-8B-instruct"
    tokenizer, model = setup_model(model_name)

    # Prepare dataset for fine-tuning
    dataset = prepare_dataset(combined_data, tokenizer)

    # Fine-tune model
    fine_tuned_model = fine_tune_model(model, tokenizer, dataset)

    # Setup RAG
    retriever = setup_rag(combined_data['text'].tolist())

    # Setup inference pipeline
    qa_chain = setup_inference_pipeline(fine_tuned_model, tokenizer, retriever)

    # Create MedicalDiagnosisSystem
    diagnosis_system = MedicalDiagnosisSystem(qa_chain, symptom_severity)

    # Example usage
    symptoms = ["fever", "cough", "fatigue"]
    diagnosis = diagnosis_system.diagnose(symptoms)
    print(diagnosis)

    # Evaluation
    # Create test cases (this should be more comprehensive in a real scenario)
    test_cases = [
        {"symptoms": ["fever", "cough", "fatigue"], "disease": "Common Cold"},
        {"symptoms": ["chest pain", "shortness of breath"], "disease": "Heart Attack"},
    ]
    accuracy = evaluate_model(diagnosis_system, test_cases)
    print(f"Model accuracy: {accuracy}")