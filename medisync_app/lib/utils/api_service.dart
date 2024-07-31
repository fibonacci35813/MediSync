import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://api.medisync.com'; // Replace with your API base URL

  static Future<dynamic> getPatientData(int patientId) async {
    final response = await http.get(Uri.parse('$baseUrl/patients/$patientId'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load patient data');
    }
  }

  static Future<dynamic> getPatients() async {
    final response = await http.get(Uri.parse('$baseUrl/patients'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load patients');
    }
  }

  // Add more API methods as needed
}