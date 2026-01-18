// FILE: lib/manager/emergency_management_screen.dart

import 'package:flutter/material.dart';

class EmergencyManagementScreen extends StatelessWidget {
  const EmergencyManagementScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Emergency Management'),
        backgroundColor: Colors.red,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Card(
            color: Colors.red[50],
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.emergency, color: Colors.red[700]),
                      const SizedBox(width: 8),
                      Text(
                        'Flagged Shifts',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.red[900],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildEmergencyShift(
                    'Jan 25, Night Shift',
                    'Sarah Johnson - Called in sick',
                    ['Michael Brown', 'Emily Davis'],
                  ),
                  const Divider(height: 24),
                  _buildEmergencyShift(
                    'Jan 26, Morning Shift',
                    'Equipment maintenance - Extra staff needed',
                    ['John Smith', 'Lisa Anderson'],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmergencyShift(String shift, String issue, List<String> suggestions) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          shift,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 4),
        Text(issue),
        const SizedBox(height: 12),
        const Text(
          'Replacement Suggestions:',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        ...suggestions.map((name) => Padding(
          padding: const EdgeInsets.only(left: 16, top: 4),
          child: Row(
            children: [
              const Icon(Icons.person, size: 16),
              const SizedBox(width: 8),
              Text(name),
            ],
          ),
        )),
        const SizedBox(height: 12),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
          child: const Text('Assign Replacement'),
        ),
      ],
    );
  }
}