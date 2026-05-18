# sinagencias-shared

Librería compartida para proyectos **sinagencias-web** y **sinagencias-api**.

Contiene:
- Documentación compartida (memory, ROADMAP, ADRs, legal)
- Scripts de configuración y sincronización
- Configuraciones base (eslint, prettier, tsconfig)

## Estructura

```
docs/
  ├── memory/          # Contexto, decisiones, tareas pendientes
  ├── business/        # Modelo de negocio, análisis
  ├── legal/           # Compliance, plantillas legales
  ├── tech/            # ADRs, arquitectura
  ├── marketing/       # GTM, SEO, copy
  ├── product/         # Especificaciones, features
  ├── ux/              # Flujos, diseño
  └── data/            # KPIs, market research

scripts/
  ├── sync-docs.sh       # Sincroniza docs entre repos
  ├── setup-env.sh       # Configura .env automáticamente
  └── install-sync-hooks.sh  # Instala git hooks

config/
  ├── eslint-base.js     # Config base ESLint
  ├── prettier-base.js   # Config base Prettier
  └── tsconfig-base.json # Config base TypeScript
```

## Uso en repos

Como **git submodule** en web y api:

```bash
git submodule add https://github.com/yourusername/sinagencias-shared.git shared
git submodule update --init --recursive
```

Luego en web y api, importar desde `shared/docs/` y usar scripts desde `shared/scripts/`.

## Actualizar shared lib

```bash
cd shared
git add .
git commit -m "docs: update shared documentation"
git push

# En repo parent (web o api)
git add shared
git commit "chore: update submodule sinagencias-shared"
```

---

**Creado:** 2026-05-19
**Propósito:** Mantener DRY (Don't Repeat Yourself) en repos independientes
