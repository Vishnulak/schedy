// ============================================
// FILE: lib/staff/profile_certifications_screen.dart
// ============================================

import 'package:flutter/material.dart';

class ProfileCertificationsScreen extends StatefulWidget {
  const ProfileCertificationsScreen({Key? key}) : super(key: key);

  @override
  State<ProfileCertificationsScreen> createState() =>
      _ProfileCertificationsScreenState();
}

class _ProfileCertificationsScreenState
    extends State<ProfileCertificationsScreen> {
  final List<Map<String, dynamic>> _skills = [
    {
      'name': 'Registered Nurse (RN)',
      'expiry': 'Dec 2026',
      'status': 'Active',
      'issued': 'Dec 2021'
    },
    {
      'name': 'BLS Certification',
      'expiry': 'Jun 2025',
      'status': 'Expiring Soon',
      'issued': 'Jun 2023'
    },
    {
      'name': 'ACLS Certification',
      'expiry': 'Aug 2025',
      'status': 'Active',
      'issued': 'Aug 2023'
    },
    {
      'name': 'PALS Certification',
      'expiry': 'Nov 2026',
      'status': 'Active',
      'issued': 'Nov 2024'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile & Certifications'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Edit profile')),
              );
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Profile Card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.blue[100],
                        child: Icon(
                          Icons.person,
                          size: 60,
                          color: Colors.blue[700],
                        ),
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: CircleAvatar(
                          radius: 18,
                          backgroundColor: Colors.blue,
                          child: IconButton(
                            icon: const Icon(Icons.camera_alt, size: 16),
                            color: Colors.white,
                            padding: EdgeInsets.zero,
                            onPressed: () {},
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Sarah Johnson',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Registered Nurse',
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Department: Emergency',
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 20),

                  // Stats Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildStatItem('Employee ID', 'EN-1234'),
                      Container(
                        height: 40,
                        width: 1,
                        color: Colors.grey[300],
                      ),
                      _buildStatItem('Experience', '5 years'),
                      Container(
                        height: 40,
                        width: 1,
                        color: Colors.grey[300],
                      ),
                      _buildStatItem('Rating', '4.8 ⭐'),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Contact Information
          Text(
            'Contact Information',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),

          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.email),
                  title: const Text('Email'),
                  subtitle: const Text('sarah.johnson@hospital.com'),
                  trailing: const Icon(Icons.copy, size: 20),
                  onTap: () {},
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.phone),
                  title: const Text('Phone'),
                  subtitle: const Text('+1 (555) 123-4567'),
                  trailing: const Icon(Icons.copy, size: 20),
                  onTap: () {},
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.location_on),
                  title: const Text('Address'),
                  subtitle: const Text('123 Main St, City, State 12345'),
                  trailing: const Icon(Icons.edit, size: 20),
                  onTap: () {},
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Certifications & Skills
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Certifications & Skills',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add_circle),
                color: Colors.blue,
                onPressed: () => _showAddCertificationDialog(),
              ),
            ],
          ),
          const SizedBox(height: 12),

          ..._skills.map((skill) {
            final isExpiring = skill['status'] == 'Expiring Soon';
            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              color: isExpiring ? Colors.orange[50] : null,
              child: ExpansionTile(
                leading: CircleAvatar(
                  backgroundColor: isExpiring ? Colors.orange[100] : Colors.green[100],
                  child: Icon(
                    Icons.verified,
                    color: isExpiring ? Colors.orange[700] : Colors.green[700],
                  ),
                ),
                title: Text(
                  skill['name']!,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Row(
                  children: [
                    Icon(
                      Icons.circle,
                      size: 8,
                      color: isExpiring ? Colors.orange : Colors.green,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'Expires: ${skill['expiry']}',
                      style: TextStyle(
                        color: isExpiring ? Colors.orange[900] : null,
                      ),
                    ),
                  ],
                ),
                trailing: isExpiring
                    ? Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    'Renew',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
                    : null,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildDetailRow('Issued', skill['issued']!),
                        const SizedBox(height: 8),
                        _buildDetailRow('Status', skill['status']!),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: () {},
                                icon: const Icon(Icons.upload_file, size: 20),
                                label: const Text('Upload'),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: () {},
                                icon: const Icon(Icons.visibility, size: 20),
                                label: const Text('View'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
          const SizedBox(height: 24),

          // Additional Settings
          Text(
            'Settings',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),

          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.notifications),
                  title: const Text('Notifications'),
                  trailing: Switch(
                    value: true,
                    onChanged: (value) {},
                  ),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.lock),
                  title: const Text('Change Password'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {},
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.language),
                  title: const Text('Language'),
                  subtitle: const Text('English'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {},
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(color: Colors.grey[600]),
        ),
        Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }

  void _showAddCertificationDialog() {
    final nameController = TextEditingController();
    final expiryController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Certification'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Certification Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: expiryController,
              decoration: const InputDecoration(
                labelText: 'Expiry Date',
                border: OutlineInputBorder(),
                hintText: 'MM/YYYY',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              nameController.dispose();
              expiryController.dispose();
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (nameController.text.isNotEmpty &&
                  expiryController.text.isNotEmpty) {
                setState(() {
                  _skills.add({
                    'name': nameController.text,
                    'expiry': expiryController.text,
                    'status': 'Active',
                    'issued': 'Recently Added',
                  });
                });
                nameController.dispose();
                expiryController.dispose();
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Certification added successfully'),
                    backgroundColor: Colors.green,
                  ),
                );
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}