// FILE: lib/manager/shift_configuration_screen.dart

import 'package:flutter/material.dart';

class ShiftConfigurationScreen extends StatefulWidget {
  const ShiftConfigurationScreen({Key? key}) : super(key: key);

  @override
  State<ShiftConfigurationScreen> createState() => _ShiftConfigurationScreenState();
}

class _ShiftConfigurationScreenState extends State<ShiftConfigurationScreen> {
  final List<Map<String, dynamic>> _shifts = [
    {'name': 'Morning', 'time': '7:00 AM - 3:00 PM', 'staff': 12, 'skills': 'RN'},
    {'name': 'Evening', 'time': '3:00 PM - 11:00 PM', 'staff': 10, 'skills': 'RN, LPN'},
    {'name': 'Night', 'time': '11:00 PM - 7:00 AM', 'staff': 8, 'skills': 'RN'},
  ];

  void _showAddShiftDialog() {
    final nameController = TextEditingController();
    final timeController = TextEditingController();
    final staffController = TextEditingController();
    final skillsController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Shift'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Shift Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: timeController,
                decoration: const InputDecoration(
                  labelText: 'Time Range',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: staffController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Staff Required',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: skillsController,
                decoration: const InputDecoration(
                  labelText: 'Required Skills',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
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
                  _shifts.add({
                    'name': nameController.text,
                    'time': timeController.text,
                    'staff': int.tryParse(staffController.text) ?? 0,
                    'skills': skillsController.text,
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
        title: const Text('Shift Configuration'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddShiftDialog,
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: _shifts.length,
        itemBuilder: (context, index) {
          final shift = _shifts[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.purple[100],
                child: Icon(Icons.schedule, color: Colors.purple[700]),
              ),
              title: Text(shift['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Text('Time: ${shift['time']}'),
                  Text('Staff: ${shift['staff']}'),
                  Text('Skills: ${shift['skills']}'),
                ],
              ),
              trailing: PopupMenuButton(
                itemBuilder: (context) => [
                  const PopupMenuItem(value: 'edit', child: Text('Edit')),
                  const PopupMenuItem(value: 'delete', child: Text('Delete')),
                ],
                onSelected: (value) {
                  if (value == 'delete') {
                    setState(() => _shifts.removeAt(index));
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