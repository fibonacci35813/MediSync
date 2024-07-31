import 'package:flutter/material.dart';
import 'package:medisync_app/models/patient.dart';

class PatientCard extends StatelessWidget {
  final Patient patient;
  final VoidCallback onTap;

  PatientCard({required this.patient, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(patient.name),
        subtitle: Text('Age: ${patient.age} | Last Visit: ${patient.lastVisit}'),
        trailing: Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}