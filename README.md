# FitManager
Este proyecto es una aplicación movil para el registro y seguimiento de las personas en un gimnasio. 

## Reglas de Colaboración (GitHub Flow)

- **Ramas**
  - `main`: rama estable y protegida. Nunca se codea directo aquí.
  - Feature: `feature/<modulo>-<breve-descripcion>` (ej: `feature/perfil-medidas`).
  - Hotfix: `hotfix/<breve-descripcion>` para arreglos urgentes.
  - Chore/Docs: `chore/...`, `docs/...` para tareas de soporte.

- **Flujo**
  1) Crea un *issue* → 2) Crea tu rama desde `main` → 3) Commits pequeños (Conv. Commits: `feat: ...`, `fix: ...`, `docs: ...`, `chore: ...`) →  
  4) Abre **Pull Request** hacia `main` enlazando el issue → 5) **1+ review** aprobatoria → 6) **Squash & merge** → 7) Borra la rama.

- **Pull Requests**
  - Incluye: objetivo, cómo probar, screenshots si aplica.
  - Máximo ~300–400 líneas por PR cuando sea posible.
  - Resolver conversaciones antes de merge.

- **Calidad**
  - Sin secretos en el repo. Usa `.env` local y variables de entorno.
  - Tests y linters (si están configurados) deben pasar antes de merge.

- **Releases & tags** (opcional)
  - Versionado semántico: `vX.Y.Z` en cada entrega importante.

