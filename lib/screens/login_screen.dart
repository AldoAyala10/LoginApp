import 'package:flutter/material.dart';

import '../data/mock_auth_repository.dart';
import '../models/app_user.dart';
import '../validar_correo.dart';
import 'admin_dashboard.dart';
import 'patient_dashboard.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    super.key,
    this.authRepository = const MockAuthRepository(),
  });

  final MockAuthRepository authRepository;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? _errorMessage;
  bool _hidePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _fillDemoCredentials({required bool administrator}) {
    _emailController.text = administrator
        ? 'admin@test.com'
        : 'paciente@test.com';
    _passwordController.text = administrator ? 'Admin123' : 'Paciente123';
    setState(() => _errorMessage = null);
  }

  void _signIn() {
    final email = _emailController.text.trim();
    if (!validarCorreo(email)) {
      setState(() => _errorMessage = 'Ingresa un correo electrónico válido.');
      return;
    }

    final user = widget.authRepository.authenticate(
      email: email,
      password: _passwordController.text,
    );

    if (user == null) {
      setState(() => _errorMessage = 'Correo o contraseña incorrectos.');
      return;
    }

    setState(() => _errorMessage = null);
    final Widget dashboard = user.role == UserRole.administrator
        ? AdminDashboard(user: user)
        : PatientDashboard(user: user);

    // Se limpia el historial para que Atrás no permita volver a la sesión anterior.
    Navigator.of(context).pushAndRemoveUntil<void>(
      MaterialPageRoute<void>(builder: (_) => dashboard),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 440),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Icon(
                    Icons.medical_services_rounded,
                    color: Color(0xFF0284C7),
                    size: 58,
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Clínica Dental Sonrisas',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Inicia sesión para consultar tu información',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.blueGrey.shade700),
                  ),
                  const SizedBox(height: 28),
                  Card(
                    color: Colors.white,
                    elevation: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(22),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text(
                            'Correo electrónico',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 8),
                          TextField(
                            key: const ValueKey('emailField'),
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            autocorrect: false,
                            decoration: const InputDecoration(
                              hintText: 'ejemplo@correo.com',
                              prefixIcon: Icon(Icons.email_outlined),
                            ),
                          ),
                          const SizedBox(height: 18),
                          const Text(
                            'Contraseña',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 8),
                          TextField(
                            key: const ValueKey('passwordField'),
                            controller: _passwordController,
                            obscureText: _hidePassword,
                            onSubmitted: (_) => _signIn(),
                            decoration: InputDecoration(
                              hintText: 'Contraseña',
                              prefixIcon: const Icon(Icons.lock_outline),
                              suffixIcon: IconButton(
                                tooltip: _hidePassword
                                    ? 'Mostrar contraseña'
                                    : 'Ocultar contraseña',
                                onPressed: () => setState(
                                  () => _hidePassword = !_hidePassword,
                                ),
                                icon: Icon(
                                  _hidePassword
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                              ),
                            ),
                          ),
                          if (_errorMessage != null) ...[
                            const SizedBox(height: 12),
                            Text(
                              _errorMessage!,
                              key: const ValueKey('loginError'),
                              style: const TextStyle(color: Colors.red),
                            ),
                          ],
                          const SizedBox(height: 22),
                          FilledButton.icon(
                            key: const ValueKey('loginButton'),
                            onPressed: _signIn,
                            icon: const Icon(Icons.login),
                            label: const Text('Iniciar sesión'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  Card(
                    color: const Color(0xFFE0F2FE),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Cuentas de demostración',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Paciente: paciente@test.com / Paciente123',
                          ),
                          const Text(
                            'Administrador: admin@test.com / Admin123',
                          ),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 8,
                            children: [
                              TextButton(
                                onPressed: () =>
                                    _fillDemoCredentials(administrator: false),
                                child: const Text('Usar paciente'),
                              ),
                              TextButton(
                                onPressed: () =>
                                    _fillDemoCredentials(administrator: true),
                                child: const Text('Usar administrador'),
                              ),
                            ],
                          ),
                        ],
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
}
