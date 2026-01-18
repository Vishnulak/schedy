// lib/staff/clock_in_out_screen.dart - SIMPLIFIED (No complex timer)

import 'package:flutter/material.dart';

class ClockInOutScreen extends StatefulWidget {
  const ClockInOutScreen({Key? key}) : super(key: key);

  @override
  State<ClockInOutScreen> createState() => _ClockInOutScreenState();
}

class _ClockInOutScreenState extends State<ClockInOutScreen> {
  bool _isClockedIn = false;
  String _clockInTime = '';

  final List<Map<String, String>> _recentActivity = [
    {'date': 'Jan 24', 'shift': 'Morning Shift', 'duration': '8h 5m'},
    {'date': 'Jan 23', 'shift': 'Evening Shift', 'duration': '8h 0m'},
    {'date': 'Jan 22', 'shift': 'Morning Shift', 'duration': '8h 10m'},
  ];

  void _toggleClock() {
    setState(() {
      if (_isClockedIn) {
        // Clock Out
        _isClockedIn = false;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Clocked out - Hours updated'), backgroundColor: Colors.green),
        );
      } else {
        // Clock In
        _isClockedIn = true;
        final now = DateTime.now();
        _clockInTime = '${now.hour}:${now.minute.toString().padLeft(2, '0')}';
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Clocked in successfully'), backgroundColor: Colors.green),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Clock In/Out')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Status Card
            Card(
              color: _isClockedIn ? Colors.green[50] : Colors.grey[100],
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  children: [
                    Icon(
                      _isClockedIn ? Icons.check_circle : Icons.access_time,
                      size: 80,
                      color: _isClockedIn ? Colors.green : Colors.grey,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      _isClockedIn ? 'Currently Clocked In' : 'Not Clocked In',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: _isClockedIn ? Colors.green : Colors.grey,
                      ),
                    ),
                    if (_isClockedIn) ...[
                      const SizedBox(height: 12),
                      Text('Clock In Time: $_clockInTime', style: const TextStyle(fontSize: 18)),
                    ],
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Current Shift Info
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Current Shift', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    const Divider(height: 24),
                    _buildInfoRow('Shift', 'Morning'),
                    const SizedBox(height: 8),
                    _buildInfoRow('Time', '7:00 AM - 3:00 PM'),
                    const SizedBox(height: 8),
                    _buildInfoRow('Department', 'Emergency'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Clock Button
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                onPressed: _toggleClock,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _isClockedIn ? Colors.red : Colors.green,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(_isClockedIn ? Icons.logout : Icons.login, size: 28),
                    const SizedBox(width: 12),
                    Text(
                      _isClockedIn ? 'Clock Out' : 'Clock In',
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),

            // Recent Activity
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Recent Activity',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 12),

            Expanded(
              child: ListView.builder(
                itemCount: _recentActivity.length,
                itemBuilder: (context, index) {
                  final activity = _recentActivity[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: ListTile(
                      leading: const CircleAvatar(
                        backgroundColor: Color(0xFFE8F5E9),
                        child: Icon(Icons.check_circle, color: Colors.green),
                      ),
                      title: Text('${activity['date']} - ${activity['shift']}'),
                      trailing: Text(
                        activity['duration']!,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(color: Colors.grey[600])),
        Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
      ],
    );
  }
}