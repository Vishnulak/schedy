// FILE: lib/admin/admin_dashboard.dart

import 'package:flutter/material.dart';
import '../screens/login_screen.dart';
import 'hospital_settings_screen.dart';
import 'department_management_screen.dart';
import 'role_access_screen.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
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
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    'Total Departments',
                    '8',
                    Icons.apartment,
                    Colors.blue,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildStatCard(
                    'Total Staff',
                    '245',
                    Icons.people,
                    Colors.green,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    'Compliance Alerts',
                    '3',
                    Icons.warning,
                    Colors.orange,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildStatCard(
                    'System Health',
                    'Good',
                    Icons.health_and_safety,
                    Colors.teal,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            Text(
              'Management',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            _buildMenuItem(
              context,
              'Hospital Settings',
              'Configure policies and working hours',
              Icons.settings,
                  () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const HospitalSettingsScreen()),
              ),
            ),
            const SizedBox(height: 12),
            _buildMenuItem(
              context,
              'Department Management',
              'Create and manage departments',
              Icons.business,
                  () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const DepartmentManagementScreen()),
              ),
            ),
            const SizedBox(height: 12),
            _buildMenuItem(
              context,
              'Role & Access Control',
              'Define roles and permissions',
              Icons.security,
                  () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const RoleAccessScreen()),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Icon(icon, size: 40, color: color),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(
      BuildContext context,
      String title,
      String subtitle,
      IconData icon,
      VoidCallback onTap,
      ) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blue[100],
          child: Icon(icon, color: Colors.blue[700]),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}