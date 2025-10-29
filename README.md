# 🏋️ FitManager - Mobile App

[![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?logo=flutter)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.x-0175C2?logo=dart)](https://dart.dev)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

**FitManager** es una aplicación móvil para la gestión integral de gimnasios. Permite el registro, seguimiento y administración de miembros, rutinas de entrenamiento, progreso físico y pagos.

---

##  Tabla de Contenidos

- [Descripción](#-descripción)
- [Características](#-características)
- [Tecnologías](#-tecnologías)
- [Arquitectura](#-arquitectura)
- [Estructura del Proyecto](#-estructura-del-proyecto)
- [Instalación](#-instalación)
- [Backend](#-backend)
- [Módulos Implementados](#-módulos-implementados)
- [Reglas de Colaboración](#-reglas-de-colaboración)
- [Roadmap](#-roadmap)
- [Equipo](#-equipo)

---

##  Descripción

FitManager es una solución móvil completa para gimnasios que permite:
- **Usuarios**: Registrarse, hacer login, ver rutinas, trackear progreso
- **Entrenadores**: Crear rutinas, seguimiento de clientes, gestionar pagos
- **Administradores**: Control total del gimnasio, reportes, estadísticas

La app se conecta con un backend Spring Boot para manejo de datos, autenticación y lógica de negocio.

---

## ✨ Características

### Implementadas 
- **Autenticación de Usuarios**
  - Login con email y contraseña
  - Registro de nuevos usuarios con validaciones completas
  - Persistencia de sesión (Remember Me)
  - Opción de login social (Google, Apple) - UI lista
  
- **Gestión de Usuarios**
  - Perfil con información personal (nombre, edad, altura, peso inicial)
  - Modelo de datos alineado con backend

- **Diseño UI/UX**
  - Gradientes modernos (azul-verde)
  - Material Design
  - Responsive design
  - Validación de formularios en tiempo real
  - Componentes reutilizables (CustomTextField, SocialLoginButton)

### En Desarrollo 
- Dashboard de usuario
- Gestión de rutinas
- Seguimiento de progreso
- Sistema de pagos
- Perfil de entrenador

---

##  Tecnologías

### Frontend (Mobile)
- **Flutter** `3.x` - Framework multiplataforma
- **Dart** `3.x` - Lenguaje de programación
- **Material Design** - Sistema de diseño

### Backend
- **Spring Boot** `3.5.6` - Framework Java
- **MySQL** `8.0` - Base de datos
- **JPA/Hibernate** - ORM
- **REST API** - Comunicación cliente-servidor

### Dependencias Principales
```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  # TODO: Agregar cuando se integre backend
  # http: ^1.1.0
  # provider: ^6.0.0
```

---

##  Arquitectura

El proyecto sigue **Clean Architecture** con separación por features:

```
lib/
├── core/                    # Recursos compartidos
│   ├── theme/              # Colores, temas, estilos
│   ├── constants/          # Constantes globales
│   └── utils/              # Utilidades y helpers
├── features/               # Módulos por funcionalidad
│   ├── auth/              # Autenticación
│   │   ├── data/          # Repositorios, data sources
│   │   ├── domain/        # Modelos, casos de uso
│   │   └── presentation/  # UI (pages, widgets)
│   ├── dashboard/         # Panel principal
│   ├── members/           # Gestión de miembros
│   ├── workout/           # Rutinas y ejercicios
│   └── profile/           # Perfil de usuario
├── shared/                # Código compartido entre features
│   ├── models/            # Modelos de datos
│   ├── widgets/           # Widgets reutilizables
│   └── services/          # Servicios (HTTP, storage)
└── main.dart             # Punto de entrada
```

### Principios de Arquitectura
- **Separation of Concerns**: Cada capa tiene su responsabilidad
- **Dependency Inversion**: Las capas internas no conocen las externas
- **Single Responsibility**: Un módulo, una responsabilidad
- **Feature-First**: Organización por funcionalidad, no por tipo

---

##  Estructura del Proyecto

```
FitManager/
├── android/               # Configuración Android
├── ios/                  # Configuración iOS
├── lib/                  # Código fuente Dart/Flutter
│   ├── core/
│   │   └── theme/
│   │       ├── app_colors.dart      # Paleta de colores
│   │       └── app_theme.dart       # Tema de la app
│   ├── features/
│   │   └── auth/
│   │       └── presentation/
│   │           ├── pages/
│   │           │   ├── login_page.dart      # Pantalla de login
│   │           │   └── register_page.dart   # Pantalla de registro
│   │           └── widgets/
│   │               ├── custom_text_field.dart       # Input personalizado
│   │               └── social_login_button.dart     # Botones sociales
│   ├── shared/
│   │   └── models/
│   │       └── usuario.dart         # Modelo Usuario con toJson/fromJson
│   └── main.dart
├── test/                 # Tests unitarios
├── pubspec.yaml          # Dependencias y assets
└── README.md            # Este archivo
```

---

##  Instalación

### Prerrequisitos
- Flutter SDK `>= 3.0.0`
- Dart SDK `>= 3.0.0`
- Android Studio / Xcode (para emuladores)
- Git

### Pasos

1. **Clonar el repositorio**
   ```bash
   git clone https://github.com/TheBarkats/FitManager.git
   cd FitManager
   ```

2. **Instalar dependencias**
   ```bash
   flutter pub get
   ```

3. **Verificar instalación de Flutter**
   ```bash
   flutter doctor
   ```

4. **Ejecutar la aplicación**
   ```bash
   # En emulador Android
   flutter run

   # En dispositivo iOS
   flutter run -d ios

   # En Chrome (web)
   flutter run -d chrome
   ```

---

##  Backend

La app se conecta con el backend **FitManager** desarrollado en Spring Boot.

### Repositorio Backend
📦 [JuanCobo01/backend-FitManager](https://github.com/JuanCobo01/backend-FitManager)

### Endpoints Principales

#### Autenticación
```http
POST /api/usuarios/login
Content-Type: application/json

{
  "correo": "user@email.com",
  "contrasena": "password123"
}
```

#### Registro
```http
POST /api/usuarios
Content-Type: application/json

{
  "nombre": "Juan Pérez",
  "correo": "juan@email.com",
  "contrasena": "password123",
  "edad": 25,
  "altura": 175.5,
  "pesoInicial": 70.0
}
```

### Configuración Local
Para desarrollo local, el backend debe estar corriendo en:
```
http://localhost:8080
```

---

##  Módulos Implementados

###  Autenticación (Auth)

#### Login Page
- **Ubicación**: `lib/features/auth/presentation/pages/login_page.dart`
- **Características**:
  - Formulario con validación (email, password)
  - Checkbox "Remember Me"
  - Link "Forgot Password"
  - Botones de login social (Google, Apple)
  - Toggle para mostrar/ocultar contraseña
  - Botón "Create Account" que navega a registro

#### Register Page
- **Ubicación**: `lib/features/auth/presentation/pages/register_page.dart`
- **Características**:
  - Formulario completo con 7 campos
  - Validaciones en tiempo real
  - Campos numéricos con teclado apropiado
  - Confirmación de contraseña
  - Scroll vertical para todos los campos
  - Navegación de vuelta al login

**Campos del Registro:**
| Campo | Tipo | Validación | Backend |
|-------|------|------------|---------|
| Full Name | String | Min 3 chars | `nombre` |
| Email | String | Formato email | `correo` |
| Password | String | Min 6 chars | `contrasena` |
| Confirm Password | String | Debe coincidir | - |
| Age | int | 13-120 años | `edad` |
| Height (cm) | double | 50-300 cm | `altura` |
| Initial Weight (kg) | double | 20-500 kg | `pesoInicial` |

#### Widgets Reutilizables
- **CustomTextField**: Input personalizado con validación
- **SocialLoginButton**: Botones para login social

#### Modelo de Datos
```dart
// lib/shared/models/usuario.dart
class Usuario {
  final int? idUsuario;
  final String nombre;
  final String correo;
  final String contrasena;
  final int edad;
  final double altura;
  final double pesoInicial;
  final DateTime? fechaRegistro;
  
  // toJson(), fromJson(), copyWith()
}
```

---

##  Sistema de Diseño

### Colores Principales
```dart
// lib/core/theme/app_colors.dart
class AppColors {
  static const primary = Color(0xFF2D9CDB);        // Azul
  static const secondary = Color(0xFF27AE60);      // Verde
  static const gradientStart = Color(0xFF2D9CDB);  // Azul inicio
  static const gradientEnd = Color(0xFF27AE60);    // Verde final
  static const textPrimary = Colors.white;
  static const textSecondary = Color(0xFFE0E0E0);
  static const background = Color(0xFF1A1A2E);
}
```

### Theme
- **Fuente**: Sistema (San Francisco en iOS, Roboto en Android)
- **Estilo**: Material Design 3
- **Gradientes**: Azul → Verde
- **Bordes**: Redondeados (12px)
- **Elevación**: Sombras suaves

---

##  Reglas de Colaboración (GitHub Flow)

### Ramas
- **`main`**: Rama estable y protegida. Nunca se codea directo aquí.
- **Feature**: `feature/<modulo>-<descripcion>` (ej: `feature/login-registro`)
- **Hotfix**: `hotfix/<descripcion>` para arreglos urgentes
- **Chore/Docs**: `chore/...`, `docs/...` para tareas de soporte

### Flujo de Trabajo
1. Crear un **issue** describiendo la tarea
2. Crear rama desde `main`
3. Hacer commits pequeños siguiendo [Conventional Commits](https://www.conventionalcommits.org/)
   - `feat:` nueva funcionalidad
   - `fix:` corrección de bug
   - `docs:` documentación
   - `style:` formato, punto y coma
   - `refactor:` refactorización
   - `test:` agregar tests
   - `chore:` tareas de mantenimiento
4. Abrir **Pull Request** hacia `main` enlazando el issue
5. **1+ review** aprobatorio
6. **Squash & merge**
7. Borrar la rama

### Pull Requests
- Incluir: objetivo, cómo probar, screenshots si aplica
- Máximo ~300-400 líneas cuando sea posible
- Resolver conversaciones antes de merge

### Calidad
- ❌ Sin secretos en el repo. Usar `.env` local
- ✅ Tests y linters deben pasar antes de merge
- ✅ Código comentado en secciones complejas
- ✅ README actualizado con cada feature

### Releases & Tags
- Versionado semántico: `vX.Y.Z` en cada entrega importante
- Ejemplo: `v1.0.0`, `v1.1.0`, `v2.0.0`

---

##  Roadmap

###  Fase 1: Autenticación (Completada)
- [x] Pantalla de Login
- [x] Pantalla de Registro
- [x] Validaciones de formularios
- [x] Modelo de Usuario
- [x] UI/UX con gradientes

###  Fase 2: Integración Backend (En Progreso)
- [ ] Servicio HTTP (auth_service.dart)
- [ ] Implementar POST /api/usuarios (registro)
- [ ] Implementar POST /api/usuarios/login
- [ ] Manejo de errores y loading states
- [ ] Persistencia de sesión (shared_preferences)
- [ ] Refresh token

###  Fase 3: Dashboard
- [ ] Pantalla principal del usuario
- [ ] Vista de rutinas asignadas
- [ ] Calendario de entrenamientos
- [ ] Estadísticas rápidas (peso, progreso)

###  Fase 4: Gestión de Rutinas
- [ ] Listar rutinas del usuario
- [ ] Ver detalle de rutina
- [ ] Marcar ejercicios como completados
- [ ] Historial de entrenamientos

###  Fase 5: Seguimiento de Progreso
- [ ] Registrar medidas corporales
- [ ] Gráficas de progreso (peso, medidas)
- [ ] Fotos de antes/después
- [ ] Exportar reportes

###  Fase 6: Pagos y Suscripciones
- [ ] Ver historial de pagos
- [ ] Estado de suscripción
- [ ] Pasarela de pago (integración)
- [ ] Notificaciones de vencimiento

###  Fase 7: Perfil de Entrenador
- [ ] Vista de clientes asignados
- [ ] Crear/editar rutinas
- [ ] Ver progreso de clientes
- [ ] Chat con clientes

---

##  Equipo

### Desarrolladores
- **Mobile Developer**: Desarrollo de la app Flutter
- **Backend Developer**: API REST con Spring Boot
- **UI/UX Designer**: Diseño de interfaces y experiencia
- **QA Tester**: Pruebas y control de calidad

### Repositorios del Proyecto
- 📱 **Frontend Mobile**: [TheBarkats/FitManager](https://github.com/TheBarkats/FitManager)
- 🔧 **Backend API**: [JuanCobo01/backend-FitManager](https://github.com/JuanCobo01/backend-FitManager)

---

##  Licencia

Este proyecto es desarrollado como parte de un proyecto académico para la Universidad.

---

---

**Última actualización**: Octubre 2024  
**Versión**: `v0.1.0` (Alpha)  
**Estado**: 🚧 En Desarrollo Activo
