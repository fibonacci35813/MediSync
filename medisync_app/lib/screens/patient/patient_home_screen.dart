import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:medisync_app/providers/auth_provider.dart';
import 'package:medisync_app/providers/patient_provider.dart';

class PatientHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final patientProvider = Provider.of<PatientProvider>(context);
    final patientId = authProvider.currentUserId!;

    return Scaffold(
      appBar: AppBar(title: Text('Patient Home')),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              // Navigate to medical records screen
            },
            child: Text('View Medical Records'),
          ),
          ElevatedButton(
            onPressed: () {
              // Navigate to reminders screen
            },
            child: Text('View Reminders'),
          ),
          Expanded(
            child: ListView(
              children: [
                Text('Recent Medical Records:'),
                ...patientProvider.getRecords(patientId).take(3).map(
                      (record) => ListTile(
                    title: Text(record.type),
                    subtitle: Text('Date: ${record.date}, Results: ${record.results}'),
                  ),
                ),
                Text('Upcoming Reminders:'),
                ...patientProvider.getReminders(patientId).take(3).map(
                      (reminder) => ListTile(
                    title: Text(reminder.text),
                    subtitle: Text('Time: ${reminder.time}'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}