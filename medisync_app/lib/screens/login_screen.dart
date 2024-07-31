import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:medisync_app/providers/auth_provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String _username = '';
  String _password = '';
  String _healthId = '';
  bool _isDoctor = true;

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DropdownButton<bool>(
                value: _isDoctor,
                items: [
                  DropdownMenuItem(child: Text('Doctor'), value: true),
                  DropdownMenuItem(child: Text('Patient'), value: false),
                ],
                onChanged: (value) {
                  setState(() {
                    _isDoctor = value!;
                  });
                },
              ),
              SizedBox(height: 20),
              if (_isDoctor || !_isDoctor)
                TextFormField(
                  decoration: InputDecoration(labelText: 'Username'),
                  onSaved: (value) => _username = value!,
                ),
              if (_isDoctor || !_isDoctor)
                TextFormField(
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  onSaved: (value) => _password = value!,
                ),
              if (!_isDoctor)
                TextFormField(
                  decoration: InputDecoration(labelText: 'Health ID'),
                  onSaved: (value) => _healthId = value!,
                ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    bool loginSuccess;
                    if (_isDoctor) {
                      loginSuccess = authProvider.login(
                        username: _username,
                        password: _password,
                        isDoctor: true,
                      );
                    } else {
                      loginSuccess = _healthId.isNotEmpty
                          ? authProvider.loginWithHealthId(healthId: _healthId)
                          : authProvider.login(
                        username: _username,
                        password: _password,
                        isDoctor: false,
                      );
                    }
                    if (loginSuccess) {
                      Navigator.pushReplacementNamed(
                        context,
                        _isDoctor ? '/doctor_dashboard' : '/patient_home',
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Invalid credentials')),
                      );
                    }
                  }
                },
                child: Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}