// lib/staff/shift_swap_screen.dart - SIMPLIFIED, NO TABS

import 'package:flutter/material.dart';

class ShiftSwapScreen extends StatefulWidget {
  const ShiftSwapScreen({Key? key}) : super(key: key);

  @override
  State<ShiftSwapScreen> createState() => _ShiftSwapScreenState();
}

class _ShiftSwapScreenState extends State<ShiftSwapScreen> {
  final List<Map<String, dynamic>> _eligibleStaff = [
    {'name': 'Michael Brown', 'skills': 'RN, Emergency', 'hrs': 'Green'},
    {'name': 'Emily Davis', 'skills': 'LPN, Pediatrics', 'hrs': 'Green'},
    {'name': 'Lisa Anderson', 'skills': 'RN, Surgery', 'hrs': 'Yellow'},
    {'name': 'John Smith', 'skills': 'RN', 'hrs': 'Green'},
  ];

  final List<Map<String, dynamic>> _mySwapRequests = [
    {
      'with': 'John Smith',
      'shift': 'Jan 28 Morning',
      'status': 'Pending',
      'date': 'Jan 28',
      'time': '7:00 AM - 3:00 PM',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Shift Swap')),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // My Next Shift
          Card(
            color: Colors.blue[50],
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.schedule, color: Colors.blue[700]),
                      const SizedBox(width: 8),
                      const Text('My Next Shift', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text('Jan 26, Morning Shift'),
                  const Text('7:00 AM - 3:00 PM'),
                  const Text('Emergency Department', style: TextStyle(fontSize: 12, color: Colors.grey)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Info
          Card(
            color: Colors.orange[50],
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Icon(Icons.info, color: Colors.orange[700]),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      'Swap requests require manager approval',
                      style: TextStyle(fontSize: 13),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Eligible Staff
          Text(
            'Request Swap With',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),

          ..._eligibleStaff.map((staff) => Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: staff['hrs'] == 'Green' ? Colors.green[100] : Colors.orange[100],
                child: Text(
                  staff['name'][0],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: staff['hrs'] == 'Green' ? Colors.green[700] : Colors.orange[700],
                  ),
                ),
              ),
              title: Text(staff['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Text('Skills: ${staff['skills']}', style: const TextStyle(fontSize: 12)),
                  Row(
                    children: [
                      Icon(Icons.circle, size: 8, color: staff['hrs'] == 'Green' ? Colors.green : Colors.orange),
                      const SizedBox(width: 4),
                      Text(
                        'HRS: ${staff['hrs']}',
                        style: TextStyle(
                          color: staff['hrs'] == 'Green' ? Colors.green : Colors.orange,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              trailing: ElevatedButton(
                onPressed: () => _showSwapDialog(staff['name']),
                child: const Text('Request'),
              ),
              isThreeLine: true,
            ),
          )),
          const SizedBox(height: 24),

          // My Swap Requests
          Text(
            'My Swap Requests',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),

          ..._mySwapRequests.map((req) {
            Color statusColor = Colors.orange;
            return Card(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: statusColor.withOpacity(0.2),
                  child: Icon(Icons.swap_horiz, color: statusColor),
                ),
                title: Text('Swap with ${req['with']}', style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text('${req['date']} • ${req['time']}'),
                trailing: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    req['status'],
                    style: TextStyle(color: statusColor, fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  void _showSwapDialog(String staffName) {
    final reasonController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Request swap with $staffName'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Your shift: Jan 26, Morning (7 AM - 3 PM)'),
            const SizedBox(height: 16),
            TextField(
              controller: reasonController,
              decoration: const InputDecoration(
                labelText: 'Reason (optional)',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
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
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Swap request sent to $staffName - Manager will review'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text('Send'),
          ),
        ],
      ),
    );
  }
}