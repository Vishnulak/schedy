// FILE: lib/admin/hospital_settings_screen.dart

import 'package:flutter/material.dart';

class HospitalSettingsScreen extends StatefulWidget {
  const HospitalSettingsScreen({Key? key}) : super(key: key);

  @override
  State<HospitalSettingsScreen> createState() => _HospitalSettingsScreenState();
}

class _HospitalSettingsScreenState extends State<HospitalSettingsScreen> {
  final _formKey = GlobalKey<FormState>();
  String _hospitalName = 'City General Hospital';
  String _timezone = 'UTC+5:30';
  double _maxHoursPerWeek = 48.0;
  double _minRestHours = 11.0;
  bool _emergencyOverride = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hospital Settings'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            _buildSectionHeader('Hospital Information'),
            const SizedBox(height: 12),
            TextFormField(
              initialValue: _hospitalName,
              decoration: const InputDecoration(
                labelText: 'Hospital Name',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
              ),
              onChanged: (value) => _hospitalName = value,
            ),
            const SizedBox(height: 16),
            TextFormField(
              initialValue: _timezone,
              decoration: const InputDecoration(
                labelText: 'Timezone',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
              ),
              onChanged: (value) => _timezone = value,
            ),
            const SizedBox(height: 24),

            _buildSectionHeader('Working Hours Policy'),
            const SizedBox(height: 12),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Max Hours per Week'),
                        Text(
                          '${_maxHoursPerWeek.toInt()}h',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Slider(
                      value: _maxHoursPerWeek,
                      min: 40,
                      max: 60,
                      divisions: 20,
                      onChanged: (value) => setState(() => _maxHoursPerWeek = value),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Minimum Rest Hours'),
                        Text(
                          '${_minRestHours.toInt()}h',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Slider(
                      value: _minRestHours,
                      min: 8,
                      max: 16,
                      divisions: 8,
                      onChanged: (value) => setState(() => _minRestHours = value),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            _buildSectionHeader('Emergency Settings'),
            const SizedBox(height: 12),
            Card(
              child: SwitchListTile(
                title: const Text('Emergency Override'),
                subtitle: const Text('Allow override of rest hour rules in emergencies'),
                value: _emergencyOverride,
                onChanged: (value) => setState(() => _emergencyOverride = value),
              ),
            ),
            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Settings saved successfully')),
                  );
                },
                child: const Text('Save Settings', style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }
}