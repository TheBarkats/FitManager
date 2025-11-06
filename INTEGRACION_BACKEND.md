# 🔗 Integración con Backend FitManager

## ✅ Cambios Completados

### 1. Actualización de URLs y Endpoints

**Archivo**: `lib/features/auth/data/services/auth_service.dart`

- ❌ **ELIMINADO**: `https://parking.visiontic.com.co/api` (VisionTic)
- ✅ **NUEVO**: `http://10.0.2.2:9090/fitmanager/v1` (Emulador Android)
- Endpoints actualizados:
  - Login: `/auth/usuario/login`
  - Register: `/auth/usuario/register`
- Manejo mejorado de errores con formato del backend

### 2. Modelos Actualizados

#### `lib/features/auth/data/models/register_request.dart`
```dart
// ANTES (VisionTic)
class RegisterRequest {
  final String name;
  final String email;
  final String password;
  final String? phone;  // ❌ No usado
}

// AHORA (FitManager)
class RegisterRequest {
  final String nombre;     // ✅ Requerido
  final String email;      // ✅ Requerido
  final String password;   // ✅ Requerido
  final int edad;          // ✅ Requerido
  final double altura;     // ✅ Requerido
  final double pesoInicial; // ✅ Requerido
}
```

#### `lib/features/auth/data/models/login_response.dart`
```dart
// ANTES (VisionTic - múltiples formatos)
class LoginResponse {
  final String accessToken;
  final String? refreshToken;
  final UserData user;
}

// AHORA (FitManager - formato específico)
class LoginResponse {
  final String token;          // ✅ Campo 'token'
  final String userType;       // ✅ USUARIO/ENTRENADOR/ADMIN
  final UserData user;         // ✅ Construido desde userId, userName, email
  final String? message;       // ✅ Mensaje del backend
}
```

### 3. Provider Actualizado

**Archivo**: `lib/features/auth/presentation/providers/auth_provider.dart`

- Método `login()`: Ahora guarda `response.token` (no `accessToken`)
- Método `register()`: Recibe y envía `edad`, `altura`, `pesoInicial`
- `refreshToken` manejado como `null` (no implementado en backend aún)

### 4. UI Actualizada

**Archivo**: `lib/features/auth/presentation/pages/register_page.dart`

- Los campos **edad**, **altura** y **peso** ahora SÍ se envían al backend
- Validaciones implementadas:
  - Edad: 13-120 años
  - Altura: 50-300 cm
  - Peso: 20-500 kg

### 5. Configuración Android

**Archivo**: `android/app/src/main/AndroidManifest.xml`

```xml
<application
    android:usesCleartextTraffic="true"  <!-- ✅ Permite HTTP en desarrollo -->
    ...>
```

### 6. Storage Service

**Archivo**: `lib/core/services/secure_storage_service.dart`

- Documentado que `refreshToken` es opcional
- Preparado para futura implementación de refresh tokens

---

## 🚀 Cómo Probar la Integración

### Paso 1: Iniciar el Backend

```bash
cd backend-FitManager
mvn spring-boot:run
```

Verificar que esté corriendo en `http://localhost:9090`

### Paso 2: Ejecutar la App

```powershell
cd fit_manager
flutter run
```

### Paso 3: Registrar un Usuario

En la app:
1. Ir a "Crear Cuenta"
2. Llenar el formulario:
   - **Nombre**: Juan Pérez
   - **Email**: juan@test.com
   - **Contraseña**: password123
   - **Confirmar Contraseña**: password123
   - **Edad**: 25
   - **Altura**: 175 (cm)
   - **Peso Inicial**: 70.5 (kg)
3. Presionar "Crear Cuenta"

**Respuesta esperada del backend**:
```json
{
  "token": "eyJhbGciOiJIUzI1NiJ9...",
  "userType": "USUARIO",
  "userId": 1,
  "userName": "Juan Pérez",
  "email": "juan@test.com",
  "message": "Registro exitoso"
}
```

### Paso 4: Iniciar Sesión

1. Usar el mismo email y contraseña
2. Presionar "Iniciar Sesión"

---

## 🐛 Solución de Problemas

### Error: "Connection refused"

**Causa**: El emulador no puede conectarse a localhost.

**Solución**:
- Emulador Android: Usar `http://10.0.2.2:9090/fitmanager/v1` (ya configurado ✅)
- Dispositivo físico: Cambiar a IP de tu PC (ej: `http://192.168.1.100:9090/fitmanager/v1`)

