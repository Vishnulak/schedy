// ============================================
// FILE: lib/staff/my_schedule_screen.dart
// ============================================

import 'package:flutter/material.dart';

class MyScheduleScreen extends StatefulWidget {
  const MyScheduleScreen({Key? key}) : super(key: key);

  @override
  State<MyScheduleScreen> createState() => _MyScheduleScreenState();
}

class _MyScheduleScreenState extends State<MyScheduleScreen> {
  String _viewMode = 'list'; // 'list' or 'calendar'

  final List<Map<String, dynamic>> _shifts = [
    {
      'day': 'Today',
      'date': 'Jan 25',
      'shift': 'Evening',
      'time': '3:00 PM - 11:00 PM',
      'locked': false,
      'isToday': true,
      'department': 'Emergency'
    },
    {
      'day': 'Tomorrow',
      'date': 'Jan 26',
      'shift': 'Morning',
      'time': '7:00 AM - 3:00 PM',
      'locked': false,
      'isToday': false,
      'department': 'Emergency'
    },
    {
      'day': 'Jan 27',
      'date': 'Jan 27',
      'shift': 'Night',
      'time': '11:00 PM - 7:00 AM',
      'locked': true,
      'isToday': false,
      'department': 'Emergency'
    },
    {
      'day': 'Jan 28',
      'date': 'Jan 28',
      'shift': 'Morning',
      'time': '7:00 AM - 3:00 PM',
      'locked': false,
      'isToday': false,
      'department': 'Emergency'
    },
    {
      'day': 'Jan 29',
      'date': 'Jan 29',
      'shift': 'Evening',
      'time': '3:00 PM - 11:00 PM',
      'locked': false,
      'isToday': false,
      'department': 'Emergency'
    },
    {
      'day': 'Jan 30',
      'date': 'Jan 30',
      'shift': 'Morning',
      'time': '7:00 AM - 3:00 PM',
      'locked': false,
      'isToday': false,
      'department': 'Emergency'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Schedule'),
        actions: [
          IconButton(
            icon: Icon(_viewMode == 'list' ? Icons.calendar_month : Icons.list),
            onPressed: () {
              setState(() {
                _viewMode = _viewMode == 'list' ? 'calendar' : 'list';
              });
            },
            tooltip: _viewMode == 'list' ? 'Calendar View' : 'List View',
          ),
        ],
      ),
      body: Column(
        children: [
          // Week Summary
          Container(
            padding: const EdgeInsets.all(16.0),
            color: Colors.blue[50],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildSummaryItem('This Week', '5 shifts'),
                _buildSummaryItem('Total Hours', '40h'),
                _buildSummaryItem('Next Week', '5 shifts'),
              ],
            ),
          ),

          // Shifts List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: _shifts.length,
              itemBuilder: (context, index) {
                final shift = _shifts[index];
                return _buildShiftCard(shift);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
        ),
      ],
    );
  }

  Widget _buildShiftCard(Map<String, dynamic> shift) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      color: shift['isToday'] ? Colors.blue[50] : null,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: shift['locked']
              ? Colors.red[100]
              : shift['isToday']
              ? Colors.blue[100]
              : Colors.green[100],
          child: Icon(
            shift['locked']
                ? Icons.lock
                : shift['isToday']
                ? Icons.today
                : Icons.schedule,
            color: shift['locked']
                ? Colors.red[700]
                : shift['isToday']
                ? Colors.blue[700]
                : Colors.green[700],
          ),
        ),
        title: Text(
          '${shift['day']} - ${shift['shift']}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(shift['time']),
            Text('Dept: ${shift['department']}'),
            if (shift['locked'])
              Text(
                'Critical Shift - Locked',
                style: TextStyle(color: Colors.red[700], fontSize: 12),
              ),
          ],
        ),
        trailing: shift['locked']
            ? null
            : PopupMenuButton(
          icon: const Icon(Icons.more_vert),
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'swap',
              child: Row(
                children: [
                  Icon(Icons.swap_horiz, size: 20),
                  SizedBox(width: 8),
                  Text('Request Swap'),
                ],
              ),
            ),
            const PopupMenuItem(
              value: 'details',
              child: Row(
                children: [
                  Icon(Icons.info, size: 20),
                  SizedBox(width: 8),
                  Text('View Details'),
                ],
              ),
            ),
          ],
          onSelected: (value) {
            if (value == 'swap') {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Swap request for ${shift['date']}'),
                ),
              );
            }
          },
        ),
        isThreeLine: shift['locked'],
      ),
    );
  }
}