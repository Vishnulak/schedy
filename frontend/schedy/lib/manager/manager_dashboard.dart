// ============================================
// MANAGER SECTION
// ============================================

// FILE: lib/manager/manager_dashboard.dart

import 'package:flutter/material.dart';
import '../screens/login_screen.dart';
import 'department_overview_screen.dart';
import 'shift_configuration_screen.dart';
import 'leave_swap_requests_screen.dart';
import 'schedule_generation_screen.dart';
import 'schedule_review_screen.dart';
import 'publish_schedule_screen.dart';
import 'emergency_management_screen.dart';
import 'reports_insights_screen.dart';

class ManagerDashboard extends StatelessWidget {
  const ManagerDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manager Dashboard'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) => const LoginScreen()),
                  (route) => false,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Today\'s Overview',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            _buildShiftCoverageCard(),
            const SizedBox(height: 12),
            _buildRiskAlertsCard(),
            const SizedBox(height: 12),
            _buildPendingApprovalsCard(),
            const SizedBox(height: 24),

            Text(
              'Quick Actions',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.1,
              children: [
                _buildActionCard(
                  context,
                  'Department',
                  Icons.people,
                  Colors.blue,
                      () => Navigator.push(context, MaterialPageRoute(builder: (_) => const DepartmentOverviewScreen())),
                ),
                _buildActionCard(
                  context,
                  'Shifts',
                  Icons.schedule,
                  Colors.purple,
                      () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ShiftConfigurationScreen())),
                ),
                _buildActionCard(
                  context,
                  'Requests',
                  Icons.approval,
                  Colors.orange,
                      () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LeaveSwapRequestsScreen())),
                ),
                _buildActionCard(
                  context,
                  'Generate',
                  Icons.calendar_month,
                  Colors.green,
                      () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ScheduleGenerationScreen())),
                ),
                _buildActionCard(
                  context,
                  'Review',
                  Icons.edit_calendar,
                  Colors.teal,
                      () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ScheduleReviewScreen())),
                ),
                _buildActionCard(
                  context,
                  'Publish',
                  Icons.publish,
                  Colors.indigo,
                      () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PublishScheduleScreen())),
                ),
                _buildActionCard(
                  context,
                  'Emergency',
                  Icons.emergency,
                  Colors.red,
                      () => Navigator.push(context, MaterialPageRoute(builder: (_) => const EmergencyManagementScreen())),
                ),
                _buildActionCard(
                  context,
                  'Reports',
                  Icons.analytics,
                  Colors.cyan,
                      () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ReportsInsightsScreen())),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShiftCoverageCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.check_circle, color: Colors.green[600]),
                const SizedBox(width: 8),
                const Text(
                  'Shift Coverage',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildCoverageItem('Morning', '12/12', Colors.green),
                _buildCoverageItem('Evening', '10/12', Colors.orange),
                _buildCoverageItem('Night', '8/10', Colors.green),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCoverageItem(String shift, String coverage, Color color) {
    return Column(
      children: [
        Text(shift, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        const SizedBox(height: 4),
        Text(
          coverage,
          style: TextStyle(fontWeight: FontWeight.bold, color: color, fontSize: 16),
        ),
      ],
    );
  }

  Widget _buildRiskAlertsCard() {
    return Card(
      color: Colors.orange[50],
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(Icons.warning, color: Colors.orange[700]),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Risk Alerts',
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.orange[900]),
                  ),
                  const SizedBox(height: 4),
                  const Text('2 staff members approaching HRS limits'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPendingApprovalsCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(Icons.pending_actions, color: Colors.blue[700]),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Pending Approvals',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text('5 leave requests • 2 swap requests'),
                ],
              ),
            ),
            const Icon(Icons.chevron_right),
          ],
        ),
      ),
    );
  }

  Widget _buildActionCard(
      BuildContext context,
      String title,
      IconData icon,
      Color color,
      VoidCallback onTap,
      ) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: color),
              const SizedBox(height: 8),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}