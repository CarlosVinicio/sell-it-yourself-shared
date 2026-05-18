# context.md — Estado actual del proyecto

> **Instrucción para el agente:** Lee este archivo al inicio de cada sesión antes de responder.
> Actualízalo al cerrar la sesión: fecha, fases, última sesión, próximos pasos.

---

## Estado general

| Campo | Valor |
|-------|-------|
| Proyecto | SINAGENCIAS.ES |
| Tier activo | **Tier 1** — herramientas gratuitas SEO |
| Fase de construcción | Scaffolding ✅ + T2 ✅ + coeficientes verificados ✅ + OG image ✅ + blog infraestructura ✅ + artículo companion ✅ — pendiente: disclaimer fiscal, backend NestJS, T3-T6, deploy |
| Arquitectura | Dos repos en `/Documents/Personal/Proyectos/SinAgencias/`: `web/` (Next.js) · `api/` (NestJS) |
| Última actualización | 2026-04-30 (sesión 5) |

### Contexto de la última sesión (2026-04-27, sesión 3)
- **Migración a shadcn/ui (D-014):** `globals.css` reescrito con sistema de dos niveles (nivel 1: variables semánticas en `@layer base :root`; nivel 2: utilidades Tailwind en `@theme inline`). Componentes `button`, `input`, `label`, `card`, `badge`, `accordion`, `separator` instalados vía `npx shadcn@latest add`. Accordion migrado a Radix UI con keyboard nav + animaciones. Renombradas 37 referencias `--color-muted` → `--color-muted-foreground` (mismatch semántico shadcn). D-012 supersedida por D-014.
- **Landing page (T-119) construida:** `src/app/(marketing)/page.tsx` + 8 componentes en `src/components/marketing/` — HeroSection (H1 serif + ilustración SVG + blob CSS cross-column), TrustBar, ToolCard, ToolsSection (6 tools con iconos Lucide), HowItWorksSection (3 pasos + mini casa + stats), WhyDifferentSection (4 ítems), CtaSection (email capture inline). Metadata SEO con `title: { absolute: … }`.
- **Ilustración SVG:** `HouseIllustration.tsx` — Server Component, 0 KB JS cliente. Blob extraído al CSS del HeroSection para que cruce la frontera de columnas en desktop.
- Build OK: 19 páginas pre-renderizadas, typecheck limpio.
- Construida T2 completa (`features/property-value-tax/`): coeficientes RDL 26/2021, función pura `calculatePropertyValueTax`, schema Zod con superRefine, FAQs (7), JSON-LD `HowTo` + `FAQPage`, calculator con form + result + disclaimer.
- Stub local del email-capture: form completo con fallback optimista cuando el backend NestJS aún no responde.
- Tests: 10 escenarios (no incremento, ambos métodos, tope 20 años, redondeo, edge cases) — **100 % cobertura** en `lib/calculate-*.ts` y `lib/coefficients.ts`.
- Build OK: 18 páginas pre-renderizadas, T2 = 35.2 kB (141 kB First Load JS). `typecheck`, `lint`, `test:coverage` y `next build` limpios. Smoke en `localhost:3000` devuelve 200 con HTML correcto.
- ✅ **Coeficientes IIVTNU verificados**: tabla del RDL 8/2023 (art. 24), vigente desde 28/01/2026. El RDL 16/2025 fue rechazado por el Congreso el 27/01/2026. 13 coeficientes actualizados en `coefficients.ts`, tests actualizados, 100% coverage.
- ✅ **OG image**: `public/og/property-value-tax.png` (1200×630, 60KB) generada con sharp + SVG. Script en `scripts/generate-og-image.mjs`.
- ✅ **Blog infraestructura**: `next-mdx-remote` v6 + `gray-matter` instalados. `features/blog/lib/posts.ts` (getAllPosts, getPostBySlug). Rutas `/blog` y `/blog/[slug]` operativas. `@tailwindcss/typography` para estilos de artículo.
- ✅ **Artículo companion**: `src/content/blog/como-calcular-plusvalia-municipal.mdx` (~1.800 palabras, tabla de coeficientes, ejemplos de cálculo, preguntas frecuentes, enlace a la herramienta).
- Build: 19 páginas pre-renderizadas (era 18). El artículo se pre-renderiza como SSG en el build.
- 🔴 **Único bloqueador restante para deploy**: revisar disclaimer de `PropertyValueTaxResult.tsx` con asesor fiscal.

