# decisions.md — Registro de decisiones del proyecto

> **Instrucción para el agente:** Lee este archivo antes de proponer cualquier decisión estratégica,
> de producto o técnica. No contradigas las decisiones marcadas como ✅ Confirmada sin justificación explícita.
> Cuando se tome una nueva decisión relevante, añádela aquí con el formato establecido.

---

## Decisiones confirmadas

### [D-001] Foco exclusivo en el vendedor particular (no agencias)
- **Fecha:** 2026-04-25
- **Área:** Negocio
- **Estado:** ✅ Confirmada
- **Decisión:** El portal está diseñado para el propietario que vende sin intermediario. No se aceptarán anuncios de agencias inmobiliarias en la fase inicial.
- **Alternativas descartadas:** Modelo mixto particulares + agencias (diluye propuesta de valor).
- **Impacto:** F3, F4, F8. Condiciona posicionamiento, modelo de negocio y captación.

---

### [D-002] Mercado objetivo: España (castellano)
- **Fecha:** 2026-04-25
- **Área:** Negocio
- **Estado:** ✅ Confirmada
- **Decisión:** El portal opera en España, en español. No se contempla internacionalización en las fases iniciales.
- **Alternativas descartadas:** Portugal como segundo mercado (descartado para MVP).
- **Impacto:** F7 (normativa española), F6 (integraciones con Catastro español).

---

### [D-003] Estructura de 10 fases de conceptualización antes del código
- **Fecha:** 2026-04-25
- **Área:** Producto
- **Estado:** ✅ Confirmada
- **Decisión:** El proyecto se estructura en 10 fases de conceptualización antes de escribir una línea de código del portal completo.
- **Alternativas descartadas:** Comenzar con prototipo técnico inmediato.
- **Impacto:** Todo el proyecto.

---

### [D-004] Estrategia de entrada: tools-first, coste cero, escalado progresivo
- **Fecha:** 2026-04-25
- **Área:** Negocio / Producto
- **Estado:** ✅ Confirmada
- **Decisión:** El proyecto NO arranca construyendo el portal completo (MVP tradicional). Arranca con un catálogo de 6 herramientas gratuitas independientes optimizadas para SEO. El MVP del portal se construye cuando las herramientas demuestren tráfico y audiencia reales.
- **Contexto:** Proyecto personal paralelo a trabajo actual. El fundador opera solo. La estrategia tools-first elimina el problema del cold start, reduce el riesgo a casi cero y valida la demanda antes de invertir tiempo en el portal completo.
- **Alternativas descartadas:** MVP completo desde el inicio (descartado por coste de oportunidad y riesgo de construir sin validación).
- **Referencia:** `docs/business/model/cost-free-structure.md`
- **Impacto:** Condiciona la prioridad de todas las fases restantes.

**Secuencia derivada de esta decisión:**
```
Tier 1 → 6 herramientas gratuitas (calculadoras + checklist), pure front-end, ~0 €/mes
Tier 2 → Valorador de mercado + generador de arras, ~50–200 €/mes
Tier 3 → MVP portal completo (cuando haya métricas que lo justifiquen)
```

**Umbrales para avanzar de Tier 1 a Tier 2 (al menos 3 de 6):**
- >5.000 sesiones orgánicas/mes
- >1.000 emails capturados
- ≥3 herramientas con >500 sesiones/mes
- Tasa de captura email >8%
- NPS herramientas >50
- Usuarios preguntando activamente si pueden publicar su anuncio

---

### [D-005] Fundador opera en solitario — sin equipo externo en Tier 1–2
- **Fecha:** 2026-04-25
- **Área:** Operaciones
- **Estado:** ✅ Confirmada
- **Decisión:** Carlos cubre todo: desarrollo (React + Node), diseño visual, UX, redacción SEO y customer success. No hay contrataciones hasta alcanzar ~20–30 operaciones/mes en el portal.
- **Impacto:** Coste MVP Tier 1: ~0 €/mes. Coste Tier 2: ~50–200 €/mes. El cuello de botella es el tiempo, no el dinero.

