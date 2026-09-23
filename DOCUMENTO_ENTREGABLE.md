# REPORTE TÉCNICO: DESARROLLO DE LOGINAPP, INTEGRACIÓN CONTINUA (CI/CD) Y ESTRATEGIA DE DESPLIEGUE

**Asignatura:** Desarrollo Móvil / Ingeniería de Software / DevOps  
**Proyecto:** Sistema Digital de Pacientes - Clínica Dental Sonrisas (LoginApp)  
**Tecnología:** Flutter / Dart / GitHub Actions  
**Fecha:** 2026  

---

## 1. INTRODUCCIÓN

### 1.1 Contexto y Justificación
El presente proyecto, denominado **LoginApp**, forma parte del sistema digital integral de la **Clínica Dental Sonrisas**. La clínica busca modernizar su flujo operativo sustituyendo los tradicionales carnets de cartón y expedientes en papel por un ecosistema digital que reduzca los tiempos de espera de los pacientes, evite la pérdida de historiales clínicos y prevenga ausencias mediante recordatorios y carnets digitales con códigos QR.

### 1.2 Alcance de LoginApp
Dentro de esta arquitectura, **LoginApp** representa el punto de entrada móvil para los pacientes. La aplicación móvil se diseñó bajo una filosofía minimalista y robusta para garantizar accesibilidad y facilidad de uso:
1. **Interfaz de Acceso**: Formulario intuitivo con campos para correo electrónico y contraseña.
2. **Validación de Entradas**: Validación sintáctica en tiempo real del correo electrónico antes de permitir el envío de datos.
3. **Módulo Desacoplado de Lógica Pura**: Función modular `validarCorreo()` independiente del framework visual, permitiendo pruebas unitarias deterministas.
4. **Demostración de Despliegue (Feature Flag)**: Mecanismo de activación y desactivación dinámica para la función del **Carnet Digital QR**, demostrando control de despliegue sin alterar la estabilidad del aplicativo.

---

## 2. COMPARATIVA DE MODELOS DE TRABAJO CON GIT

A continuación se presenta un análisis comparativo entre los tres modelos de ramificación más utilizados en la industria:

| Criterio | **GitHub Flow** | **Gitflow** | **Trunk-Based Development** |
| :--- | :--- | :--- | :--- |
| **Complejidad** | **Baja**. Modelo ligero y fácil de aprender. | **Alta**. Múltiples tipos de ramas con reglas estrictas de fusión. | **Media**. Requiere alta disciplina en pruebas y automatización. |
| **Ramas Principales** | Solo una rama permanente: `main` (siempre lista para desplegar). | Dos ramas permanentes: `main` (producción) y `develop` (desarrollo). | Solo una rama troncal: `main` / `trunk`. |
| **Ramas Temporales** | Ramas cortas de características: `feature/*` o `fix/*`. | `feature/*`, `release/*`, `hotfix/*`, `bugfix/*`. | Ramas extremadamente cortas (horas o días) o commits directos con Feature Flags. |
| **Frecuencia de Despliegue** | Continua (cada PR aprobado se puede desplegar). | Por ciclos de versión planificados (*releases* mensuales/quincenales). | Múltiples veces al día (Integración Continua real). |
| **Mecanismo de Revisión** | Pull Requests con integración continua y revisión obligatoria. | Pull Requests hacia `develop` y posteriores fusiones a `release`. | Pull Requests muy pequeños o revisión por pares en vivo (*pair programming*). |
| **Idoneidad para LoginApp** | **Ideal**. Perfecto para equipos ágiles, proyectos móviles modulares y flujos con GitHub Actions. | Demasiado burocrático para un equipo enfocado en iteración rápida. | Exige cobertura de tests al 100% y CI maduro antes de adoptarse plenamente. |

---

## 3. WORKFLOW ELEGIDO Y JUSTIFICACIÓN