### Contexto de la sesión actual (2026-04-30, sesión 4 - continuación)
- **Estructura de carpetas reorganizada:** Ambos repos movidos a `/Documents/Personal/Proyectos/SinAgencias/` con nombres `web/` y `api/`
- **Repositorio sinagencias-api creado:** Proyecto NestJS independiente en `SinAgencias/api/`
- **Documentación trasladada:** Toda la carpeta `docs/` copiada a ambos repos (single source of truth duplicada)
- **CLAUDE.md específico del backend:** Creado en `api/.claude/CLAUDE.md` con rol de especialista en NestJS + APIs + RGPD
- **Scaffolding NestJS completado:** `src/app.module.ts`, `src/main.ts`, `package.json`, `tsconfig.json`, `nest-cli.json`, `.env.example` (commit b7d7ced)
- **T-123b completado:** Módulo subscribers con Supabase + Resend (commit 5cc3b8c):
  * Instaladas deps: @supabase/supabase-js, resend, class-validator, class-transformer
  * CreateSubscriberDto con validación email + RGPD consent
  * SubscribersService: integración Supabase (insert + duplicate check) + Resend email
  * SubscribersController: POST /subscribers → HTTP 201
  * HealthModule: GET /health, GET /health/ready
  * ESLint + Prettier configurados
  * Build ✅ | Lint ✅
- T-113b descartado como bloqueador — el disclaimer de T2 es defensible. Tarea T-311 añadida para validar disclaimers con asesor ANTES del deploy público masivo.

- **Documentación API reorganizada (post T-123b):**
  * Eliminada duplicación: business/, data/, marketing/, product/, research/, ux/ removidas del repo API
  * Creada docs/tech/api/ con 6 documentos backend-specific: overview, endpoints, schema, email, error handling, README
  * Actualizado api/.claude/CLAUDE.md con nuevas referencias
  * Estrategia: memoria sincronizada manualmente, tech/adr y legal/compliance como referencias (read-only)
  * Commit: ada5419 — refactor docs clean architecture

### Sesión actual (2026-04-30, sesión 5)
- **T-120 completado:** 4 artículos de blog SEO escritos y committed:
  * `cuanto-cobra-una-agencia-inmobiliaria.mdx` — desglose de comisiones (3–5%), a quién se cobra, negociación, comparativa
  * `documentos-necesarios-vender-piso-ccaa.mdx` — checklist por comunidad autónoma, documentos obligatorios vs. falsos
  * `irpf-venta-piso-guia-completa.mdx` — IRPF progresivo (19–28%), ganancia patrimonial, exención por reinversión
  * `vender-piso-sin-agencia-guia-paso-a-paso.mdx` — guía de 7 pasos (tasación, documentos, publicar, interesados, negociar, notaría)
  * Todos con H1 SEO optimizado, tabla de contenidos, CTAs internas a herramientas, FAQs, ejemplos reales, enlaces de email capture
  * Commit: 5610d9c — también sincronizó docs/ compartida (memory/, ROADMAP, ADRs, legal/) a repo api/ vía hooks
- **Git hooks automáticos activados:** Post-commit hook sinc web→api. Repos están in-sync en documentación.

### Próximos pasos sugeridos
1. **T-112** — configurar Supabase: crear tabla `subscribers` en DB, generar anon key + service key, actualizar `.env` local en ambos repos
2. **T-114 o T-116** — construir siguiente herramienta (T3 IRPF o T1 ahorro vs agencia) — reutiliza primitivas de T2
3. **T-121** — SEO técnico: sitemap, structured data (HowTo + FAQ schema), meta tags por herramienta
4. **T-122** — deploy Vercel + Google Search Console + dominio antes de primer test público

---

## Enfoque estratégico activo — TOOLS-FIRST (D-004)

El proyecto arranca con 6 herramientas gratuitas independientes optimizadas para SEO. No hay portal completo, no hay auth, no hay listings. El MVP del portal (Tier 3) se construye cuando las herramientas tengan tráfico y audiencia validados.

```
Tier 1 (AHORA):  6 calculadoras/checklist, pure front-end, ~0 €/mes
Tier 2 (mes 2–6): Valorador de mercado + generador de arras, ~50–200 €/mes
Tier 3 (mes 6–18): MVP portal completo, cuando métricas lo justifiquen
```

→ Análisis completo: `docs/business/model/cost-free-structure.md`
→ Mapa maestro de tiers: `docs/ROADMAP-TIERS.md`

---

## Perfil del fundador

- **Carlos** — programador senior (React, Node, UX, diseño visual, SEO, customer success)
- Opera en solitario. Cubre todo el stack sin coste externo.
- Proyecto personal paralelo a trabajo actual. Compatible con tools-first.
- Coste de infraestructura Tier 1: ~0 €/mes (Vercel + Supabase free tier).

---

## Progreso de fases estratégicas

