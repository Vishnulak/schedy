// lib/staff/staff_dashboard.dart - SIMPLIFIED VERSION

import 'package:flutter/material.dart';
import 'my_schedule_screen.dart';
import 'availability_management_screen.dart';
import 'leave_request_screen.dart';
import 'shift_swap_screen.dart';
import 'emergency_unavailability_screen.dart';
import 'clock_in_out_screen.dart';
import 'profile_certifications_screen.dart';
import '../screens/login_screen.dart';

class StaffDashboard extends StatelessWidget {
  const StaffDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Dashboard'),
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
            // Welcome
            Text(
              'Welcome back, Sarah!',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

            // ONLY Next Shift - Most Important
            Card(
              color: Colors.blue[50],
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.schedule, color: Colors.blue[700], size: 28),
                        const SizedBox(width: 8),
                        const Text(
                          'Next Shift',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text('Tomorrow, Jan 26', style: TextStyle(fontSize: 16)),
                    const Text(
                      'Morning: 7:00 AM - 3:00 PM',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 4),
                    const Text('Emergency Department', style: TextStyle(fontSize: 14)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),

            // HRS Status - Simple indicator
            Card(
              color: Colors.green[50],
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Icon(Icons.health_and_safety, color: Colors.green[700], size: 24),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'HRS Status: GOOD',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          const SizedBox(height: 4),
                          const Text('32/48 hours this week'),
                          const SizedBox(height: 6),
                          LinearProgressIndicator(
                            value: 32 / 48,
                            backgroundColor: Colors.green[100],
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.green[600]!),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Quick Actions Grid
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
              childAspectRatio: 1.2,
              children: [
                _buildActionCard(
                  context,
                  'My Schedule',
                  Icons.calendar_today,
                  Colors.blue,
                      () => Navigator.push(context, MaterialPageRoute(builder: (_) => const MyScheduleScreen())),
                ),
                _buildActionCard(
                  context,
                  'Clock In/Out',
                  Icons.access_time,
                  Colors.green,
                      () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ClockInOutScreen())),
                ),
                _buildActionCard(
                  context,
                  'Availability',
                  Icons.event_available,
                  Colors.purple,
                      () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AvailabilityManagementScreen())),
                ),
                _buildActionCard(
                  context,
                  'Leave Request',
                  Icons.beach_access,
                  Colors.orange,
                      () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LeaveRequestScreen())),
                ),
                _buildActionCard(
                  context,
                  'Shift Swap',
                  Icons.swap_horiz,
                  Colors.teal,
                      () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ShiftSwapScreen())),
                ),
                _buildActionCard(
                  context,
                  'Emergency',
                  Icons.emergency,
                  Colors.red,
                      () => Navigator.push(context, MaterialPageRoute(builder: (_) => const EmergencyUnavailabilityScreen())),
                ),
              ],
            ),
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
              Icon(icon, size: 36, color: color),
              const SizedBox(height: 8),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
              ),
            ],
          ),
        ),
      ),
    );
  }
}