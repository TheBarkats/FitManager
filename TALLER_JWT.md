# Taller 2 - Autenticación JWT

## Descripción
Implementación de autenticación JWT usando la API pública de VisionTic Parking System.

## Objetivo Cumplido ✅

- [x] Login JWT contra backend (API VisionTic)
- [x] Manejo de estados (loading/success/error)
- [x] Manejo de errores con mensajes al usuario
- [x] Separación por servicios
- [x] Almacenamiento con SharedPreferences (datos NO sensibles)
- [x] Almacenamiento con FlutterSecureStorage (tokens sensibles)
- [x] Vista de evidencia mostrando almacenamiento local

## API Utilizada

**Base URL**: `https://parking.visiontic.com.co/api`

### Endpoints
- **Login**: `POST /login`
  - Body: `{ "email": string, "password": string }`
  - Response: `{ "access_token": string, "user": {...} }`

- **Register**: `POST /register`
  - Body: `{ "name": string, "email": string, "password": string }`
  - Response: `{ "access_token": string, "user": {...} }`

## Estructura del Proyecto

```
lib/
├── core/
│   └── services/
│       ├── shared_preferences_service.dart  # Datos NO sensibles
│       └── secure_storage_service.dart      # Tokens sensibles
│
├── features/
│   └── auth/
│       ├── data/
│       │   ├── models/
│       │   │   ├── login_request.dart
│       │   │   ├── login_response.dart
│       │   │   └── register_request.dart
│       │   └── services/
│       │       └── auth_service.dart         # HTTP client
│       └── presentation/
│           ├── providers/
│           │   └── auth_provider.dart        # State management
│           └── pages/
│               ├── login_page.dart           # Pantalla de login
│               └── evidence_page.dart        # Pantalla de evidencia
```

## Dependencias

```yaml
dependencies:
  http: ^1.2.0                          # HTTP client
  provider: ^6.1.1                      # State management
  shared_preferences: ^2.2.2            # Almacenamiento NO sensible
  flutter_secure_storage: ^9.0.0       # Almacenamiento SENSIBLE
```

## Funcionalidades Implementadas

### 1. AuthService
Servicio HTTP para comunicación con la API:
- Login
- Registro
- Verificación de token

### 2. AuthProvider (State Management)
Manejo de estados de autenticación:
- `AuthState.initial` - Estado inicial
- `AuthState.loading` - Cargando (muestra CircularProgressIndicator)
- `AuthState.authenticated` - Autenticado exitosamente
- `AuthState.unauthenticated` - Sin autenticar
- `AuthState.error` - Error con mensaje

Métodos:
- `login()` - Inicia sesión y guarda datos
- `register()` - Registra usuario y guarda datos
- `logout()` - Cierra sesión y limpia datos
- `initialize()` - Restaura sesión al abrir la app

### 3. SharedPreferencesService
Almacena datos **NO SENSIBLES**:
- `user_name` - Nombre del usuario
- `user_email` - Email del usuario
- `user_id` - ID del usuario
- `is_logged_in` - Estado de sesión

### 4. SecureStorageService
Almacena datos **SENSIBLES** de forma encriptada:
- `access_token` - Token de acceso JWT
- `refresh_token` - Token de refresco (opcional)

**Seguridad**: Usa `encryptedSharedPreferences` en Android para mayor seguridad.

### 5. LoginPage
Pantalla de login con:
- Validación de formulario
- Indicador de carga (overlay)
- Mensajes de error (SnackBar)
- Navegación a pantalla de evidencia tras login exitoso

### 6. EvidencePage (Vista de Evidencia)
Muestra información almacenada localmente:

#### SharedPreferences (NO sensible)
- ✅ Nombre del usuario
- ✅ Email del usuario
- ✅ ID del usuario

#### FlutterSecureStorage (Sensible)
- ✅ Estado del access_token (presente/ausente)
- ✅ Estado del refresh_token (presente/ausente)
- ✅ Vista previa del token (primeros 20 caracteres)

#### Funcionalidades
- 🔄 Refrescar datos manualmente
- 🚪 Cerrar sesión (limpia todos los datos)
- ℹ️ Indicador de estado de sesión

## Flujo de Autenticación

