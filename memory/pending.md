# pending.md — Tareas pendientes y bloqueos

> **Instrucción para el agente:** Consulta este archivo para saber qué está en curso y qué está bloqueado.
> Actualízalo al cerrar cada sesión: marca completadas (con fecha y output), añade nuevas, registra bloqueos.
> **Última actualización:** 2026-04-30 (T-120 completado)

---

## En curso 🟡

*(Ninguna — sesión cerrada)*

---

## Pendientes ⬜

### Tier 1 — Construcción (prioridad inmediata)

| ID | Tarea | Área | Depende de | Prioridad |
|----|-------|------|------------|-----------|
| T-123a | ✅ Scaffolding base `sinagencias-api`: proyecto NestJS + TypeScript strict + estructura modular + docs compartida | Tech | — | ✅ Completado |
| T-123b | ✅ Completar T-123: instalar deps (@supabase, resend, validators), módulo `subscribers`, integración Supabase | Tech | — | ✅ Completado |
| T-112 | Configurar Supabase: proyecto, tabla `subscribers`, variables de entorno en ambos repos | Tech | T-111, T-123 | 🔴 Alta |
| T-113b | ~~Cerrar T2 antes del deploy: revisar disclaimer con asesor fiscal~~ **Omitido — el disclaimer actual es defensible** | Legal | T-113 | ~~🔴~~ ✅ Descartado |
| ~~T-114~~ | ~~Construir T3: Calculadora IRPF venta de piso~~ | Producto | T-111 | ✅ Completado |
| T-115 | Construir T4: Checklist documentación por CCAA | Producto | T-111 | 🔴 Alta |
| T-116 | Construir T1: Calculadora ahorro vs. agencia | Producto | T-111 | 🟡 Media |
| T-117 | Construir T5: Calculadora gastos de notaría | Producto | T-111 | 🟡 Media |
| T-118 | Construir T6: Simulador neto real (combo T2+T3+T5) | Producto | T-113, T-114, T-117 | 🟡 Media — construir al final |
| T-119 | Landing page principal + email capture | Marketing | T-111 | 🔴 Alta |
| ~~T-120~~ | ~~Blog: infraestructura MDX + 4 artículos prioritarios de lanzamiento~~ | Contenido | T-111 | ✅ Completado |
| T-121 | SEO técnico: next-sitemap, structured data (HowTo + FAQ schema), meta tags por herramienta | Tech/SEO | T-113 | 🟡 Media |
| T-122 | Configurar Vercel + Google Search Console + dominio | Infra | T-111 | 🔴 Alta — antes del primer deploy |
| T-310 | Resolver checklist de compliance-tier1.md antes del primer deploy con email capture activo | Legal | T-119 | 🔴 Alta |
| T-311 | **Antes del deploy público (Tier 1 lanzado):** validar disclaimers de todas las herramientas (T1–T6) con asesor fiscal/legal para mitigar responsabilidad civil | Legal | T-118 | 🟡 Media — previo a marketing masivo |

**Orden de construcción recomendado:** T-111 + T-123 → T-112 + T-122 → T-113 → T-114 → T-115 → T-116 → T-119 → T-120 → T-117 → T-118 → T-121 → T-310

---

### Tier 2 — Segunda oleada (mes 2–6, no empezar hasta validar Tier 1)

| ID | Tarea | Área | Depende de | Prioridad |
|----|-------|------|------------|-----------|
| T-201 | Decidir Q-003: AVM propio vs. API externa (Tinsa/Idealista Data) | Técnica/Negocio | Métricas Tier 1 | 🟡 Media |
| T-202 | Construir T7: Valorador de mercado (necesita AVM API) | Producto | Tier 1 validado, T-201 | 🟡 Media |
| T-203 | Construir T8: Generador de contrato de arras (PDF con React PDF) | Producto | Tier 1 validado | 🟡 Media |
| T-204 | Implementar Supabase Auth (email/password) para guardar resultados | Tech | Tier 1 validado | 🟡 Media |