### 3.1 Justificación de GitHub Flow
Para el desarrollo de **LoginApp** se seleccionó **GitHub Flow** debido a las siguientes ventajas técnicas y operativas:
1. **Simplicidad Operativa**: Al tener a `main` como única rama permanente protegida, se eliminan los conflictos complejos de fusión (*merge conflicts*) comunes en Gitflow.
2. **Alineación con GitHub Actions**: La apertura de un Pull Request actúa como disparador natural para la ejecución automática de `flutter analyze` y `flutter test`.
3. **Control de Calidad mediante Protección de Ramas**: Garantiza que ningún desarrollador pueda incorporar cambios a `main` sin la aprobación de un revisor humano y el visto bueno del bot de integración continua.

### 3.2 Diagrama de Flujo (GitHub Flow)

```
[ Rama main (Protegida, Código Estable) ]
       │
       ├───> (Crear rama feature/login)
       │           │
       │           ├─> Commit 1: feat(ui): pantalla de login
       │           ├─> Commit 2: feat(logic): funcion validarCorreo
       │           └─> Commit 3: test: pruebas unitarias
       │           │
       │     [ Abrir Pull Request hacia main ]
       │           │
       │           ├─> ⚙️ GitHub Actions: flutter analyze & test (CI)
       │           ├─> 👁️ Revisión por pares (Code Review aprobado)
       │           │
       ├───< (Merge del PR aprobado)
       │
[ Rama main actualizada y lista para versión 1.0.0 ]
```

---

## 4. REGLAS DEL REPOSITORIO

Para gobernar el trabajo colaborativo se establecieron cuatro pilares normativos documentados en el archivo `CONTRIBUTING.md`:

### 4.1 Nomenclatura de Ramas
- `feature/<nombre-descriptivo>`: Nuevas pantallas o funciones (ej. `feature/login-paciente`).
- `bugfix/<nombre-descriptivo>`: Correcciones de defectos (ej. `bugfix/regex-correo-tld`).
- `hotfix/<nombre-descriptivo>`: Arreglos urgentes en producción.
- `test/<nombre-descriptivo>`: Cobertura y nuevos casos de prueba.

### 4.2 Convención de Commits (Conventional Commits)
Cada commit debe estructurarse con la fórmula: `<tipo>(<módulo>): <descripción breve>`
- `feat`: Nueva característica para el paciente o usuario.
- `fix`: Corrección de un fallo.
- `test`: Incorporación o mejora de pruebas.
- `docs`: Modificación en la documentación.
- `refactor`: Limpieza de código sin alterar su comportamiento.

### 4.3 Política de Pull Requests
- Toda contribución exige el llenado de la plantilla `.github/pull_request_template.md`.
- Es mandatoria la aprobación de al menos **un revisor** (*peer approval*).
- No se permiten fusiones con advertencias de análisis estático o pruebas fallidas.

### 4.4 Versionado Semántico (SemVer 2.0.0)
El proyecto se rige por el formato `MAJOR.MINOR.PATCH`:
- **MAJOR**: Cambios arquitectónicos incompatibles (ej. migración a nueva versión de Flutter).
- **MINOR**: Nuevas funcionalidades compatibles (ej. agregado de la función de carnet QR).
- **PATCH**: Correcciones puntuales de errores.

---

## 5. PRUEBAS AUTOMÁTICAS Y CI/CD

### 5.1 Función de Lógica Pura (`lib/validar_correo.dart`)
La función `validarCorreo(String? correo)` utiliza una expresión regular estricta (`r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'`) diseñada para validar que:
1. La cadena no sea nula, vacía ni consista únicamente de espacios.
2. Exista un identificador válido antes del símbolo `@`.
3. El dominio cuente con al menos un punto y una extensión de nivel superior (*TLD*) de 2 o más letras (ej. `.com`, `.mx`, `.dental`).

### 5.2 Casos de Prueba Evaluados (`test/validar_correo_test.dart`)
La suite de pruebas automatizadas evalúa los siguientes escenarios requeridos:

| Correo Probado | Resultado Obtenido | Justificación Técnica |
| :--- | :---: | :--- |
| `usuario@gmail.com` | **Válido (`true`)** | Estructura completa con usuario, arroba y dominio válido. |
| `usuario@gmail` | **Inválido (`false`)** | Rechazado por falta de extensión de dominio (.com, .net, etc.). |
| `usuariogmail.com` | **Inválido (`false`)** | Rechazado por ausencia del símbolo obligatorio `@`. |
| `paciente@clinicadental.com` | **Válido (`true`)** | Soporta dominios corporativos del sistema dental. |
| `''` (cadena vacía) / `null` | **Inválido (`false`)** | Protección contra datos inexistentes o nulos. |
| `usuario @gmail.com` | **Inválido (`false`)** | Rechaza espacios en blanco intermedios. |