### Error: "Credenciales inválidas"

**Causa**: Contraseña incorrecta o usuario no existe.

**Solución**: Registrarse primero antes de intentar login.

### Error: "El correo debe tener un formato válido"

**Causa**: Email sin formato correcto (falta @ o dominio).

**Solución**: Usar email válido como `usuario@dominio.com`

### Error: "Error de conexión: Verifica que el backend esté corriendo"

**Causa**: Backend no está ejecutándose en el puerto 9090.

**Solución**:
```bash
cd backend-FitManager
mvn spring-boot:run
```

---

## 📝 Diferencias: VisionTic vs FitManager

| Aspecto | VisionTic (Anterior) | FitManager (Actual) |
|---------|---------------------|---------------------|
| Base URL | `parking.visiontic.com.co/api` | `localhost:9090/fitmanager/v1` |
| Login Endpoint | `/login` | `/auth/usuario/login` |
| Register Endpoint | `/register` (no disponible) | `/auth/usuario/register` ✅ |
| Campos de Registro | name, email, password | nombre, email, password, edad, altura, pesoInicial |
| Token Response | `accessToken` o `token` | `token` |
| Tipo de Usuario | ❌ No disponible | `userType`: USUARIO/ENTRENADOR/ADMIN |
| Refresh Token | Opcional | No implementado (preparado) |
| Validaciones | Cliente solo | Cliente + Servidor ✅ |

---

## 🎯 Próximos Pasos

### Funcionalidades Pendientes de Implementar

1. **Cambio de Contraseña**
   - Endpoint backend: `/auth/change-password` ✅
   - UI frontend: ❌ Pendiente

2. **Perfil de Usuario**
   - Endpoints: `/usuarios/{id}`, `/usuarios/actualizar/{id}` ✅
   - UI: Parcialmente implementada (ProfilePage)

3. **Logout con Backend**
   - Endpoint: `/auth/logout` ✅
   - Frontend: Solo limpia storage local

4. **Refresh Token**
   - Backend: ❌ No implementado
   - Frontend: Preparado para cuando esté disponible

5. **Rutinas y Ejercicios**
   - Backend: ✅ Endpoints disponibles
   - Frontend: UI con datos mock (pendiente integración)

---

## 📚 Recursos

### Repositorios
- **Backend**: https://github.com/JuanCobo01/backend-FitManager
- **Frontend**: https://github.com/TheBarkats/FitManager

### Documentación
- `MEJORAS_IMPLEMENTADAS.md` - Mejoras del backend
- `TALLER_JWT.md` - Documentación del taller anterior (VisionTic)
- Este archivo - Integración con backend FitManager

### Testing
Para probar endpoints manualmente:
```bash
# Login
curl -X POST http://localhost:9090/fitmanager/v1/auth/usuario/login \
  -H "Content-Type: application/json" \
  -d '{"email":"juan@test.com","password":"password123"}'

# Register
curl -X POST http://localhost:9090/fitmanager/v1/auth/usuario/register \
  -H "Content-Type: application/json" \
  -d '{
    "nombre":"Juan Pérez",
    "email":"juan@test.com",
    "password":"password123",
    "edad":25,
    "altura":1.75,
    "pesoInicial":70.5
  }'
```

---

## ✅ Checklist de Integración

### Código
- [x] URL base actualizada a backend FitManager
- [x] Endpoints actualizados (`/auth/usuario/...`)
- [x] `RegisterRequest` con todos los campos requeridos
- [x] `LoginResponse` adaptado al formato del backend
- [x] `auth_provider.dart` enviando edad/altura/peso
- [x] `register_page.dart` usando todos los campos
- [x] `AndroidManifest.xml` permite HTTP
- [x] Manejo de errores mejorado
- [x] Sin errores de compilación

### Testing
- [ ] Backend corriendo en puerto 9090
- [ ] Registro de nuevo usuario exitoso
- [ ] Login con usuario registrado exitoso
- [ ] Token guardado en SecureStorage
- [ ] Navegación a Dashboard después de login/register
- [ ] Logout limpia datos correctamente

---

## 🎉 ¡Integración Completa!

Todos los componentes de VisionTic han sido **eliminados** y reemplazados por la integración con el backend FitManager.

**Estado**: ✅ Listo para testing con backend local