---

### [D-006] Blog en Tier 1 — infraestructura MDX + publicación progresiva
- **Fecha:** 2026-04-25
- **Área:** Producto / SEO
- **Estado:** ✅ Confirmada
- **Decisión:** El blog se construye en Tier 1 como infraestructura MDX (archivos `.mdx` en el repositorio, sin CMS ni base de datos). Los artículos se publican progresivamente, no todos de golpe.
- **Secuencia de publicación:**
  - Lanzamiento: 4 artículos prioritarios (T2 plusvalía, T3 IRPF, T4 documentos, pillar page "vender piso sin agencia")
  - Semana 2–3: 3 artículos secundarios
  - Semana 3–4: 3 artículos restantes
- **Alternativas descartadas:** Esperar al Tier 3 para el blog (descartado — las herramientas posicionan mejor con artículo companion), CMS externo (descartado — sobreingeniería para Tier 1).
- **Referencia:** `docs/marketing/gtm/estrategia-gtm-tier1.md` (sección 3 — estructura del blog)

---

### [D-007] Next.js 15 App Router con route groups desde el día 1
- **Fecha:** 2026-04-25
- **Área:** Técnica
- **Estado:** ✅ Confirmada
- **Decisión:** El proyecto usa Next.js 15 con App Router. Desde el Tier 1 se separa el código en route groups `(marketing)/` (herramientas, blog, landing — público) y `(app)/` (reservado para auth y portal en Tier 2–3). Esta separación evita refactoring al añadir auth.
- **Alternativas descartadas:** Astro (no escala a auth/API routes), Remix (requiere servidor propio), SPA (sin SSR/SEO).
- **Referencia:** `docs/tech/adr/ADR-001-framework-nextjs-app-router.md`, `docs/tech/architecture/architecture-scalable.md`

---

### [D-008] Código 100% en inglés — documentación y UI en español
- **Fecha:** 2026-04-25
- **Área:** Técnica
- **Estado:** ✅ Confirmada
- **Decisión:** Todos los identificadores de código (variables, funciones, tipos, constantes) se escriben en inglés, incluyendo conceptos del dominio inmobiliario (`calculatePropertyValueTax`, `salePrice`, `isHabitualResidence`). La documentación en `docs/`, los comentarios de código, los textos de UI y los commits se escriben en castellano.
- **Referencia:** `docs/tech/adr/ADR-002-conventions.md` (sección 3 — Idioma)

---

### [D-010] Estructura del repo frontend: feature-first
- **Fecha:** 2026-04-26
- **Área:** Técnica
- **Estado:** ✅ Confirmada
- **Decisión:** El repo `sinagencias-web` se organiza con patrón feature-first (`src/features/[name]/`) en lugar de layer-first. Cada herramienta es un módulo autocontenido con su propia public API (`index.ts`). Las rutas en `app/(marketing)/herramientas/` mantienen nombres en castellano por SEO (excepción consciente a D-008, justificada como única excepción documentada). Resto del repo: 100% inglés.
- **Mapeo brief → feature:**
  - T1 → `features/agency-savings/`
  - T2 → `features/property-value-tax/`
  - T3 → `features/capital-gains-tax/`
  - T4 → `features/document-checklist/`
  - T5 → `features/notary-fees/`
  - T6 → `features/net-sale-proceeds/`
- **Reglas de imports:** un feature no puede importar de otro feature excepto vía public API (`@/features/X` → `index.ts`). Excepción justificada: T6 compone T1+T2+T3+T5.
- **Alternativas descartadas:** Layer-first (no escala a Tier 3), rewrites en `next.config` para tener carpetas en inglés con URLs en castellano (sobreingeniería).
- **Referencia:** `docs/tech/adr/ADR-004-project-structure.md`

---

