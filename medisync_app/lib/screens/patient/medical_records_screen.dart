import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:medisync_app/providers/patient_provider.dart';
import 'package:medisync_app/widgets/medical_record_card.dart';

class MedicalRecordsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final patientProvider = Provider.of<PatientProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Medical Records')),
      body: ListView.builder(
        itemCount: patientProvider.medicalRecords.length,
        itemBuilder: (context, index) {
          return MedicalRecordCard(
            record: patientProvider.medicalRecords[index],
          );
        },
      ),
    );
  }
}