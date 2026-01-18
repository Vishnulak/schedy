// lib/manager/schedule_generation_screen.dart - WITH HRS VALIDATION

import 'package:flutter/material.dart';

class ScheduleGenerationScreen extends StatefulWidget {
  const ScheduleGenerationScreen({Key? key}) : super(key: key);

  @override
  State<ScheduleGenerationScreen> createState() => _ScheduleGenerationScreenState();
}

class _ScheduleGenerationScreenState extends State<ScheduleGenerationScreen> {
  String _selectedPeriod = 'weekly';
  bool _isGenerating = false;

  void _generateSchedule() {
    setState(() => _isGenerating = true);

    Future.delayed(const Duration(seconds: 2), () {
      setState(() => _isGenerating = false);
      Navigator.pushNamed(context, '/schedule-review'); // Would navigate to review
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Schedule generated - Review for HRS warnings'),
          backgroundColor: Colors.green,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Generate Schedule')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Period Selection
            Text(
              'Select Period',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            Card(
              child: Column(
                children: [
                  RadioListTile<String>(
                    title: const Text('Weekly'),
                    subtitle: const Text('Next 7 days'),
                    value: 'weekly',
                    groupValue: _selectedPeriod,
                    onChanged: (value) => setState(() => _selectedPeriod = value!),
                  ),
                  const Divider(height: 1),
                  RadioListTile<String>(
                    title: const Text('Monthly'),
                    subtitle: const Text('Next 30 days'),
                    value: 'monthly',
                    groupValue: _selectedPeriod,
                    onChanged: (value) => setState(() => _selectedPeriod = value!),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Pre-Generation Validation
            Text(
              'Pre-Generation Check',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildConstraintItem('Staff Available', '42/45', true),
                    const Divider(),
                    _buildConstraintItem('Approved Leaves', '3', true),
                    const Divider(),
                    _buildConstraintItem('Skill Coverage', 'Adequate', true),
                    const Divider(),
                    _buildConstraintItem('HRS Compliant', 'Yes', true),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // HRS Info
            Card(
              color: Colors.blue[50],
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    Icon(Icons.info, color: Colors.blue[700]),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Text(
                        'System will auto-check HRS limits and flag unsafe assignments',
                        style: TextStyle(fontSize: 13),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),

            // Generate Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _isGenerating ? null : _generateSchedule,
                child: _isGenerating
                    ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
                    : const Text(
                  'Generate Schedule',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildConstraintItem(String label, String value, bool isValid) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                isValid ? Icons.check_circle : Icons.error,
                color: isValid ? Colors.green : Colors.red,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(label),
            ],
          ),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}