### [D-009] Arquitectura de backend: dos repos separados + NestJS
- **Fecha:** 2026-04-26
- **Área:** Técnica
- **Estado:** ✅ Confirmada
- **Decisión:** El frontend (Next.js) y el backend (NestJS) son repositorios independientes. No se usa monorepo. El backend expone una API REST; el frontend la consume via `NEXT_PUBLIC_API_URL`. Los tipos compartidos se duplican en Tier 1 (superficie mínima) y se extraen a `@vtm/shared` en Tier 2 si la superficie crece.
- **Repos:** `sinagencias-web` (Next.js, existente) · `sinagencias-api` (NestJS, pendiente de crear)
- **Hosting:** Vercel (frontend) + Railway o Render (backend)
- **Alternativas descartadas:** Monorepo pnpm workspaces (descartado por overhead innecesario en Tier 1), Next.js API routes como único backend (descartado — no escala a Tier 2–3 con lógica compleja).
- **Referencia:** `docs/tech/adr/ADR-003-backend-architecture.md`

---

### [D-011] Tailwind v4 CSS-first sin `tailwind.config.ts`
- **Fecha:** 2026-04-27
- **Área:** Técnica
- **Estado:** ✅ Confirmada
- **Decisión:** Adoptar Tailwind 4.x con la sintaxis CSS-first (`@import "tailwindcss";` + `@theme {}` en `globals.css`) y `@tailwindcss/postcss`. No se mantiene `tailwind.config.ts` — el tema se declara en CSS.
- **Razón:** v4 deprecó la config TS estándar. Mantener v3 supondría quedar fuera del soporte y perder los nuevos primitives. Los tokens del tema (`--color-*`, `--font-sans`, `--radius`) viven en `src/app/globals.css`.
- **Alternativas descartadas:** Anclar Tailwind v3.4 (descartado: deuda inmediata desde el día 1).

---

### [D-012] ~~UI primitives propias en lugar de shadcn~~ — SUPERSEDIDA por D-014
- **Fecha:** 2026-04-27
- **Estado:** ❌ Supersedida — ver D-014
- **Nota:** La preocupación original (shadcn reescribe globals.css rompiendo el tema de D-011) quedó invalidada al confirmar que shadcn v2+ soporta oficialmente Tailwind v4 y React 19 con el sistema de dos niveles CSS (`@layer base` + `@theme inline`). La migración se hizo con éxito manteniendo todos los tokens existentes.

---

### [D-014] Adopción de shadcn/ui como librería de componentes UI
- **Fecha:** 2026-04-27
- **Área:** Técnica
- **Estado:** ✅ Confirmada
- **Decisión:** Adoptar shadcn/ui (v2+) como sistema de componentes base. Los componentes viven en `src/components/ui/` generados por `npx shadcn@latest add`. El sistema de diseño usa dos niveles de CSS variables: nivel 1 semántico en `@layer base :root { --primary, --foreground… }` y nivel 2 de utilidades en `@theme inline { --color-primary: var(--primary)… }`. Los alias de compatibilidad (`--color-fg`, `--color-danger`, `--color-success`) se mantienen para no romper los 20+ componentes existentes.
- **Componentes instalados:** `button`, `input`, `label`, `card`, `badge`, `accordion`, `separator`
- **Razón:** shadcn v2+ soporta oficialmente Tailwind v4 + React 19 (confirmado en docs). Aporta accesibilidad Radix UI (keyboard nav, aria), animaciones del accordion, y una base escalable para Tier 2–3 sin coste de mantenimiento propio.
- **Workaround de instalación:** `npx shadcn@latest add` en lugar de `pnpm dlx shadcn@latest add` (corepack keyid bug en el entorno local — no afecta al proyecto).
- **Alternativas descartadas:** Mantener primitivos propios (mayor mantenimiento, sin a11y avanzada de Radix).

---

