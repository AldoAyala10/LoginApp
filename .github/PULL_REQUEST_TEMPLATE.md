## 📋 Descripción del Cambio

<!-- Explica de forma concisa qué problema resuelve este Pull Request o qué funcionalidad añade a LoginApp. -->

### 🎯 Tipo de Cambio
- [ ] 🚀 **Nueva Funcionalidad** (Feature, ej. nueva pantalla o validación)
- [ ] 🐛 **Corrección de Error** (Bug fix)
- [ ] ⚡ **Mejora de Rendimiento / Refactorización**
- [ ] 📝 **Documentación**
- [ ] 🧪 **Pruebas Automáticas**

---

## 🔍 Módulo Afectado
- [ ] `lib/main.dart` (Interfaz de usuario y pantalla de Login)
- [ ] `lib/validar_correo.dart` (Lógica de validación de correo)
- [ ] `test/validar_correo_test.dart` (Pruebas unitarias)
- [ ] `.github/workflows/ci.yml` (Flujo de CI/CD)
- [ ] Configuración / Dependencias (`pubspec.yaml`)

---

## 🧪 Pruebas Realizadas
<!-- Detalla los comandos ejecutados localmente antes de abrir el PR. -->
- [ ] Análisis estático aprobado sin advertencias:
  ```bash
  flutter analyze
  ```
- [ ] Todas las pruebas unitarias pasan en verde:
  ```bash
  flutter test
  ```
- [ ] Prueba visual en emulador o dispositivo físico.

---

## 📱 Feature Flag (Demostración de Despliegue)
- [ ] ¿Afecta alguna bandera de funcionalidad?
- Estado de la variable: `kHabilitarCarnetQR = [true / false]`

---

## ✅ Lista de Verificación (Checklist)
- [ ] Mi código sigue las normas establecidas en [CONTRIBUTING.md](../CONTRIBUTING.md).
- [ ] He agregado pruebas para verificar mis cambios.
- [ ] El pipeline de GitHub Actions (`ci.yml`) finalizó en verde.
- [ ] Se solicitó la revisión y aprobación de un compañero de equipo.
