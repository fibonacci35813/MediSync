class Patient {
  final String id;
  final String name;
  final int age;
  final String gender;
  final String lastVisit;
  final List<String> symptoms;
  final List<String> history;
  final List<String> currentMedications;
  final List<TestResult> recentTestResults;
  final List<String> prescriptionImages;

  Patient({
    required this.id,
    required this.name,
    required this.age,
    required this.gender,
    required this.lastVisit,
    required this.symptoms,
    required this.history,
    required this.currentMedications,
    required this.recentTestResults,
    required this.prescriptionImages,
  });

  Patient copyWith({
    String? id,
    String? name,
    int? age,
    String? gender,
    String? lastVisit,
    List<String>? symptoms,
    List<String>? history,
    List<String>? currentMedications,
    List<TestResult>? recentTestResults,
    List<String>? prescriptionImages,
  }) {
    return Patient(
      id: id ?? this.id,
      name: name ?? this.name,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      lastVisit: lastVisit ?? this.lastVisit,
      symptoms: symptoms ?? this.symptoms,
      history: history ?? this.history,
      currentMedications: currentMedications ?? this.currentMedications,
      recentTestResults: recentTestResults ?? this.recentTestResults,
      prescriptionImages: prescriptionImages ?? this.prescriptionImages,
    );
  }
}

class TestResult {
  final String testName;
  final String date;
  final String result;

  TestResult({
    required this.testName,
    required this.date,
    required this.result,
  });
}