# Pantalla de Login - FitManager

## Descripción
Pantalla de inicio de sesión con diseño moderno y limpio, siguiendo las mejores prácticas de Flutter.

## Características implementadas

### UI/UX
- ✅ Gradiente de fondo (azul-verde)
- ✅ Formulario con campos Username y Password
- ✅ Botón "Remember Me" (checkbox)
- ✅ Link "Forgot Password"
- ✅ Botón "Sign in"
- ✅ Opciones de login social (Google y Apple)
- ✅ Mostrar/ocultar contraseña
- ✅ Validación de formularios

### Arquitectura
- Clean Architecture por features
- Separación de widgets reutilizables
- Theme centralizado en `core/theme/`

## Archivos creados

```
presentation/
├── pages/
│   └── login_page.dart          # Pantalla principal de login
└── widgets/
    ├── custom_text_field.dart   # Campo de texto personalizado
    └── social_login_button.dart # Botones de login social
```

## Estructura del módulo:
- `presentation/pages/` - Pantallas de login y registro
- `presentation/widgets/` - Componentes reutilizables (formularios, botones, etc.)
- `data/` - Repositorios y fuentes de datos
- `domain/` - Modelos de usuario y casos de uso

## Próximos pasos

- [ ] Implementar lógica de autenticación
- [ ] Conectar con backend/Firebase
- [ ] Crear pantalla de registro
- [ ] Implementar recuperación de contraseña
- [ ] Agregar autenticación con Google/Apple
- [ ] Agregar persistencia de sesión (Remember Me)
- [ ] Tests unitarios y de widget