// FILE: lib/manager/department_overview_screen.dart

import 'package:flutter/material.dart';

class DepartmentOverviewScreen extends StatelessWidget {
  const DepartmentOverviewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Department Overview'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildStaffMember('Dr. Sarah Johnson', 'RN, Critical Care', 'green'),
          _buildStaffMember('John Smith', 'RN', 'green'),
          _buildStaffMember('Emily Davis', 'LPN, Pediatrics', 'yellow'),
          _buildStaffMember('Michael Brown', 'RN, Emergency', 'green'),
          _buildStaffMember('Lisa Anderson', 'RN, Surgery', 'red'),
          _buildStaffMember('James Wilson', 'LPN', 'yellow'),
        ],
      ),
    );
  }

  Widget _buildStaffMember(String name, String skills, String status) {
    Color statusColor;
    IconData statusIcon;

    switch (status) {
      case 'green':
        statusColor = Colors.green;
        statusIcon = Icons.check_circle;
        break;
      case 'yellow':
        statusColor = Colors.orange;
        statusIcon = Icons.warning;
        break;
      case 'red':
        statusColor = Colors.red;
        statusIcon = Icons.error;
        break;
      default:
        statusColor = Colors.grey;
        statusIcon = Icons.help;
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: statusColor.withOpacity(0.2),
          child: Icon(statusIcon, color: statusColor),
        ),
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text('Skills: $skills'),
            const SizedBox(height: 2),
            Text(
              'HRS Status: ${status == 'green' ? 'Normal' : status == 'yellow' ? 'Approaching Limit' : 'Critical'}',
              style: TextStyle(color: statusColor, fontSize: 12),
            ),
          ],
        ),
        trailing: const Icon(Icons.chevron_right),
        isThreeLine: true,
      ),
    );
  }
}