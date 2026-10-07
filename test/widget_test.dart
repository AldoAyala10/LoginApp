import 'package:flutter_test/flutter_test.dart';
import 'package:login_app/main.dart';

void main() {
  Future<void> signIn(
    WidgetTester tester, {
    required String email,
    required String password,
  }) async {
    await tester.pumpWidget(const LoginApp());
    await tester.enterText(find.byKey(const ValueKey('emailField')), email);
    await tester.enterText(
      find.byKey(const ValueKey('passwordField')),
      password,
    );
    await tester.tap(find.byKey(const ValueKey('loginButton')));
    await tester.pumpAndSettle();
  }

  testWidgets('el paciente llega a su dashboard con citas mock', (tester) async {
    await signIn(
      tester,
      email: 'paciente@test.com',
      password: 'Paciente123',
    );

    expect(find.text('Panel del paciente'), findsOneWidget);
    expect(find.text('Próximas citas'), findsOneWidget);
    expect(find.text('Limpieza dental'), findsOneWidget);
    expect(find.text('Revisión general'), findsOneWidget);
    expect(find.text('Carnet digital'), findsOneWidget);
  });

  testWidgets('el administrador llega al panel administrativo', (tester) async {
    await signIn(tester, email: 'admin@test.com', password: 'Admin123');

    expect(find.text('Panel de administración'), findsOneWidget);
    expect(find.text('Gestión de pacientes'), findsOneWidget);
    expect(
      find.text(
        'Este panel inicial confirma el acceso del administrador. '
        'El listado y la gestión de pacientes se conectarán al backend en '
        'el Sprint 3.',
      ),
      findsOneWidget,
    );
  });

  testWidgets('rechaza credenciales incorrectas sin salir del login', (
    tester,
  ) async {
    await signIn(tester, email: 'paciente@test.com', password: 'incorrecta');

    expect(find.text('Correo o contraseña incorrectos.'), findsOneWidget);
    expect(find.text('Panel del paciente'), findsNothing);
    expect(find.text('Panel de administración'), findsNothing);
  });

  testWidgets('cerrar sesión limpia la ruta y vuelve al login', (tester) async {
    await signIn(
      tester,
      email: 'paciente@test.com',
      password: 'Paciente123',
    );

    await tester.tap(find.byKey(const ValueKey('logoutButton')));
    await tester.pumpAndSettle();

    expect(find.text('Clínica Dental Sonrisas'), findsOneWidget);
    expect(find.text('Panel del paciente'), findsNothing);
  });
}
