# Features

Este directorio contiene todas las funcionalidades principales de FitManager, organizadas por módulos.

## Estructura de cada feature:

```
feature/
├── data/           # Repositorios, data sources, modelos de datos
├── domain/         # Entidades, casos de uso, interfaces
└── presentation/   # Páginas, widgets, estado (Bloc/Provider)
    ├── pages/      # Pantallas principales
    └── widgets/    # Componentes reutilizables del feature
```

## Features actuales:

- **auth/**: Autenticación (login, registro, recuperar contraseña)
- **dashboard/**: Panel principal con resumen de actividades
- **members/**: Gestión de miembros del gimnasio
- **workout/**: Rutinas de ejercicios y seguimiento
- **profile/**: Perfil de usuario y configuraciones