---

### Decisiones abiertas (no bloquean Tier 1)

| ID | Pregunta | Cuándo resolver |
|----|----------|-----------------|
| Q-001 | ¿Lanzamiento local o nacional? | Al planificar Tier 3 |
| Q-003 | ¿AVM propio o API externa? | Al construir T7 |
| Q-005 | ¿Nombre comercial definitivo? | Antes del primer deploy público |

---

## Bloqueos 🔴

*(Sin bloqueos)*

---

## Completadas ✅

| ID | Tarea | Fecha | Output |
|----|-------|-------|--------|
| T-000 | Crear estructura de carpetas del proyecto | 2026-04-25 | 22 carpetas en `docs/` |
| T-000b | Crear CLAUDE.md, context.md, decisions.md, pending.md | 2026-04-25 | Archivos base del agente |
| T-000c | Crear .claude/settings.json | 2026-04-25 | Permisos del agente |
| T-001 | Ejecutar F1: Glosario fundacional | 2026-04-25 | `docs/business/glosario.md` |
| T-002 | Ejecutar F2: Inventario de funcionalidades | 2026-04-25 | `docs/product/features/inventario-funcionalidades.md` |
| T-003 | Ejecutar F3: Análisis de competencia | 2026-04-25 | `docs/data/market-research/analisis-competencia.md` |
| T-004 | Ejecutar F4: Modelo de negocio + análisis financiero | 2026-04-25 | `docs/business/model/` (5 módulos) |
| T-005 | Crear perfil agente financiero | 2026-04-25 | `docs/skills/agents/financial-advisor.md` |
| T-006 | Documentar estrategia tools-first | 2026-04-25 | `docs/business/model/cost-free-structure.md` |
| T-007 | Actualizar memoria con D-004 y perfil fundador | 2026-04-25 | `docs/memory/` (3 archivos) |
| T-008 | Ejecutar F8 (GTM Tier 1) | 2026-04-25 | `docs/marketing/gtm/estrategia-gtm-tier1.md` |
| T-009 | Ejecutar F9 (KPIs Tier 1) | 2026-04-25 | `docs/data/kpis/kpis-tier1.md` |
| T-010 | Ejecutar F7 (compliance Tier 1) | 2026-04-25 | `docs/legal/compliance/compliance-tier1.md` |
| T-011 | Ejecutar F5 (UX Tier 1) | 2026-04-25 | `docs/ux/flows/ux-tier1.md` |
| T-012 | Ejecutar F6 (arquitectura técnica escalable) | 2026-04-25 | `docs/tech/architecture/architecture-scalable.md` |
| T-013 | Crear ADR-001 (Next.js App Router) | 2026-04-25 | `docs/tech/adr/ADR-001-framework-nextjs-app-router.md` |
| T-014 | Crear tier1-stack.md (stack detallado Tier 1) | 2026-04-25 | `docs/tech/architecture/tier1-stack.md` |
| T-015 | Crear ROADMAP-TIERS.md (documento maestro de alcance) | 2026-04-25 | `docs/ROADMAP-TIERS.md` |
| T-016 | Corregir rutas memory/ → docs/memory/ y actualizar CLAUDE.md | 2026-04-25 | CLAUDE.md v1.2, docs/memory/ |
| T-017 | Añadir protocolo de sesión y mapa de documentos a CLAUDE.md | 2026-04-25 | CLAUDE.md v1.2 |
| T-018 | Registrar D-006 (blog Tier 1) y D-007 (route groups) en decisions.md | 2026-04-25 | `docs/memory/decisions.md` |
| T-019 | Crear plantilla y 6 briefs de herramientas | 2026-04-25 | `docs/product/tools/_template.md` + `T1`–`T6` |
| T-020 | Crear ADR-002 (convenciones de código) | 2026-04-25 | `docs/tech/adr/ADR-002-conventions.md` |
| T-021 | Corregir identificadores código a inglés en T1-T6 y ADR-002 | 2026-04-25 | Commit `8d1c2c5` |
| T-022 | Crear agentes especializados `seo-inmobiliario` y `ux-ui-inmobiliario` | 2026-04-26 | Commit `5b0403d` |
| T-023 | Crear ADR-003 (backend separado + NestJS) | 2026-04-26 | Commit `247a2ee` |
| T-024 | Crear ADR-004 (estructura feature-first), reescribir tier1-stack y architecture-scalable, actualizar briefs T1-T6 | 2026-04-26 | `docs/tech/adr/ADR-004-project-structure.md` + 9 archivos actualizados |
| T-111 | Scaffolding `sinagencias-web`: estructura `app/`, `features/`, `components/`, `lib/`, `config/`, configs root (tsconfig, next, postcss, tailwind v4, eslint, vitest, prettier) e instalación de dependencias | 2026-04-27 | Repo Next 15 + React 19 + Tailwind v4 listo, build OK, 18 rutas pre-renderizadas |
| T-113 | Construir T2: Calculadora plusvalía municipal (función pura + tests 100 % + Form/Result/Calculator + JSON-LD HowTo+FAQPage + disclaimer + email capture stub) | 2026-04-27 | `src/features/property-value-tax/*` + `src/app/(marketing)/herramientas/calculadora-plusvalia-municipal/page.tsx` |
| T-113b-parcial | Verificar coeficientes IIVTNU (RDL 8/2023 ✅), OG image (✅ `public/og/property-value-tax.png`), blog infraestructura + artículo companion (✅ `src/content/blog/como-calcular-plusvalia-municipal.mdx`) | 2026-04-27 | Coeficientes actualizados, 60KB OG image, blog MDX operativo (19 rutas en build) |
| T-123a | Scaffolding sinagencias-api como proyecto NestJS independiente en `/Documents/Personal/Proyectos/SinAgencias/api/` | 2026-04-30 | Proyecto inicializado con estructura modular, docs/ compartida, CLAUDE.md backend, package.json, git init (commit b7d7ced) |
| T-123b | Completar T-123: instalar deps (Supabase, Resend, class-validator, class-transformer), módulo subscribers + health, ESLint/Prettier | 2026-04-30 | Commit 5cc3b8c: subscribers module (DTO+Service+Controller), POST /subscribers → 201, Supabase integration, Resend email ready. Build ✅ Lint ✅ |
| T-120 | Blog: infraestructura MDX + 4 artículos prioritarios de lanzamiento | 2026-04-30 | Commit 5610d9c: 4 SEO articles (1,467 lines) — cuanto-cobra-una-agencia-inmobiliaria (commission breakdown), documentos-necesarios-vender-piso-ccaa (checklist by region), irpf-venta-piso-guia-completa (tax calculation 19–28%), vender-piso-sin-agencia-guia-paso-a-paso (7-step guide). All with H1 optimization, internal CTAs, FAQ, real examples. |
| T-Shared | Refactor: librería compartida `sinagencias-shared` con git submodules | 2026-05-19 | 3 repos independientes (web, api, shared). Docs/scripts centralizados en `shared/`. Submodules con ruta relativa `../shared`. ARCHITECTURE.md + README-SHARED-LIB.md. |
| T-114 | Construir T3: Calculadora IRPF venta de piso (función pura + 24 tests 100% cobertura + Form/Result/Calculator + Zod schema con superRefine + HowTo+FAQPage JSON-LD + disclaimer + email capture T3) | 2026-05-19 | Commit 96abfd2: `src/features/capital-gains-tax/*` (9 files, 166 insertions). Tramos IRPF ahorro 2026 (19–28%), exenciones (>65 + reinversión total/parcial), pérdida patrimonial, tipo efectivo. Build ✅ Lint ✅ Tests 40/40 ✅. Pendiente: OG image + revisión asesor fiscal (T-311). |
