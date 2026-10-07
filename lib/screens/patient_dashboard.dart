import 'package:flutter/material.dart';

import '../config/app_config.dart';
import '../data/mock_appointments.dart';
import '../models/app_user.dart';
import 'login_screen.dart';

class PatientDashboard extends StatefulWidget {
  const PatientDashboard({super.key, required this.user});

  final AppUser user;

  @override
  State<PatientDashboard> createState() => _PatientDashboardState();
}

class _PatientDashboardState extends State<PatientDashboard> {
  bool _qrEnabled = kHabilitarCarnetQR;

  void _signOut(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil<void>(
      MaterialPageRoute<void>(builder: (_) => const LoginScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final appointments = mockAppointments();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Panel del paciente'),
        actions: [
          IconButton(
            key: const ValueKey('logoutButton'),
            tooltip: 'Cerrar sesión',
            onPressed: () => _signOut(context),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text(
              'Hola, ${widget.user.name}',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              widget.user.email,
              style: TextStyle(color: Colors.blueGrey.shade700),
            ),
            const SizedBox(height: 24),
            Text(
              'Próximas citas',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 10),
            for (final appointment in appointments)
              Card(
                color: Colors.white,
                child: ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Color(0xFFE0F2FE),
                    child: Icon(Icons.calendar_month, color: Color(0xFF0284C7)),
                  ),
                  title: Text(appointment.service),
                  subtitle: Text(
                    '${appointment.professional}\n${appointment.dateLabel}',
                  ),
                  isThreeLine: true,
                  trailing: Text(
                    appointment.timeLabel,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            if (kHabilitarCarnetQR) ...[
              const SizedBox(height: 12),
              Card(
                color: const Color(0xFFE0F2FE),
                child: SwitchListTile(
                  key: const ValueKey('qrFeatureSwitch'),
                  secondary: const Icon(
                    Icons.qr_code_2,
                    color: Color(0xFF0284C7),
                  ),
                  title: const Text('Carnet digital'),
                  subtitle: Text(
                    _qrEnabled
                        ? 'Función de demostración habilitada'
                        : 'Función de demostración desactivada',
                  ),
                  value: _qrEnabled,
                  onChanged: (value) => setState(() => _qrEnabled = value),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
