import 'package:flutter/foundation.dart';
import 'package:medisync_app/models/patient.dart';

class DoctorProvider with ChangeNotifier {
  List<Patient> _patients = [];

  List<Patient> get patients => _patients;

  DoctorProvider() {
    _initializeDummyPatients();
  }

  void _initializeDummyPatients() {
    // Add 20 dummy patients here
    for (int i = 1; i <= 20; i++) {
      _patients.add(
        Patient(
          id: 'P${100 + i}',
          name: 'Patient $i',
          age: 20 + i,
          gender: i % 2 == 0 ? 'Male' : 'Female',
          lastVisit: '2024-07-${15 - i}',
          symptoms: ['Symptom A', 'Symptom B'],
          history: ['Condition X', 'Surgery Y'],
          currentMedications: ['Medicine M', 'Medicine N'],
          recentTestResults: [
            TestResult(testName: 'Blood Test', date: '2024-06-01', result: 'Normal'),
            TestResult(testName: 'X-Ray', date: '2024-06-15', result: 'Clear'),
          ],
          prescriptionImages: ['prescription_1.jpg', 'prescription_2.jpg'],
        ),
      );
    }
  }

  List<Patient> filterPatients({String? gender, String? condition}) {
    return _patients.where((patient) {
      bool genderMatch = gender == null || patient.gender == gender;
      bool conditionMatch = condition == null || patient.history.contains(condition);
      return genderMatch && conditionMatch;
    }).toList();
  }

  void scheduleAppointment(String patientId, DateTime dateTime) {
    // Implement appointment scheduling logic
    print('Scheduled appointment for patient $patientId on $dateTime');
    notifyListeners();
  }

  void updateMedication(String patientId, List<String> medications) {
    final patientIndex = _patients.indexWhere((p) => p.id == patientId);
    if (patientIndex != -1) {
      final updatedPatient = _patients[patientIndex].copyWith(currentMedications: medications);
      _patients[patientIndex] = updatedPatient;
      notifyListeners();
    }
  }

  void writePrescription(String patientId, String prescription) {
    // Implement prescription writing logic
    print('Wrote prescription for patient $patientId: $prescription');
    notifyListeners();
  }
}