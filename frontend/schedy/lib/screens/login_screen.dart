// lib/screens/login_screen.dart - WITH DEPARTMENT SELECTION

import 'package:flutter/material.dart';
import '../admin/admin_dashboard.dart';
import '../manager/manager_dashboard.dart';
import '../staff/staff_dashboard.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String _selectedRole = 'staff';
  String? _selectedDepartment;

  final List<String> _departments = [
    'Emergency',
    'ICU',
    'Surgery',
    'Pediatrics',
    'Radiology',
    'Cardiology',
    'Neurology',
    'Orthopedics',
  ];

  bool get _showDepartmentSelection => _selectedRole != 'admin';

  void _login() {
    if (_formKey.currentState!.validate()) {
      // Check department selection for non-admin roles
      if (_showDepartmentSelection && _selectedDepartment == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select your department'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      Widget destination;
      switch (_selectedRole) {
        case 'admin':
          destination = const AdminDashboard();
          break;
        case 'manager':
          destination = const ManagerDashboard();
          break;
        case 'staff':
        default:
          destination = const StaffDashboard();
      }

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => destination),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.local_hospital,
                    size: 80,
                    color: Colors.blue[700],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Hospital Shift Manager',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Role Selection
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: Column(
                      children: [
                        RadioListTile<String>(
                          title: const Text('Admin'),
                          value: 'admin',
                          groupValue: _selectedRole,
                          onChanged: (value) => setState(() {
                            _selectedRole = value!;
                            _selectedDepartment = null; // Reset department
                          }),
                        ),
                        const Divider(height: 1),
                        RadioListTile<String>(
                          title: const Text('Manager / HOD'),
                          value: 'manager',
                          groupValue: _selectedRole,
                          onChanged: (value) => setState(() => _selectedRole = value!),
                        ),
                        const Divider(height: 1),
                        RadioListTile<String>(
                          title: const Text('Staff'),
                          value: 'staff',
                          groupValue: _selectedRole,
                          onChanged: (value) => setState(() => _selectedRole = value!),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Department Selection (only for Manager and Staff)
                  if (_showDepartmentSelection) ...[
                    DropdownButtonFormField<String>(
                      value: _selectedDepartment,
                      decoration: InputDecoration(
                        labelText: 'Department',
                        prefixIcon: const Icon(Icons.business),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      hint: const Text('Select your department'),
                      items: _departments.map((dept) {
                        return DropdownMenuItem(
                          value: dept,
                          child: Text(dept),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() => _selectedDepartment = value);
                      },
                    ),
                    const SizedBox(height: 16),
                  ],

                  // Email Field
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      prefixIcon: const Icon(Icons.email),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Password Field
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: const Icon(Icons.lock),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),

                  // Login Button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _login,
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Login',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}