### 5.3 Pipeline de GitHub Actions (`.github/workflows/ci.yml`)
El flujo de CI se dispara en cada evento de `push` y `pull_request` sobre la rama `main`. Ejecuta los siguientes pasos en un entorno virtualizado Ubuntu:
1. `actions/checkout@v4`: Descarga el código del repositorio.
2. `subosito/flutter-action@v2`: Configura el SDK de Flutter en su canal estable.
3. `flutter pub get`: Descarga las dependencias declaradas en `pubspec.yaml`.
4. `flutter analyze`: Ejecuta el analizador estático para garantizar que el código cumpla con los lineamientos de buenas prácticas de Dart.
5. `flutter test`: Ejecuta automáticamente la suite de pruebas unitarias.

---

## 6. ESTRATEGIA DE DESPLIEGUE ESCALONADO (CANARY RELEASE)

Para publicar actualizaciones de **LoginApp** sin poner en riesgo la atención de los pacientes de la clínica dental, se propone una estrategia de **despliegue progresivo / canarizado** a través de Google Play Console (y Apple TestFlight):

```
Fase 1: 5% Usuarios  ──>  Fase 2: 20% Usuarios  ──>  Fase 3: 50% Usuarios  ──>  Fase 4: 100% Usuarios
  (Monitoreo 24h)           (Monitoreo 48h)           (Monitoreo 24h)           (Despliegue Total)
```

### 6.1 Fases de Distribución
1. **Fase 1 (5% de usuarios durante 24 horas)**:
   - Se libera la nueva versión a un grupo reducido de pacientes y personal interno de la clínica.
   - **Métricas a monitorear**: Tasa de fallos libres de caídas (*Crash-Free Users* > 99.5%) en Firebase Crashlytics.
2. **Fase 2 (20% de usuarios durante 48 horas)**:
   - Si no se reportan anomalías de inicio de sesión o validación de correo, se expande al 20%.
   - **Métricas a monitorear**: Latencia de autenticación y tasa de finalización de inicio de sesión.
3. **Fase 3 (50% de usuarios durante 24 horas)**:
   - Cobertura de la mitad de la base instalada. Se comprueba la respuesta del servidor ante mayor concurrencia.
4. **Fase 4 (100% de usuarios - Lanzamiento Completo)**:
   - Se concluye la distribución general a todos los pacientes de la clínica.

### 6.2 Demostración mediante Feature Flags
En `lib/main.dart` se implementó la variable `kHabilitarCarnetQR`:
- Si la funcionalidad del Carnet Digital QR presentara algún problema de lectura en recepción, basta con cambiar `kHabilitarCarnetQR = false` para desactivar la interfaz sin necesidad de realizar un despliegue invasivo o retirar la app de las tiendas.

---

## 7. PLAN DE CONTINGENCIA Y RECUPERACIÓN (ROLLBACK)

Si durante cualquiera de las etapas de despliegue se identifica un fallo crítico (ej. los pacientes no pueden iniciar sesión o la app se cierra inesperadamente), se aplicará el siguiente protocolo de contingencia:

```
[ Detección del Incidente ]
            │
            ├─> 1. Detener inmediatamente el despliegue en Google Play Console (Halt Rollout).
            │
            ├─> 2. Si la falla corresponde a una función experimental:
            │      Desactivar la Feature Flag (kHabilitarCarnetQR = false).
            │
            ├─> 3. Si la falla afecta el núcleo de la aplicación:
            │      Ejecutar Rollback en Git mediante git revert hacia el commit estable anterior.
            │
            ├─> 4. Apertura de rama hotfix/login-crash:
            │      Corrección del bug, verificación con tests unitarios y aprobación de PR exprés.
            │
            └─> 5. Liberación de versión parche (ej. v1.0.1) con despliegue al 100%.
```

