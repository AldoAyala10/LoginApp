/// Módulo de Lógica Pura: Validación de Correo Electrónico
/// Sistema Dental - LoginApp

/// Comprueba si una cadena tiene el formato válido de correo electrónico.
///
/// Reglas aplicadas:
/// - No debe ser nulo ni vacío.
/// - Debe contener exactamente una arroba `@`.
/// - Debe contener un dominio con extensión válida (mínimo 2 caracteres, ej: .com, .mx).
///
/// Ejemplos esperados:
/// - `validarCorreo('usuario@gmail.com')` => `true` (Válido)
/// - `validarCorreo('usuario@gmail')`     => `false` (Inválido, falta TLD)
/// - `validarCorreo('usuariogmail.com')`   => `false` (Inválido, falta @)
bool validarCorreo(String? correo) {
  if (correo == null || correo.trim().isEmpty) {
    return false;
  }

  final correoLimpio = correo.trim();

  // Expresión regular estándar para validación estricta de correo electrónico
  final RegExp emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  return emailRegex.hasMatch(correoLimpio);
}
