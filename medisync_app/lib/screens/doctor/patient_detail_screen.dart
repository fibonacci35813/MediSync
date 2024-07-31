import 'package:flutter/material.dart';
import 'package:medisync_app/models/patient.dart';

class PatientDetailScreen extends StatelessWidget {
  final Patient patient;

  PatientDetailScreen({required this.patient});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(patient.name)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Age: ${patient.age}'),
            Text('Last Visit: ${patient.lastVisit}'),
            SizedBox(height: 16),
            Text('Symptoms:', style: Theme.of(context).textTheme.headline6),
            ...patient.symptoms.map((symptom) => Text('- $symptom')),
            SizedBox(height: 16),
            Text('History:', style: Theme.of(context).textTheme.headline6),
            ...patient.history.map((item) => Text('- $item')),
            // Add AI diagnosis and recommendations here
          ],
        ),
      ),
    );
  }
}