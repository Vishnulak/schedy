// FILE: lib/manager/reports_insights_screen.dart

import 'package:flutter/material.dart';

class ReportsInsightsScreen extends StatelessWidget {
  const ReportsInsightsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reports & Insights'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildMetricCard(
            'Coverage Metrics',
            Icons.analytics,
            Colors.blue,
            [
              'Average Coverage: 98%',
              'Peak Hours: 92% covered',
              'Off Hours: 100% covered',
            ],
          ),
          const SizedBox(height: 16),
          _buildMetricCard(
            'Overtime Statistics',
            Icons.timer,
            Colors.orange,
            [
              'Total Overtime: 45 hours',
              'Average per Staff: 1.2h/week',
              'Highest: 4.5h (Sarah Johnson)',
            ],
          ),
          const SizedBox(height: 16),
          _buildMetricCard(
            'Burnout Trends',
            Icons.trending_up,
            Colors.red,
            [
              'At Risk: 3 staff members',
              'Amber Status: 5 staff members',
              'Green Status: 37 staff members',
            ],
          ),
          const SizedBox(height: 16),
          _buildMetricCard(
            'Absence Patterns',
            Icons.event_busy,
            Colors.purple,
            [
              'Average Absences: 2.1%',
              'Most Common: Personal (45%)',
              'Emergency: 12%',
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard(
      String title,
      IconData icon,
      Color color,
      List<String> metrics,
      ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 28),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...metrics.map((metric) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  Icon(Icons.circle, size: 8, color: color.withOpacity(0.7)),
                  const SizedBox(width: 12),
                  Text(metric),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}