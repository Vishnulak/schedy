// lib/manager/schedule_review_screen.dart - PROPER WEEKLY VIEW

import 'package:flutter/material.dart';

class ScheduleReviewScreen extends StatefulWidget {
  const ScheduleReviewScreen({Key? key}) : super(key: key);

  @override
  State<ScheduleReviewScreen> createState() => _ScheduleReviewScreenState();
}

class _ScheduleReviewScreenState extends State<ScheduleReviewScreen> {
  String _viewPeriod = 'weekly'; // weekly or monthly

  // Generated schedule for the ENTIRE week
  final List<Map<String, dynamic>> _weeklySchedule = [
    // Monday - Jan 25
    {'date': 'Mon, Jan 25', 'shift': 'Morning', 'staff': 'John Smith', 'risk': false, 'dept': 'Emergency'},
    {'date': 'Mon, Jan 25', 'shift': 'Evening', 'staff': 'Emily Davis', 'risk': false, 'dept': 'Emergency'},
    {'date': 'Mon, Jan 25', 'shift': 'Night', 'staff': 'Sarah Johnson', 'risk': true, 'dept': 'Emergency'},

    // Tuesday - Jan 26
    {'date': 'Tue, Jan 26', 'shift': 'Morning', 'staff': 'Michael Brown', 'risk': false, 'dept': 'Emergency'},
    {'date': 'Tue, Jan 26', 'shift': 'Evening', 'staff': 'Lisa Anderson', 'risk': false, 'dept': 'Emergency'},
    {'date': 'Tue, Jan 26', 'shift': 'Night', 'staff': 'James Wilson', 'risk': true, 'dept': 'Emergency'},

    // Wednesday - Jan 27
    {'date': 'Wed, Jan 27', 'shift': 'Morning', 'staff': 'Sarah Johnson', 'risk': false, 'dept': 'Emergency'},
    {'date': 'Wed, Jan 27', 'shift': 'Evening', 'staff': 'John Smith', 'risk': false, 'dept': 'Emergency'},
    {'date': 'Wed, Jan 27', 'shift': 'Night', 'staff': 'Emily Davis', 'risk': false, 'dept': 'Emergency'},

    // Thursday - Jan 28
    {'date': 'Thu, Jan 28', 'shift': 'Morning', 'staff': 'Michael Brown', 'risk': false, 'dept': 'Emergency'},
    {'date': 'Thu, Jan 28', 'shift': 'Evening', 'staff': 'Lisa Anderson', 'risk': true, 'dept': 'Emergency'},
    {'date': 'Thu, Jan 28', 'shift': 'Night', 'staff': 'James Wilson', 'risk': false, 'dept': 'Emergency'},

    // Friday - Jan 29
    {'date': 'Fri, Jan 29', 'shift': 'Morning', 'staff': 'Sarah Johnson', 'risk': false, 'dept': 'Emergency'},
    {'date': 'Fri, Jan 29', 'shift': 'Evening', 'staff': 'John Smith', 'risk': false, 'dept': 'Emergency'},
    {'date': 'Fri, Jan 29', 'shift': 'Night', 'staff': 'Emily Davis', 'risk': false, 'dept': 'Emergency'},

    // Saturday - Jan 30
    {'date': 'Sat, Jan 30', 'shift': 'Morning', 'staff': 'Michael Brown', 'risk': false, 'dept': 'Emergency'},
    {'date': 'Sat, Jan 30', 'shift': 'Evening', 'staff': 'Lisa Anderson', 'risk': false, 'dept': 'Emergency'},
    {'date': 'Sat, Jan 30', 'shift': 'Night', 'staff': 'James Wilson', 'risk': false, 'dept': 'Emergency'},

    // Sunday - Jan 31
    {'date': 'Sun, Jan 31', 'shift': 'Morning', 'staff': 'Sarah Johnson', 'risk': false, 'dept': 'Emergency'},
    {'date': 'Sun, Jan 31', 'shift': 'Evening', 'staff': 'John Smith', 'risk': false, 'dept': 'Emergency'},
    {'date': 'Sun, Jan 31', 'shift': 'Night', 'staff': 'Emily Davis', 'risk': false, 'dept': 'Emergency'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Review Schedule'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Schedule saved - Ready to publish'),
                  backgroundColor: Colors.green,
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Period Info Header
          Container(
            padding: const EdgeInsets.all(16.0),
            color: Colors.blue[50],
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Schedule Period',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Jan 25 - Jan 31, 2026 (Weekly)',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.blue[900],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.orange[100],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.warning, size: 16, color: Colors.orange[800]),
                          const SizedBox(width: 4),
                          Text(
                            '2 HRS Risks',
                            style: TextStyle(
                              color: Colors.orange[900],
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildSummaryItem('Total Shifts', '21'),
                    _buildSummaryItem('Staff Used', '6'),
                    _buildSummaryItem('Coverage', '100%'),
                  ],
                ),
              ],
            ),
          ),

          // Schedule List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: _weeklySchedule.length,
              itemBuilder: (context, index) {
                final item = _weeklySchedule[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  color: item['risk'] ? Colors.red[50] : null,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: item['risk'] ? Colors.red[100] : Colors.blue[100],
                      child: Icon(
                        item['risk'] ? Icons.warning : Icons.schedule,
                        color: item['risk'] ? Colors.red[700] : Colors.blue[700],
                      ),
                    ),
                    title: Text(
                      '${item['date']} - ${item['shift']}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Text('Assigned: ${item['staff']}'),
                        if (item['risk'])
                          Text(
                            '⚠️ HRS limit approaching',
                            style: TextStyle(color: Colors.red[700], fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                      ],
                    ),
                    trailing: PopupMenuButton(
                      itemBuilder: (context) => [
                        const PopupMenuItem(value: 'reassign', child: Text('Reassign Staff')),
                        const PopupMenuItem(value: 'lock', child: Text('Lock Shift')),
                        const PopupMenuItem(value: 'details', child: Text('View Details')),
                      ],
                      onSelected: (value) {
                        if (value == 'reassign') {
                          _showReassignDialog(context, item);
                        } else if (value == 'lock') {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('${item['date']} ${item['shift']} locked')),
                          );
                        }
                      },
                    ),
                    isThreeLine: item['risk'],
                  ),
                );
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
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.blue[800],
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

  void _showReassignDialog(BuildContext context, Map<String, dynamic> shift) {
    final List<String> eligibleStaff = [
      'John Smith',
      'Emily Davis',
      'Sarah Johnson',
      'Michael Brown',
      'Lisa Anderson',
      'James Wilson',
    ];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Reassign ${shift['date']} ${shift['shift']}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Current: ${shift['staff']}'),
            const SizedBox(height: 16),
            const Text('Select new staff:', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            ...eligibleStaff.where((s) => s != shift['staff']).map((staff) =>
                ListTile(
                  dense: true,
                  title: Text(staff),
                  trailing: const Icon(Icons.arrow_forward, size: 16),
                  onTap: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Reassigned to $staff')),
                    );
                  },
                ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }
}