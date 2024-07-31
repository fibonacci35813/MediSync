import 'package:flutter/material.dart';
import 'package:medisync_app/models/reminder.dart';

class ReminderCard extends StatelessWidget {
  final Reminder reminder;

  ReminderCard({required this.reminder});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.access_time),
        title: Text(reminder.text),
        subtitle: Text(reminder.time),
      ),
    );
  }
}