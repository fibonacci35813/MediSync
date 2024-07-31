import 'package:flutter/material.dart';
import 'package:medisync_app/models/medical_record.dart';

class MedicalRecordCard extends StatelessWidget {
  final MedicalRecord record;

  MedicalRecordCard({required this.record});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(record.type),
        subtitle: Text('Date: ${record.date}'),
        // trailing: Icon(Icons.chevron_right),
        // onTap: () {
        //   // TODO: Implement medical record detail view
        // },
      ),
    );
  }
}