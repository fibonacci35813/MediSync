import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:medisync_app/providers/patient_provider.dart';
import 'package:medisync_app/widgets/reminder_card.dart';

class RemindersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final patientProvider = Provider.of<PatientProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Reminders')),
      body: ListView.builder(
        itemCount: patientProvider.reminders.length,
        itemBuilder: (context, index) {
          return ReminderCard(reminder: patientProvider.reminders[index]);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Implement add reminder functionality
        },
        child: Icon(Icons.add),
      ),
    );
  }
}