| Fase | Nombre | Estado | Output principal |
|------|--------|--------|-----------------|
| F1 | Conceptualización y glosario | ✅ Completada | `docs/business/glosario.md` |
| F2 | Ideas y funcionalidades | ✅ Completada | `docs/product/features/inventario-funcionalidades.md` |
| F3 | Análisis de competencia | ✅ Completada | `docs/data/market-research/analisis-competencia.md` |
| F4 | Modelo de negocio + análisis financiero | ✅ Completada | `docs/business/model/` (5 archivos) |
| F5 (Tier 1) | Arquitectura UX — herramientas | ✅ Completada | `docs/ux/flows/ux-tier1.md` |
| F6 (Tier 1) | Arquitectura técnica escalable | ✅ Completada | `docs/tech/architecture/architecture-scalable.md` |
| F7 (Tier 1) | Marco legal y compliance | ✅ Completada | `docs/legal/compliance/compliance-tier1.md` |
| F8 (Tier 1) | Go-to-market | ✅ Completada | `docs/marketing/gtm/estrategia-gtm-tier1.md` |
| F9 (Tier 1) | Métricas y KPIs | ✅ Completada | `docs/data/kpis/kpis-tier1.md` |
| F5–F10 (Tier 3) | Fases completas del portal | ⬜ Pendiente | Ejecutar cuando Tier 1–2 tenga tracción |
| F10 | Roadmap MVP completo | ⬜ Pendiente | Ejecutar en Tier 3 |

**Nota:** Las versiones Tier 1 de F5–F9 están completas. Las versiones completas (Tier 3) de F5–F10 se ejecutan cuando haya tracción validada — ver condiciones en `docs/ROADMAP-TIERS.md`.

---

## Documentos técnicos clave del Tier 1

| Documento | Propósito |
|-----------|-----------|
| `docs/ROADMAP-TIERS.md` | Mapa maestro: qué se construye en cada Tier y cuándo se pasa al siguiente |
| `docs/tech/architecture/tier1-stack.md` | Stack completo, estructura de carpetas, bootstrap del proyecto |
| `docs/tech/architecture/architecture-scalable.md` | Route groups, esquema DB evolutivo, estrategia de caching por tipo de página |
| `docs/tech/adr/ADR-001-framework-nextjs-app-router.md` | Decisión: Next.js 15 App Router vs. alternativas |
| `docs/tech/adr/ADR-002-conventions.md` | Convenciones de código (nombrado, idioma, imports, tooling) |
| `docs/tech/adr/ADR-003-backend-architecture.md` | Decisión: dos repos separados + NestJS |
| `docs/tech/adr/ADR-004-project-structure.md` | Estructura feature-first, mapeo brief→feature, reglas de imports |
| `docs/ux/flows/ux-tier1.md` | Journeys, plantilla de herramienta, 5 principios UX, CTAs por herramienta |
| `docs/marketing/gtm/estrategia-gtm-tier1.md` | H1, title tag, meta description, keyword y CTA por cada una de las 6 herramientas |
| `docs/product/tools/T?-*.md` | **Brief único por herramienta** — al construir T?, leer solo CLAUDE.md + memoria + brief |

---

## Contexto de la última sesión (2026-04-26)

### Qué se hizo
- Ejecutadas F5–F9 Tier 1 en sesión anterior (2026-04-25): UX, arquitectura, compliance, GTM, KPIs
- Creados briefs de herramientas T1-T6 + plantilla `_template.md` (commit `8d1c2c5`)
- Creado ADR-002 (convenciones de código) y corregidos todos los identificadores a inglés
- Creados agentes especializados: `seo-inmobiliario`, `ux-ui-inmobiliario` (commit `5b0403d`)
- Creado **ADR-003** (backend separado + NestJS) — D-009 (commit `247a2ee`)
- Creado **ADR-004** (estructura feature-first del frontend) — D-010, sesión actual
- Reescritos `tier1-stack.md` y `architecture-scalable.md` con estructura feature-first
- Actualizados los 6 briefs T1-T6 con rutas a `features/[name]/...` y Definition of Done
- Actualizado ADR-002 con reglas de imports entre features y mapeo de carpetas castellano/inglés

### Decisiones tomadas en esta sesión
- D-006: Blog en Tier 1 — infraestructura MDX sí, 4 artículos prioritarios en lanzamiento, resto progresivo
- D-007: Route groups `(marketing)` / `(app)` desde el día 1 para no reescribir en Tier 2–3
- D-008: Código 100% en inglés, documentación y UI 100% en español (ADR-002)
- D-009: Dos repos separados — `sinagencias-web` (Next.js) + `sinagencias-api` (NestJS). Sin monorepo. (ADR-003)
- D-010: Estructura feature-first del repo frontend. Mapeo brief→feature: T1→agency-savings, T2→property-value-tax, T3→capital-gains-tax, T4→document-checklist, T5→notary-fees, T6→net-sale-proceeds. Carpetas de ruta en `app/(marketing)/herramientas/` en castellano por SEO (única excepción consciente a D-008). (ADR-004)

### Próximos pasos
1. **T-111: Scaffolding `sinagencias-web`** — estructura `app/`, `components/`, `lib/` según `architecture-scalable.md` y `ADR-002`
2. **T-123: Scaffolding `sinagencias-api`** — proyecto NestJS con módulo `subscribers`, integración Supabase + Resend
3. **T-122: Configurar Vercel + Railway/Render + dominio** — antes del primer deploy
4. **T-112: Configurar Supabase** — tabla `subscribers`, variables de entorno en ambos repos
5. **T-113: Construir T2** (Calculadora plusvalía municipal) — mayor keyword del Tier 1
