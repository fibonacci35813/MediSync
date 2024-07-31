import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:medisync_app/providers/auth_provider.dart';
import 'package:medisync_app/providers/patient_provider.dart';
import 'package:medisync_app/providers/doctor_provider.dart';
import 'package:medisync_app/screens/doctor/doctor_dashboard_screen.dart';
import 'package:medisync_app/screens/patient/patient_home_screen.dart';
import 'package:medisync_app/screens/login_screen.dart';
import 'package:medisync_app/utils/constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => PatientProvider()),
        ChangeNotifierProvider(create: (_) => DoctorProvider()),
      ],
      child: MaterialApp(
        title: 'MediSync App',
        theme: AppTheme.light,
        home: AuthWrapper(),
        routes: {
          '/login': (context) => LoginScreen(),
          '/doctor_dashboard': (context) => DoctorDashboardScreen(),
          '/patient_home': (context) => PatientHomeScreen(),
        },
        debugShowCheckedModeBanner: false,  // Add this line
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    // Check if the user is logged in
    if (!authProvider.isLoggedIn) {
      return LoginScreen();
    }

    // If logged in, check if it's a doctor or patient
    if (authProvider.isDoctor) {
      return DoctorDashboardScreen();
    } else {
      return PatientHomeScreen();
    }
  }
}