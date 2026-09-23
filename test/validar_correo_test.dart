import 'package:flutter_test/flutter_test.dart';
import 'package:login_app/validar_correo.dart';

void main() {
  group('Pruebas Unitarias - validarCorreo()', () {

    // =========================================================================
    // 1. Casos requeridos por la rúbrica del entregable
    // =========================================================================

    test('Caso 1: usuario@gmail.com debe ser Válido', () {
      const correo = 'usuario@gmail.com';
      final resultado = validarCorreo(correo);
      expect(resultado, isTrue, reason: 'Un correo estándar con @ y dominio .com debe ser válido');
    });

    test('Caso 2: usuario@gmail debe ser Inválido (falta dominio TLD)', () {
      const correo = 'usuario@gmail';
      final resultado = validarCorreo(correo);
      expect(resultado, isFalse, reason: 'Un correo sin extensión (.com, .net, etc.) debe ser inválido');
    });

    test('Caso 3: usuariogmail.com debe ser Inválido (falta arroba @)', () {
      const correo = 'usuariogmail.com';
      final resultado = validarCorreo(correo);
      expect(resultado, isFalse, reason: 'Un correo sin símbolo @ debe ser rechazado');
    });

    // =========================================================================
    // 2. Casos adicionales del sistema de la Clínica Dental
    // =========================================================================

    test('Acepta correos institucionales de la clínica dental', () {
      expect(validarCorreo('paciente@clinicadental.com'), isTrue);
      expect(validarCorreo('doctora.ramos@sonrisas.dental'), isTrue);
      expect(validarCorreo('contacto@uanl.edu.mx'), isTrue);
    });

    test('Rechaza correos nulos, vacíos o solo con espacios', () {
      expect(validarCorreo(null), isFalse);
      expect(validarCorreo(''), isFalse);
      expect(validarCorreo('   '), isFalse);
    });

    test('Rechaza correos con espacios internos', () {
      expect(validarCorreo('usuario @gmail.com'), isFalse);
      expect(validarCorreo('usuario@ gmail.com'), isFalse);
    });

    test('Rechaza correos sin nombre de usuario antes del arroba', () {
      expect(validarCorreo('@gmail.com'), isFalse);
    });
  });
}
