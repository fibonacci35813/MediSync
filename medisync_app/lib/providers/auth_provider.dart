import 'package:flutter/foundation.dart';

class AuthProvider with ChangeNotifier {
  bool _isLoggedIn = false;
  bool _isDoctor = false;
  String? _currentUserId;

  bool get isLoggedIn => _isLoggedIn;
  bool get isDoctor => _isDoctor;
  String? get currentUserId => _currentUserId;

  // Dummy data
  final Map<String, String> _doctorCredentials = {
    'doctor123': 'password123',
  };

  final Map<String, String> _patientCredentials = {
    'patient456': 'password456',
  };

  final Map<String, String> _patientHealthIds = {
    'patient456': 'HEALTH123456',
  };

  bool login({required String username, required String password, required bool isDoctor}) {
    if (isDoctor) {
      if (_doctorCredentials[username] == password) {
        _isLoggedIn = true;
        _isDoctor = true;
        _currentUserId = username;
        notifyListeners();
        return true;
      }
    } else {
      if (_patientCredentials[username] == password) {
        _isLoggedIn = true;
        _isDoctor = false;
        _currentUserId = username;
        notifyListeners();
        return true;
      }
    }
    return false;
  }

  bool loginWithHealthId({required String healthId}) {
    final patientId = _patientHealthIds.entries.firstWhere(
          (entry) => entry.value == healthId,
      orElse: () => MapEntry('', ''),
    ).key;

    if (patientId.isNotEmpty) {
      _isLoggedIn = true;
      _isDoctor = false;
      _currentUserId = patientId;
      notifyListeners();
      return true;
    }
    return false;
  }

  void logout() {
    _isLoggedIn = false;
    _isDoctor = false;
    _currentUserId = null;
    notifyListeners();
  }
}