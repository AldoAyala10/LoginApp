import 'package:flutter/material.dart';

import '../models/app_user.dart';
import 'login_screen.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key, required this.user});

  final AppUser user;

  void _signOut(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil<void>(
      MaterialPageRoute<void>(builder: (_) => const LoginScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Panel de administración'),
        actions: [
          IconButton(
            key: const ValueKey('logoutButton'),
            tooltip: 'Cerrar sesión',
            onPressed: () => _signOut(context),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            'Bienvenido, ${user.name}',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 20),
          Card(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.admin_panel_settings_outlined,
                    color: Color(0xFF0284C7),
                    size: 36,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Gestión de pacientes',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Este panel inicial confirma el acceso del administrador. '
                    'El listado y la gestión de pacientes se conectarán al '
                    'backend en el Sprint 3.',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
