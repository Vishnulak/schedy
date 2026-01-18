// FILE: lib/admin/role_access_screen.dart

import 'package:flutter/material.dart';

class RoleAccessScreen extends StatefulWidget {
  const RoleAccessScreen({Key? key}) : super(key: key);

  @override
  State<RoleAccessScreen> createState() => _RoleAccessScreenState();
}

class _RoleAccessScreenState extends State<RoleAccessScreen> {
  final Map<String, Map<String, bool>> _permissions = {
    'Admin': {
      'Manage Departments': true,
      'Manage Roles': true,
      'View All Schedules': true,
      'Generate Reports': true,
      'Approve Leave': false,
      'Assign Shifts': false,
    },
    'Manager': {
      'Manage Departments': false,
      'Manage Roles': false,
      'View All Schedules': true,
      'Generate Reports': true,
      'Approve Leave': true,
      'Assign Shifts': true,
    },
    'Staff': {
      'Manage Departments': false,
      'Manage Roles': false,
      'View All Schedules': false,
      'Generate Reports': false,
      'Approve Leave': false,
      'Assign Shifts': false,
    },
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Role & Access Control'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: _permissions.keys.map((role) {
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: ExpansionTile(
              title: Text(
                role,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              children: _permissions[role]!.keys.map((permission) {
                return CheckboxListTile(
                  title: Text(permission),
                  value: _permissions[role]![permission],
                  onChanged: (value) {
                    setState(() {
                      _permissions[role]![permission] = value ?? false;
                    });
                  },
                );
              }).toList(),
            ),
          );
        }).toList(),
      ),
    );
  }
}