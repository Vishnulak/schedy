// ============================================
// FILE: lib/staff/availability_management_screen.dart
// ============================================

import 'package:flutter/material.dart';

class AvailabilityManagementScreen extends StatefulWidget {
  const AvailabilityManagementScreen({Key? key}) : super(key: key);

  @override
  State<AvailabilityManagementScreen> createState() =>
      _AvailabilityManagementScreenState();
}

class _AvailabilityManagementScreenState
    extends State<AvailabilityManagementScreen> {
  final List<DateTime> _unavailableDates = [];
  String _preferredShift = 'Morning';
  final Set<String> _preferredDays = {'Monday', 'Tuesday', 'Wednesday'};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Availability Management'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Info Card
          Card(
            color: Colors.blue[50],
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Icon(Icons.info, color: Colors.blue[700]),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      'Your availability preferences help us create better schedules for you.',
                      style: TextStyle(fontSize: 13),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          Text(
            'Mark Unavailable Dates',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Select dates when you are not available to work',
            style: TextStyle(color: Colors.grey[600], fontSize: 13),
          ),
          const SizedBox(height: 16),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CalendarDatePicker(
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 90)),
                onDateChanged: (date) {
                  setState(() {
                    if (_unavailableDates.any((d) =>
                    d.year == date.year &&
                        d.month == date.month &&
                        d.day == date.day)) {
                      _unavailableDates.removeWhere((d) =>
                      d.year == date.year &&
                          d.month == date.month &&
                          d.day == date.day);
                    } else {
                      _unavailableDates.add(date);
                    }
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Date ${date.day}/${date.month} marked as unavailable',
                      ),
                      duration: const Duration(seconds: 1),
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 24),

          Text(
            'Preferred Shift',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Select your preferred shift timing',
            style: TextStyle(color: Colors.grey[600], fontSize: 13),
          ),
          const SizedBox(height: 16),

          Card(
            child: Column(
              children: [
                RadioListTile<String>(
                  title: const Text('Morning'),
                  subtitle: const Text('7:00 AM - 3:00 PM'),
                  value: 'Morning',
                  groupValue: _preferredShift,
                  onChanged: (value) => setState(() => _preferredShift = value!),
                ),
                const Divider(height: 1),
                RadioListTile<String>(
                  title: const Text('Evening'),
                  subtitle: const Text('3:00 PM - 11:00 PM'),
                  value: 'Evening',
                  groupValue: _preferredShift,
                  onChanged: (value) => setState(() => _preferredShift = value!),
                ),
                const Divider(height: 1),
                RadioListTile<String>(
                  title: const Text('Night'),
                  subtitle: const Text('11:00 PM - 7:00 AM'),
                  value: 'Night',
                  groupValue: _preferredShift,
                  onChanged: (value) => setState(() => _preferredShift = value!),
                ),
                const Divider(height: 1),
                RadioListTile<String>(
                  title: const Text('No Preference'),
                  subtitle: const Text('Available for any shift'),
                  value: 'No Preference',
                  groupValue: _preferredShift,
                  onChanged: (value) => setState(() => _preferredShift = value!),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          Text(
            'Preferred Days',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Select days you prefer to work',
            style: TextStyle(color: Colors.grey[600], fontSize: 13),
          ),
          const SizedBox(height: 16),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Wrap(
                spacing: 8,
                children: [
                  'Monday',
                  'Tuesday',
                  'Wednesday',
                  'Thursday',
                  'Friday',
                  'Saturday',
                  'Sunday'
                ].map((day) {
                  final isSelected = _preferredDays.contains(day);
                  return FilterChip(
                    label: Text(day),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        if (selected) {
                          _preferredDays.add(day);
                        } else {
                          _preferredDays.remove(day);
                        }
                      });
                    },
                  );
                }).toList(),
              ),
            ),
          ),
          const SizedBox(height: 32),

          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Availability updated successfully'),
                    backgroundColor: Colors.green,
                  ),
                );
                Navigator.pop(context);
              },
              child: const Text(
                'Save Availability',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
