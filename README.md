# sinagencias-shared

Librería compartida para **sinagencias-web** y **sinagencias-api** (dentro del mismo proyecto).

**Ubicación:** `/SINAGENCIAS/shared/`

## Estructura

```
shared/
├── memory/              # Contexto, decisiones, tareas pendientes
├── docs/                # Documentación completa
│   ├── business/        # Modelo, análisis financiero
│   ├── legal/           # Compliance, plantillas
│   ├── tech/            # ADRs, arquitectura
│   ├── ux/              # Flujos, diseño
│   ├── marketing/       # GTM, SEO, copy
│   ├── product/         # Especificaciones, tools
│   └── data/            # KPIs, research
├── scripts/             # Automatización
│   ├── sync-docs.sh     # Sincroniza docs entre repos
│   ├── setup-env.sh     # Configura .env automáticamente
│   └── install-sync-hooks.sh  # Git hooks
├── config/              # Configuraciones base
│   ├── eslint-base.js
│   ├── prettier-base.js
│   └── tsconfig-base.json
└── ROADMAP-TIERS.md     # Mapa maestro del proyecto
```

## Integración en repos

Cada repo (`web/` y `api/`) monta `shared/` como **git submodule**:

```
web/
├── shared/              (submodule → ../shared)
├── docs -> shared/docs/ (symlink)
└── ...

api/
├── shared/              (submodule → ../shared)
├── docs -> shared/docs/ (symlink)
└── ...
```

## Actualizar shared lib

1. Editar documentación o scripts en `web/shared/` o `api/shared/`

```bash
cd web/shared
git add memory/context.md
git commit -m "docs: update context"
git push origin master
```

2. Actualizar referencia en repo parent

```bash
cd ..
git add shared
git commit "chore: sync shared lib"
```

## Workflow local

Como `shared/` es un repo Git dentro de SINAGENCIAS:

```bash
# Ver cambios en shared
cd shared
git status

# Commit en shared
git add .
git commit -m "docs: update X"

# Volver a repo parent (web o api)
cd ../web
git add shared
git commit "chore: update shared"
```

---

**Creado:** 2026-05-19  
**Arquitectura:** Git submodules + symlinks  
**Propósito:** DRY (Don't Repeat Yourself) en múltiples repos
# sell-it-yourself-shared
