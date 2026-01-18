// ============================================
// FILE: lib/staff/emergency_unavailability_screen.dart
// ============================================

import 'package:flutter/material.dart';

class EmergencyUnavailabilityScreen extends StatelessWidget {
  const EmergencyUnavailabilityScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Emergency Unavailability'),
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Warning Card
            Card(
              color: Colors.red[50],
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.warning, color: Colors.red[700], size: 32),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Emergency Use Only',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Use this feature only in case of true emergencies (illness, accident, family emergency). Your manager will be immediately notified and the shift will be flagged as "At Risk".',
                            style: TextStyle(fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            Text(
              'Select Affected Shift',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Choose the shift you cannot attend',
              style: TextStyle(color: Colors.grey[600]),
            ),
            const SizedBox(height: 16),

            _buildShiftOption(
              context,
              'Today - Evening Shift',
              '3:00 PM - 11:00 PM',
              'Jan 25',
            ),
            _buildShiftOption(
              context,
              'Tomorrow - Morning Shift',
              '7:00 AM - 3:00 PM',
              'Jan 26',
            ),
            _buildShiftOption(
              context,
              'Jan 27 - Night Shift',
              '11:00 PM - 7:00 AM',
              'Jan 27',
            ),
            _buildShiftOption(
              context,
              'Jan 28 - Morning Shift',
              '7:00 AM - 3:00 PM',
              'Jan 28',
            ),
            const Spacer(),

            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'By marking emergency unavailability, you confirm this is an unforeseen emergency. Frequent emergency unavailability may affect future scheduling.',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShiftOption(
      BuildContext context,
      String shift,
      String time,
      String date,
      ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: const CircleAvatar(
          backgroundColor: Color(0xFFFFEBEE),
          child: Icon(Icons.event_busy, color: Colors.red),
        ),
        title: Text(shift, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(time),
            Text('Date: $date', style: const TextStyle(fontSize: 12)),
          ],
        ),
        trailing: ElevatedButton(
          onPressed: () => _showConfirmationDialog(context, shift, date),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          ),
          child: const Text(
            'Report',
            style: TextStyle(fontSize: 12),
          ),
        ),
        isThreeLine: true,
      ),
    );
  }

  void _showConfirmationDialog(BuildContext context, String shift, String date) {
    final reasonController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Emergency'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Are you sure you cannot attend $shift?'),
            const SizedBox(height: 16),
            TextField(
              controller: reasonController,
              decoration: const InputDecoration(
                labelText: 'Emergency reason (required)',
                border: OutlineInputBorder(),
                hintText: 'e.g., sudden illness, family emergency',
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all( 12),
              decoration: BoxDecoration(
                color: Colors.orange[50],
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Row(
                children: [
                  Icon(Icons.info, color: Colors.orange, size: 20),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Your manager will be notified immediately',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              reasonController.dispose();
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (reasonController.text.trim().isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please provide a reason'),
                    backgroundColor: Colors.red,
                  ),
                );
                return;
              }

              reasonController.dispose();
              Navigator.pop(context);
              Navigator.pop(context);

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Emergency reported. Manager notified immediately.'),
                  backgroundColor: Colors.red,
                  duration: Duration(seconds: 3),
                ),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Confirm Emergency'),
          ),
        ],
      ),
    );
  }
}
