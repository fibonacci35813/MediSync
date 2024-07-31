import 'package:flutter/foundation.dart';
import 'package:medisync_app/models/medical_record.dart';
import 'package:medisync_app/models/reminder.dart';
import 'package:medisync_app/models/patient.dart';

class PatientProvider with ChangeNotifier {
  late Patient _currentPatient;

  final Map<String, Patient> _patients = {
    'patient456': Patient(
      id: 'patient456',
      name: 'John Doe',
      age: 35,
      gender: 'Male', // Add this
      lastVisit: '2024-07-15',
      symptoms: ['Headache', 'Fatigue'],
      history: ['Hypertension'],
      currentMedications: ['Aspirin'], // Add this
      recentTestResults: [], // Add this
      prescriptionImages: [], // Add this
    ),
  };

  final Map<String, List<MedicalRecord>> _patientRecords = {
    'patient456': [
      MedicalRecord(id: 1, type: 'Blood Test', date: '2024-07-10', results: 'Normal'),
      MedicalRecord(id: 2, type: 'X-Ray', date: '2024-07-05', results: 'Clear'),
    ],
  };

  final Map<String, List<Reminder>> _patientReminders = {
    'patient456': [
      Reminder(id: 1, text: 'Take medication', time: '09:00 AM'),
      Reminder(id: 2, text: 'Doctor appointment', time: '2:00 PM'),
    ],
  };

  void setCurrentPatient(String patientId) {
    _currentPatient = _patients[patientId]!;
    notifyListeners();
  }

  Patient get currentPatient => _currentPatient;

  List<MedicalRecord> getRecords(String patientId) {
    return _patientRecords[patientId] ?? [];
  }

  List<Reminder> getReminders(String patientId) {
    return _patientReminders[patientId] ?? [];
  }

  List<MedicalRecord> get medicalRecords => _patientRecords.values.expand((records) => records).toList();
  List<Reminder> get reminders => _patientReminders.values.expand((reminders) => reminders).toList();
}