// FILE: lib/admin/department_management_screen.dart

import 'package:flutter/material.dart';

class DepartmentManagementScreen extends StatefulWidget {
  const DepartmentManagementScreen({Key? key}) : super(key: key);

  @override
  State<DepartmentManagementScreen> createState() => _DepartmentManagementScreenState();
}

class _DepartmentManagementScreenState extends State<DepartmentManagementScreen> {
  final List<Map<String, dynamic>> _departments = [
    {'name': 'Emergency', 'manager': 'Dr. Sarah Johnson', 'staff': 45},
    {'name': 'Surgery', 'manager': 'Dr. Michael Chen', 'staff': 32},
    {'name': 'ICU', 'manager': 'Dr. Emily Davis', 'staff': 28},
    {'name': 'Pediatrics', 'manager': 'Dr. James Wilson', 'staff': 35},
    {'name': 'Radiology', 'manager': 'Dr. Lisa Anderson', 'staff': 18},
  ];

  void _showAddDepartmentDialog() {
    final nameController = TextEditingController();
    final managerController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Department'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Department Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: managerController,
              decoration: const InputDecoration(
                labelText: 'Manager Name',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (nameController.text.isNotEmpty) {
                setState(() {
                  _departments.add({
                    'name': nameController.text,
                    'manager': managerController.text,
                    'staff': 0,
                  });
                });
                Navigator.pop(context);
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Department Management'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddDepartmentDialog,
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: _departments.length,
        itemBuilder: (context, index) {
          final dept = _departments[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.blue[100],
                child: Text(
                  dept['name'][0],
                  style: TextStyle(color: Colors.blue[700], fontWeight: FontWeight.bold),
                ),
              ),
              title: Text(
                dept['name'],
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Text('Manager: ${dept['manager']}'),
                  Text('Staff: ${dept['staff']}'),
                ],
              ),
              trailing: PopupMenuButton(
                itemBuilder: (context) => [
                  const PopupMenuItem(value: 'edit', child: Text('Edit')),
                  const PopupMenuItem(value: 'delete', child: Text('Delete')),
                ],
                onSelected: (value) {
                  if (value == 'delete') {
                    setState(() => _departments.removeAt(index));
                  }
                },
              ),
              isThreeLine: true,
            ),
          );
        },
      ),
    );
  }
}