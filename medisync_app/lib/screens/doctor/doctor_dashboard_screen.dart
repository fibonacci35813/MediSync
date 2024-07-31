import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:medisync_app/providers/doctor_provider.dart';
import 'package:medisync_app/models/patient.dart';

class DoctorDashboardScreen extends StatefulWidget {
  @override
  _DoctorDashboardScreenState createState() => _DoctorDashboardScreenState();
}

class _DoctorDashboardScreenState extends State<DoctorDashboardScreen> {
  String? _selectedGender;
  String? _selectedCondition;

  @override
  Widget build(BuildContext context) {
    final doctorProvider = Provider.of<DoctorProvider>(context);
    final filteredPatients = doctorProvider.filterPatients(
      gender: _selectedGender,
      condition: _selectedCondition,
    );

    return Scaffold(
      appBar: AppBar(title: Text('Doctor Dashboard')),
      body: Column(
        children: [
          _buildFilters(),
          Expanded(
            child: ListView.builder(
              itemCount: filteredPatients.length,
              itemBuilder: (context, index) {
                final patient = filteredPatients[index];
                return _buildPatientCard(patient);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          DropdownButton<String>(
            value: _selectedGender,
            hint: Text('Gender'),
            onChanged: (value) {
              setState(() {
                _selectedGender = value;
              });
            },
            items: ['Male', 'Female']
                .map((gender) => DropdownMenuItem(value: gender, child: Text(gender)))
                .toList(),
          ),
          SizedBox(width: 16),
          DropdownButton<String>(
            value: _selectedCondition,
            hint: Text('Condition'),
            onChanged: (value) {
              setState(() {
                _selectedCondition = value;
              });
            },
            items: ['Condition X', 'Surgery Y']
                .map((condition) => DropdownMenuItem(value: condition, child: Text(condition)))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildPatientCard(Patient patient) {
    return Card(
      child: ListTile(
        title: Text(patient.name),
        subtitle: Text('ID: ${patient.id}, Age: ${patient.age}, Gender: ${patient.gender}'),
        trailing: Icon(Icons.chevron_right),
        onTap: () {
          _showPatientDetails(patient);
        },
      ),
    );
  }

  void _showPatientDetails(Patient patient) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return PatientDetailsSheet(patient: patient);
      },
    );
  }
}

class PatientDetailsSheet extends StatelessWidget {
  final Patient patient;

  PatientDetailsSheet({required this.patient});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.9,
      minChildSize: 0.5,
      maxChildSize: 0.9,
      builder: (_, controller) {
        return Container(
          padding: EdgeInsets.all(16),
          child: ListView(
            controller: controller,
            children: [
              Text(patient.name, style: Theme.of(context).textTheme.headline5),
              SizedBox(height: 8),
              Text('ID: ${patient.id}, Age: ${patient.age}, Gender: ${patient.gender}'),
              SizedBox(height: 16),
              Text('Medical History:', style: Theme.of(context).textTheme.headline6),
              ...patient.history.map((h) => Text('• $h')),
              SizedBox(height: 16),
              Text('Current Medications:', style: Theme.of(context).textTheme.headline6),
              ...patient.currentMedications.map((m) => Text('• $m')),
              SizedBox(height: 16),
              Text('Recent Test Results:', style: Theme.of(context).textTheme.headline6),
              ...patient.recentTestResults.map((t) => Text('• ${t.testName}: ${t.result} (${t.date})')),
              SizedBox(height: 16),
              Text('Previous Prescriptions:', style: Theme.of(context).textTheme.headline6),
              ...patient.prescriptionImages.map((img) => Image.asset('assets/images/$img')),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // Implement scheduling logic
                },
                child: Text('Schedule Appointment'),
              ),
              SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  // Implement prescription writing logic
                },
                child: Text('Write Prescription'),
              ),
              SizedBox(height: 16),
              Text('AI Diagnosis: Coming Soon', style: TextStyle(fontStyle: FontStyle.italic)),
            ],
          ),
        );
      },
    );
  }
}