### Login
1. Usuario ingresa email y contraseña
2. `LoginPage` llama a `AuthProvider.login()`
3. `AuthProvider` cambia estado a `loading` (muestra indicador)
4. `AuthService` realiza POST a `/api/login`
5. Si es exitoso:
   - Guarda tokens en `SecureStorageService`
   - Guarda datos de usuario en `SharedPreferencesService`
   - Cambia estado a `authenticated`
   - Navega a `EvidencePage`
6. Si hay error:
   - Cambia estado a `error`
   - Muestra mensaje de error en `SnackBar`

### Logout
1. Usuario presiona "Cerrar sesión" en `EvidencePage`
2. Muestra diálogo de confirmación
3. Si confirma:
   - Elimina todos los tokens de `SecureStorageService`
   - Limpia datos de `SharedPreferencesService`
   - Cambia estado a `unauthenticated`
   - Actualiza la vista de evidencia

### Restauración de Sesión
1. Al abrir la app, `AuthProvider.initialize()` se ejecuta
2. Verifica si existe `access_token` en `SecureStorageService`
3. Verifica si `is_logged_in` está en `true`
4. Si ambos son verdaderos:
   - Carga datos del usuario desde `SharedPreferences`
   - Cambia estado a `authenticated`
5. Si no:
   - Mantiene estado `unauthenticated`

## Seguridad

### ✅ Implementado
- Tokens almacenados en `flutter_secure_storage` con encriptación
- Separación clara entre datos sensibles y no sensibles
- Tokens nunca se muestran completos en la UI
- Limpieza completa de datos al cerrar sesión

### 🔒 Recomendaciones Adicionales
- Implementar refresh token para renovar access_token
- Agregar timeout a las peticiones HTTP
- Validar expiración de tokens
- Implementar biometría para acceso rápido

## Cómo Probar

### 1. Crear una cuenta
1. Abrir la app
2. Click en "Crear cuenta"
3. Llenar formulario de registro
4. Click en "Crear Cuenta"

### 2. Ver evidencia
1. Tras login exitoso, se redirige a `EvidencePage`
2. Revisar datos en SharedPreferences
3. Revisar estado de tokens en SecureStorage
4. Verificar estado de sesión

### 3. Cerrar sesión
1. Click en "Cerrar sesión"
2. Confirmar en diálogo
3. Verificar que los datos se limpiaron
4. Verificar que el estado cambió a "Sin sesión"

### 4. Refrescar datos
1. Click en "Refrescar datos"
2. Los datos se recargan desde almacenamiento local

## Capturas de Pantalla

### LoginPage
- Formulario de login
- Indicador de carga durante autenticación
- Mensajes de error en caso de fallo

### EvidencePage
- Sección de SharedPreferences (datos del usuario)
- Sección de SecureStorage (estado de tokens)
- Indicador de estado de sesión
- Botones de cerrar sesión y refrescar

## Notas de Implementación

### Manejo de Estados
Se utilizó **Provider** (ChangeNotifier) por:
- ✅ Simplicidad y curva de aprendizaje baja
- ✅ Bien documentado y mantenido por Flutter
- ✅ Suficiente para este scope de proyecto
- ✅ Fácil de testear

### HTTP Client
Se utilizó **http** en lugar de **dio** por:
- ✅ Paquete oficial de Dart
- ✅ Más ligero y rápido
- ✅ Suficiente para las necesidades del proyecto
- ✅ Menos dependencias

### Almacenamiento
- **SharedPreferences**: Datos que el usuario puede ver (nombre, email)
- **SecureStorage**: Datos críticos que nunca deben ser expuestos (tokens)

## Migración Futura al Backend Propio

La arquitectura está diseñada para facilitar la migración:

```dart
// 1. Actualizar la URL base en auth_service.dart
static const String baseUrl = 'https://tu-backend.com/api';

// 2. Ajustar los modelos si los campos cambian
// LoginResponse ya está preparado para múltiples formatos de respuesta

// 3. Todo lo demás funciona igual (Provider, Storage, etc.)
```

## Autor
Implementado como parte del Taller 2 - Autenticación JWT
Electiva Profesional I - Desarrollo Móvil
