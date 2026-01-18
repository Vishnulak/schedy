// FILE: lib/manager/leave_swap_requests_screen.dart

import 'package:flutter/material.dart';

class LeaveSwapRequestsScreen extends StatefulWidget {
  const LeaveSwapRequestsScreen({Key? key}) : super(key: key);

  @override
  State<LeaveSwapRequestsScreen> createState() => _LeaveSwapRequestsScreenState();
}

class _LeaveSwapRequestsScreenState extends State<LeaveSwapRequestsScreen> {
  final List<Map<String, dynamic>> _leaveRequests = [
    {'name': 'John Smith', 'date': 'Jan 25-27', 'reason': 'Personal', 'impact': 'Low'},
    {'name': 'Emily Davis', 'date': 'Jan 30', 'reason': 'Medical', 'impact': 'Medium'},
  ];

  final List<Map<String, dynamic>> _swapRequests = [
    {'from': 'Sarah Johnson', 'to': 'Michael Brown', 'date': 'Jan 28', 'shift': 'Morning'},
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Requests'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Leave Requests'),
              Tab(text: 'Swap Requests'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildLeaveRequestsTab(),
            _buildSwapRequestsTab(),
          ],
        ),
      ),
    );
  }

  Widget _buildLeaveRequestsTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: _leaveRequests.length,
      itemBuilder: (context, index) {
        final request = _leaveRequests[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  request['name'],
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 8),
                Text('Date: ${request['date']}'),
                Text('Reason: ${request['reason']}'),
                Text(
                  'Impact: ${request['impact']}',
                  style: TextStyle(
                    color: request['impact'] == 'Low' ? Colors.green : Colors.orange,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        setState(() => _leaveRequests.removeAt(index));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Request rejected')),
                        );
                      },
                      child: const Text('Reject'),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        setState(() => _leaveRequests.removeAt(index));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Request approved')),
                        );
                      },
                      child: const Text('Approve'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSwapRequestsTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: _swapRequests.length,
      itemBuilder: (context, index) {
        final request = _swapRequests[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${request['from']} ⇄ ${request['to']}',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 8),
                Text('Date: ${request['date']}'),
                Text('Shift: ${request['shift']}'),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        setState(() => _swapRequests.removeAt(index));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Swap rejected')),
                        );
                      },
                      child: const Text('Reject'),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        setState(() => _swapRequests.removeAt(index));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Swap approved')),
                        );
                      },
                      child: const Text('Approve'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}