import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:medisync_app/providers/patient_provider.dart';
import 'package:medisync_app/providers/auth_provider.dart'; // Import AuthProvider

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final patientProvider = Provider.of<PatientProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);

    // Ensure the current patient is set
    patientProvider.setCurrentPatient(authProvider.currentUserId!);

    final patient = patientProvider.currentPatient;

    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${patient.name}'),
            Text('Age: ${patient.age}'),
            Text('Last Visit: ${patient.lastVisit}'),
            SizedBox(height: 20),
            Text('Symptoms:'),
            ...patient.symptoms.map((symptom) => Text('- $symptom')),
            SizedBox(height: 20),
            Text('Medical History:'),
            ...patient.history.map((item) => Text('- $item')),
          ],
        ),
      ),
    );
  }
}