### [D-013] Email capture en stub graceful hasta que el backend exista
- **Fecha:** 2026-04-27
- **Área:** Producto/Técnica
- **Estado:** ✅ Confirmada
- **Decisión:** El componente `EmailCaptureInline` está completamente construido (form RHF + Zod + consent + tracking stub) y llama a `subscribe()` con `AbortSignal.timeout(2000)`. Si el backend no responde, captura el error, loguea un warning y muestra "Gracias, te lo enviamos en unos minutos" optimista. Sin telemetría real hasta que T-123 esté en marcha.
- **Razón:** Permite construir y testear las tools del Tier 1 (T2, T3, T4...) en paralelo con el desarrollo del backend NestJS, sin bloquear ninguna tool por la falta del endpoint `/subscribers`.
- **Plan de salida del stub:** Cuando T-123 esté desplegado y la tabla `subscribers` exista, basta con apuntar `NEXT_PUBLIC_API_URL` al backend real — el `try/catch` y el optimismo se mantienen como salvaguarda permanente para fallos puntuales del backend, pero el "happy path" pasa a registrar suscriptores reales sin tocar el código.

---

### [D-015] Documentación educativa: /blog → /guias (nomenclatura semántica)
- **Fecha:** 2026-05-19
- **Área:** Producto / SEO
- **Estado:** ✅ Confirmada
- **Decisión:** Las 5 guías educativas (artículos evergreen sobre cómo vender piso sin agencia) se publican bajo la ruta `/guias` en lugar de `/blog`. La nomenclatura `/guias` es más semánticamente correcta para contenido howto/educativo permanente, mejora el posicionamiento en keywords educativas ("guía cómo vender"), y se alinea con el enfoque de herramientas + educación del Tier 1.
- **Cambios ejecutados:** Rutas `/blog` → `/guias`, carpetas `features/blog` → `features/guides`, tipos `BlogPost/BlogPostWithContent` → `GuidePost/GuidePostWithContent`, configuración de navegación (header link "Blog" → "Guías").
- **Contenido sin cambios:** Los 4 artículos (plusvalía, documentos, IRPF, vender-sin-agencia) se migran con sus rutas y referencias actualizadas.
- **Referencia:** Commit `9777932` (refactor: rename blog → guides)
- **Razón:** Semántica más precisa para Google's NLP, mejor CTR en SERPs educativas, consistencia con el posicionamiento de "soluciones educativas gratuitas".
- **Alternativas descartadas:** Mantener `/blog` (arriesgado — se posiciona contra el mismo público que el `/blog` tradicional de empresas; nuestro contenido no es noticias).

---

### [D-016] Package manager: npm en el dev de Carlos (corepack roto)
- **Fecha:** 2026-04-27
- **Área:** Operativa
- **Estado:** 🟡 Provisional
- **Decisión:** En el repo `sinagencias-web` se usa `npm` en local. La documentación de `tier1-stack.md` recomienda `pnpm`, pero `corepack enable pnpm` falla en la máquina del fundador con error de signature key (Node 20.15.1 / corepack 0.28.1). Funcionalmente para el proyecto la diferencia es nula — ambos producen el mismo árbol de `node_modules`.
- **Plan:** Cuando se actualice corepack (`npm i -g corepack@latest` con sudo) o se instale pnpm globalmente, migrar a pnpm con `npx pnpm import` (importa el `package-lock.json` actual a `pnpm-lock.yaml`) y añadir `"packageManager": "pnpm@9.x"` al `package.json`.
- **Riesgo controlado:** No afecta a CI ni deploy (Vercel autodetecta el lock file presente).

---

## Preguntas abiertas que requieren decisión

| ID | Pregunta | Área | Urgencia | Cuándo decidir | Estado |
|----|----------|------|----------|----------------|--------|
| Q-001 | ¿Lanzamiento local (Madrid/Barcelona) o nacional desde el día 1? | Negocio | Baja | Al preparar GTM Tier 3 | ⬜ Abierta |
| Q-003 | ¿Valorador propio o API externa (Tinsa/Idealista Data)? | Técnica | Media | Al construir T7 (Tier 2) | ⬜ Abierta |
| Q-004 | ¿El portal gestiona firma digital o deriva a notaría externa? | Legal/Producto | Baja | Al planificar Tier 3 | ⬜ Abierta |
| Q-005 | ¿Nombre comercial definitivo del portal? | Marketing | Media | Antes del primer deploy público | ⬜ Abierta |
