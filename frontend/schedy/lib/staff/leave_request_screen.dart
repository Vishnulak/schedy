// lib/staff/leave_request_screen.dart - NO TABS, SINGLE FLOW

import 'package:flutter/material.dart';

class LeaveRequestScreen extends StatefulWidget {
  const LeaveRequestScreen({Key? key}) : super(key: key);

  @override
  State<LeaveRequestScreen> createState() => _LeaveRequestScreenState();
}

class _LeaveRequestScreenState extends State<LeaveRequestScreen> {
  final _formKey = GlobalKey<FormState>();
  DateTime? _startDate;
  DateTime? _endDate;
  final _reasonController = TextEditingController();
  String _leaveType = 'Personal';

  final List<Map<String, dynamic>> _myRequests = [
    {'dates': 'Jan 30 - Feb 1', 'reason': 'Personal', 'status': 'Pending', 'type': 'Personal', 'days': 3},
    {'dates': 'Feb 15', 'reason': 'Medical', 'status': 'Approved', 'type': 'Medical', 'days': 1},
  ];

  void _selectStartDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (date != null) setState(() => _startDate = date);
  }

  void _selectEndDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _startDate ?? DateTime.now().add(const Duration(days: 1)),
      firstDate: _startDate ?? DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (date != null) setState(() => _endDate = date);
  }

  void _submitRequest() {
    if (_formKey.currentState!.validate() && _startDate != null && _endDate != null) {
      setState(() {
        _myRequests.insert(0, {
          'dates': '${_startDate!.day}/${_startDate!.month} - ${_endDate!.day}/${_endDate!.month}',
          'reason': _reasonController.text,
          'status': 'Pending',
          'type': _leaveType,
          'days': _endDate!.difference(_startDate!).inDays + 1,
        });
      });

      _startDate = null;
      _endDate = null;
      _reasonController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Leave request submitted - Manager will review'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Leave Request')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            // Apply Section
            Text(
              'Apply for Leave',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Submit at least 7 days in advance',
              style: TextStyle(color: Colors.grey[600], fontSize: 13),
            ),
            const SizedBox(height: 16),

            // Leave Type
            Card(
              child: Column(
                children: [
                  RadioListTile<String>(
                    title: const Text('Personal Leave'),
                    value: 'Personal',
                    groupValue: _leaveType,
                    onChanged: (v) => setState(() => _leaveType = v!),
                  ),
                  RadioListTile<String>(
                    title: const Text('Medical Leave'),
                    value: 'Medical',
                    groupValue: _leaveType,
                    onChanged: (v) => setState(() => _leaveType = v!),
                  ),
                  RadioListTile<String>(
                    title: const Text('Emergency Leave'),
                    value: 'Emergency',
                    groupValue: _leaveType,
                    onChanged: (v) => setState(() => _leaveType = v!),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Dates
            Card(
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.calendar_today),
                    title: const Text('Start Date'),
                    subtitle: Text(_startDate != null
                        ? '${_startDate!.day}/${_startDate!.month}/${_startDate!.year}'
                        : 'Select start date'),
                    onTap: _selectStartDate,
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.event),
                    title: const Text('End Date'),
                    subtitle: Text(_endDate != null
                        ? '${_endDate!.day}/${_endDate!.month}/${_endDate!.year}'
                        : 'Select end date'),
                    onTap: _selectEndDate,
                  ),
                ],
              ),
            ),

            if (_startDate != null && _endDate != null) ...[
              const SizedBox(height: 8),
              Card(
                color: Colors.green[50],
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    'Total: ${_endDate!.difference(_startDate!).inDays + 1} days',
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green[900]),
                  ),
                ),
              ),
            ],
            const SizedBox(height: 16),

            // Reason
            TextFormField(
              controller: _reasonController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Reason',
                hintText: 'Explain your leave request...',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
              ),
              validator: (v) => v == null || v.isEmpty ? 'Please enter reason' : null,
            ),
            const SizedBox(height: 24),

            // Submit Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _submitRequest,
                child: const Text('Submit Request', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 32),

            // My Requests History
            Text(
              'My Requests',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            ..._myRequests.map((req) {
              Color statusColor = req['status'] == 'Approved'
                  ? Colors.green
                  : req['status'] == 'Rejected'
                  ? Colors.red
                  : Colors.orange;

              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: statusColor.withOpacity(0.2),
                    child: Icon(
                      req['status'] == 'Approved'
                          ? Icons.check_circle
                          : req['status'] == 'Rejected'
                          ? Icons.cancel
                          : Icons.pending,
                      color: statusColor,
                    ),
                  ),
                  title: Text(req['dates'], style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text('${req['type']} • ${req['days']} days\n${req['reason']}'),
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
                  isThreeLine: true,
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }
}