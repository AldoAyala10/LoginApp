# 🦷 LoginApp - Clínica Dental Sonrisas

Aplicación móvil desarrollada en **Flutter** para el inicio de sesión de pacientes en una clínica dental, equipada con validación de correos electrónicos mediante funciones puras, pruebas unitarias automatizadas y un pipeline de Integración Continua (CI) en GitHub Actions.

---

## 📁 Estructura del Proyecto

```plaintext
LoginApp/
│
├── lib/
│   ├── main.dart                 # Pantalla de Login e interfaz de usuario en Flutter
│   └── validar_correo.dart       # Función de lógica pura para validar correos
│
├── test/
│   └── validar_correo_test.dart  # Pruebas unitarias de la función validarCorreo
│
├── .github/
│   ├── pull_request_template.md  # Plantilla oficial para solicitar cambios (PR)
│   └── workflows/
│       └── ci.yml                # Flujo de GitHub Actions (flutter analyze y test)
│
├── CONTRIBUTING.md               # Reglas de colaboración, ramas y commits
├── pubspec.yaml                  # Configuración del proyecto Flutter y dependencias
└── README.md                     # Documentación general
```

---

## 🚀 Requisitos y Ejecución Local

### Prerrequisitos
- Tener instalado [Flutter SDK](https://docs.flutter.dev/get-started/install) (versión 3.0 o superior).

### 1. Descargar dependencias
```bash
flutter pub get
```

### 2. Ejecutar la Aplicación
```bash
flutter run
```

### 3. Ejecutar las Pruebas Unitarias 🧪
```bash
flutter test
```

### 4. Análisis Estático de Código
```bash
flutter analyze
```

---

## 🧩 Función de Lógica Pura (`lib/validar_correo.dart`)

Implementa la función requerida `validarCorreo(String? correo)` que comprueba el formato de correo electrónico:

| Correo | Resultado Esperado | Justificación |
| :--- | :---: | :--- |
| `usuario@gmail.com` | **Válido (`true`)** | Contiene usuario, arroba `@` y dominio con TLD `.com`. |
| `usuario@gmail` | **Inválido (`false`)** | Le falta la extensión o dominio de nivel superior (.com, .mx). |
| `usuariogmail.com` | **Inválido (`false`)** | Carece del símbolo `@`. |

---

## 🧪 Pruebas Unitarias (`test/validar_correo_test.dart`)

El archivo de pruebas verifica rigurosamente los casos exigidos en la rúbrica y casos adicionales:
- Verificación del caso válido `usuario@gmail.com`.
- Verificación del caso sin dominio `usuario@gmail`.
- Verificación del caso sin arroba `usuariogmail.com`.
- Manejo seguro de nulos, cadenas vacías y espacios accidentales.

---

## 🤖 Integración Continua (GitHub Actions: `.github/workflows/ci.yml`)

Cada vez que un colaborador abre un Pull Request hacia la rama `main`, GitHub Actions ejecuta de manera automática:
1. `flutter pub get`: Descarga de dependencias.
2. `flutter analyze`: Inspección de sintaxis y buenas prácticas.
3. `flutter test`: Ejecución de todas las pruebas unitarias.

> Si todas las pruebas pasan, GitHub muestra el indicador verde (**Checks passed**). Si alguna prueba falla, el PR se bloquea evitando que código defectuoso llegue a `main`.

---

## 📱 Entregable 3 (Opcional): Demostración de Despliegue con Feature Flags

En `lib/main.dart` se implementó el mecanismo de **Feature Flag**:
```dart
const bool kHabilitarCarnetQR = true;
```
- **Activada (`true`)**: Muestra a los pacientes el acceso mediante su Carnet Digital QR de la clínica dental.
- **Desactivada (`false`)**: Oculta la función manteniendo la versión estable clásica.

Permite activar o apagar funcionalidades en producción de manera inmediata sin necesidad de redelegar una versión binaria o realizar un rollback destructivo.

---

## 👥 Colaboración y Ramas

Para conocer las reglas de ramas (`feature/login`), convención de commits y el proceso de aprobación de Pull Requests, consulta [CONTRIBUTING.md](CONTRIBUTING.md).
