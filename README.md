# LoginApp - Clínica Dental Sonrisas

Aplicación móvil en Flutter para simular el acceso de pacientes y administradores de una clínica dental. El Sprint 2 agrega autenticación local por rol, navegación a dashboards y citas de prueba para el paciente.

## Funcionalidades

- Inicio de sesión local con cuentas de demostración.
- Enrutamiento a un panel distinto según el rol del usuario.
- Panel del paciente con próximas citas cargadas desde datos mock.
- Panel inicial de administración. El listado de pacientes se conectará al backend en el Sprint 3.
- Cierre de sesión que limpia la navegación anterior.
- Tarjeta demostrativa de carnet digital controlada por `kHabilitarCarnetQR`.
- Pruebas unitarias del inicio de sesión y pruebas de widgets para los flujos de la interfaz.

## Cuentas de demostración

| Rol | Correo | Contraseña |
| --- | --- | --- |
| Paciente | `paciente@test.com` | `Paciente123` |
| Administrador | `admin@test.com` | `Admin123` |

La autenticación y las citas son simuladas en memoria. No existe conexión a una base de datos ni persistencia de sesión; el backend se integra en un sprint posterior.

## Estructura

```text
lib/
├── config/app_config.dart
├── data/
│   ├── mock_appointments.dart
│   └── mock_auth_repository.dart
├── models/app_user.dart
├── screens/
│   ├── admin_dashboard.dart
│   ├── login_screen.dart
│   └── patient_dashboard.dart
├── main.dart
└── validar_correo.dart
test/
├── mock_auth_repository_test.dart
├── validar_correo_test.dart
└── widget_test.dart
```

## Ejecución local

Con Flutter instalado, ejecuta:

```bash
flutter pub get
flutter run
flutter analyze
flutter test
```

## Integración continua

El flujo `.github/workflows/ci.yml` se ejecuta en los Pull Requests hacia `main` y en los cambios a `main`. Descarga dependencias, analiza el proyecto y ejecuta las pruebas unitarias y de widgets.

El repositorio sigue GitHub Flow: los cambios se trabajan en una rama `feature/*` y se envían a `main` mediante Pull Request y revisión por pares.
