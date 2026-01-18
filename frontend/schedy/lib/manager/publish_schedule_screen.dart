// FILE: lib/manager/publish_schedule_screen.dart

import 'package:flutter/material.dart';

class PublishScheduleScreen extends StatefulWidget {
  const PublishScheduleScreen({Key? key}) : super(key: key);

  @override
  State<PublishScheduleScreen> createState() => _PublishScheduleScreenState();
}

class _PublishScheduleScreenState extends State<PublishScheduleScreen> {
  bool _isPublishing = false;

  void _publishSchedule() {
    setState(() => _isPublishing = true);

    Future.delayed(const Duration(seconds: 2), () {
      setState(() => _isPublishing = false);
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Success'),
          content: const Text('Schedule published and staff notified!'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Publish Schedule'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Final Validation',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            Card(
              color: Colors.green[50],
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    _buildValidationItem('All shifts covered', true),
                    const Divider(),
                    _buildValidationItem('HRS limits respected', true),
                    const Divider(),
                    _buildValidationItem('Skill requirements met', true),
                    const Divider(),
                    _buildValidationItem('No conflicts detected', true),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Schedule Summary',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 12),
                    Text('Period: Jan 25 - Jan 31, 2026'),
                    Text('Total Shifts: 126'),
                    Text('Staff Members: 42'),
                    Text('Coverage: 100%'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            Card(
              child: CheckboxListTile(
                title: const Text('Notify all staff via email and app'),
                value: true,
                onChanged: (value) {},
              ),
            ),
            const Spacer(),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _isPublishing ? null : _publishSchedule,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                child: _isPublishing
                    ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
                    : const Text(
                  'Publish Schedule',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildValidationItem(String label, bool isValid) {
    return Row(
      children: [
        Icon(
          isValid ? Icons.check_circle : Icons.error,
          color: isValid ? Colors.green : Colors.red,
        ),
        const SizedBox(width: 12),
        Expanded(child: Text(label)),
      ],
    );
  }
}