---

## 8. GUÍA DE EVIDENCIAS PARA LA EVALUACIÓN

Para comprobar el cumplimiento del 100% de la rúbrica (50 puntos), toma las siguientes capturas en tu repositorio de GitHub y en tu máquina local:

### 📸 Captura 1: Repositorio en GitHub con Estructura Completa
- **Dónde tomarla**: Página principal del repositorio en GitHub (`github.com/usuario/LoginApp`).
- **Qué debe verse**: Las carpetas `lib/`, `test/`, `.github/`, los archivos `pubspec.yaml`, `CONTRIBUTING.md`, `README.md` y `.github/pull_request_template.md`.

### 📸 Captura 2: Protección de la Rama `main` Configurada
- **Dónde tomarla**: En GitHub: `Settings` > `Branches` > `Branch protection rules` sobre `main`.
- **Qué debe verse**:
  - Casilla activada: *"Require a pull request before merging"*.
  - Casilla activada: *"Require status checks to pass before merging"* con el check `Flutter Analyze & Test`.

### 📸 Captura 3: Pull Request Creado desde `feature/login`
- **Dónde tomarla**: Pestaña `Pull Requests` > Abrir el PR de `feature/login` hacia `main`.
- **Qué debe verse**: El título del PR, la plantilla `.github/pull_request_template.md` rellenada con los checklists marcados.

### 📸 Captura 4: Pruebas en Verde en GitHub Actions (CI)
- **Dónde tomarla**: Pestaña `Actions` de GitHub o en la sección inferior del Pull Request.
- **Qué debe verse**: El workflow `CI - Integración Continua LoginApp` con la palomita verde (✅ *All checks have passed*), mostrando que `flutter analyze` y `flutter test` pasaron exitosamente.

### 📸 Captura 5: Pull Request Aprobado y Fusionado (*Merged*)
- **Dónde tomarla**: En la misma pantalla del Pull Request tras presionar *Merge pull request*.
- **Qué debe verse**: El cartel morado indicando **Merged** y la confirmación de la integración en `main`.

### 📸 Captura 6: Ejecución Local de Pruebas Unitarias
- **Dónde tomarla**: En la terminal local ejecutando `flutter test`.
- **Qué debe verse**:
  ```plaintext
  00:01 +3: All tests passed!
  ```
  Demostrando que `usuario@gmail.com` es válido, y `usuario@gmail` y `usuariogmail.com` son inválidos.

### 📸 Captura 7: Pantalla de la Aplicación Móvil en Funcionamiento
- **Dónde tomarla**: Emulador o dispositivo corriendo la pantalla de login de **LoginApp**.
- **Qué debe verse**: El formulario con el campo de correo, contraseña, botón de inicio de sesión y el interruptor de la Feature Flag.

---

## 9. BIBLIOGRAFÍA Y REFERENCIAS

1. **Flutter Documentation**: *Unit testing with Flutter*, Google Developers. Disponible en: [https://docs.flutter.dev/cookbook/testing/unit/introduction](https://docs.flutter.dev/cookbook/testing/unit/introduction)
2. **GitHub Flow Guide**: *Understanding the GitHub flow*, GitHub Docs. Disponible en: [https://docs.github.com/en/get-started/using-github/github-flow](https://docs.github.com/en/get-started/using-github/github-flow)
3. **GitHub Actions for Flutter**: *subosito/flutter-action*, GitHub Marketplace. Disponible en: [https://github.com/subosito/flutter-action](https://github.com/subosito/flutter-action)
4. **Conventional Commits**: *A specification for adding human and machine readable meaning to commit messages*, v1.0.0. Disponible en: [https://www.conventionalcommits.org/](https://www.conventionalcommits.org/)
5. **Semantic Versioning**: *Semantic Versioning 2.0.0*, Tom Preston-Werner. Disponible en: [https://semver.org/](https://semver.org/)
6. **Martin Fowler**: *Feature Toggles (aka Feature Flags)*. Disponible en: [https://martinfowler.com/articles/feature-toggles.html](https://martinfowler.com/articles/feature-toggles.html)
