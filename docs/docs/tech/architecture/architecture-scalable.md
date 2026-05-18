# F6 · Arquitectura técnica escalable — Tier 1 → Tier 3

> Fase 6 ejecutada con enfoque de escalabilidad.
> Las decisiones de arquitectura del Tier 1 están tomadas para no reescribirse en Tier 2 ni Tier 3.
> Documento complementario: `docs/tech/architecture/tier1-stack.md` (stack detallado del Tier 1).
> ADR de framework: `docs/tech/adr/ADR-001-framework-nextjs-app-router.md`.

---

## Principio rector

**Construir para hoy, diseñar para mañana.** Cada decisión del Tier 1 debe ser:
1. Funcional hoy (sin sobreingeniería)
2. No un obstáculo en Tier 2–3 (sin deuda técnica estructural)

La regla de oro: si una decisión del Tier 1 requiere refactoring completo para el Tier 2, es una mala decisión de Tier 1.

---

## 1. Estructura de rutas — Route Groups desde el día 1

La decisión más importante de arquitectura del Tier 1 es la separación en route groups desde el inicio. Permite añadir auth y layout de portal en Tier 2–3 sin tocar las rutas de las herramientas.

> **Nota:** El frontend (`sinagencias-web`) NO contiene API routes de negocio. El backend vive en un repo independiente con NestJS (ver `ADR-003-backend-architecture.md`). Las únicas rutas en `app/api/` que pueden aparecer son utilitarias de Next.js (preview mode, OG image generation), nunca lógica de negocio.

```
src/app/
├── (marketing)/           ← Tier 1: páginas públicas, sin auth
│   ├── layout.tsx         ← Header/Footer público
│   ├── page.tsx           ← Landing principal (/)
│   ├── herramientas/      ← URLs en castellano por SEO (excepción consciente, D-008)
│   │   ├── page.tsx                                     ← /herramientas (catálogo)
│   │   ├── calculadora-plusvalia-municipal/page.tsx     ← T2
│   │   ├── calculadora-irpf-venta-piso/page.tsx         ← T3
│   │   ├── calculadora-ahorro-agencia/page.tsx          ← T1
│   │   ├── calculadora-gastos-notaria-compraventa/page.tsx ← T5
│   │   ├── checklist-documentacion-venta-piso/page.tsx  ← T4
│   │   └── simulador-neto-venta-piso/page.tsx           ← T6
│   ├── blog/
│   │   ├── page.tsx       ← Índice del blog
│   │   └── [slug]/page.tsx ← Artículo companion (MDX)
│   ├── privacidad/
│   ├── aviso-legal/
│   └── cookies/
│
└── (app)/                 ← Tier 2–3: área autenticada (vacío en Tier 1)
    ├── layout.tsx         ← Layout con sidebar + middleware de auth (Tier 2)
    ├── dashboard/         ← Panel del vendedor (Tier 3)
    ├── anuncio/           ← Publicación de inmueble (Tier 3)
    └── mis-herramientas/  ← Resultados guardados (Tier 2)
```

**Por qué este diseño:**
- Las rutas de `(marketing)` no tienen auth nunca — no hay guard que añadir después.
- Las rutas de `(app)` pueden tener un layout con middleware de auth sin afectar a `(marketing)`.
- La lógica de negocio del backend vive en repo separado (NestJS) — los `app/api/` del frontend solo existen para utilitarios de Next.js.
- Los nombres de carpeta dentro de `(marketing)/herramientas/` están en castellano porque son URLs públicas que necesitan posicionar SEO. **Es la única excepción a la regla de código en inglés (D-008), documentada en ADR-004.**

**El código de cada herramienta vive en `src/features/[english-name]/`. La página `app/.../page.tsx` es solo composición — importa del feature module y lo monta. Detalle completo en `ADR-004-project-structure.md`.**

---

## 2. Evolución del esquema de base de datos por Tier

El esquema de Supabase crece aditivamente. Nunca se rompe lo que ya existe.

### Tier 1 — Solo email capture

```sql
create table subscribers (
  id          uuid default gen_random_uuid() primary key,
  email       text not null unique,
  source      text,          -- qué herramienta capturó el email (T1, T2, etc.)
  ccaa        text,          -- comunidad autónoma si se captura en T4
  created_at  timestamptz default now()
);

create index on subscribers (source);
create index on subscribers (created_at);
```

La columna `source` es crítica para saber qué herramienta convierte mejor. Ver M7 en `docs/data/kpis/kpis-tier1.md`.

### Tier 2 — Auth + resultados guardados (añadir, no modificar)

```sql
-- Usuarios autenticados (Supabase Auth gestiona la tabla auth.users)
-- Esta tabla extiende auth.users con datos del producto
create table profiles (
  id          uuid references auth.users primary key,
  ccaa        text,
  created_at  timestamptz default now()
);

-- Resultados guardados de herramientas (requiere auth)
create table tool_results (
  id          uuid default gen_random_uuid() primary key,
  user_id     uuid references profiles(id) on delete cascade,
  tool_slug   text not null,        -- 'calculadora-plusvalia-municipal'
  input_data  jsonb not null,       -- inputs del formulario
  result_data jsonb not null,       -- resultado calculado
  created_at  timestamptz default now()
);

create index on tool_results (user_id, tool_slug);
create index on tool_results (created_at);
```

### Tier 3 — Portal completo (añadir, no modificar)

```sql
-- Inmuebles publicados
create table listings (
  id              uuid default gen_random_uuid() primary key,
  owner_id        uuid references profiles(id) on delete cascade,
  title           text not null,
  description     text,
  price           numeric(12,2),
  address         text,
  ccaa            text,
  municipality    text,
  surface_m2      numeric(8,2),
  rooms           smallint,
  status          text default 'draft',  -- draft|active|sold|withdrawn
  published_at    timestamptz,
  created_at      timestamptz default now(),
  updated_at      timestamptz default now()
);

-- Visitas programadas
create table visits (
  id          uuid default gen_random_uuid() primary key,
  listing_id  uuid references listings(id) on delete cascade,
  buyer_id    uuid references profiles(id),
  scheduled_at timestamptz not null,
  status      text default 'pending',  -- pending|confirmed|cancelled|done
  created_at  timestamptz default now()
);

-- Mensajes entre comprador y vendedor
create table messages (
  id          uuid default gen_random_uuid() primary key,
  listing_id  uuid references listings(id) on delete cascade,
  sender_id   uuid references profiles(id),
  body        text not null,
  created_at  timestamptz default now()
);

-- Documentos del Expediente Digital
create table documents (
  id          uuid default gen_random_uuid() primary key,
  listing_id  uuid references listings(id) on delete cascade,
  name        text not null,
  type        text,          -- certificado-energetico|nota-simple|dni|etc.
  storage_path text,         -- path en Supabase Storage
  uploaded_at timestamptz default now()
);
```

**Principio de evolución del esquema:** cada Tier solo AÑADE tablas o columnas opcionales. Nunca modifica el tipo de una columna existente ni elimina columnas. Las migraciones de Tier 2 y Tier 3 son `ALTER TABLE ... ADD COLUMN IF NOT EXISTS` o nuevas tablas.

---

## 3. Estrategia de auth — introducción progresiva

| Tier | Auth | Implementación |
|---|---|---|
| Tier 1 | ❌ Sin auth | No hay sesión. Solo email en tabla subscribers. |
| Tier 2 | ✅ Auth básico | Supabase Auth (email/password). Guardar resultados de herramientas. |
| Tier 3 | ✅ Auth completo | Supabase Auth + OAuth (Google). Perfil de vendedor/comprador. |

**Transición Tier 1 → Tier 2 sin romper nada:**
- Los subscribers existentes NO son usuarios. Cuando llegue Tier 2, se hace una campaña de email para que se registren. NO se migra la tabla subscribers a users automáticamente — son entidades distintas (subscriber = lead, user = cuenta activa).
- El middleware de Next.js para auth solo se activa en las rutas `(app)/*`. Las rutas `(marketing)/*` nunca tienen guard.

---

## 4. Estrategia de caching y renderizado por tipo de página

| Tipo de página | Estrategia | Razón |
|---|---|---|
| Landing principal `/` | SSG (estático) | No cambia frecuentemente. Máximo rendimiento. |
| Páginas de herramienta | SSG + ISR (revalidate: 86400) | El cálculo es client-side. El HTML de la página es estático. |
| Artículos del blog `/blog/[slug]` | SSG desde MDX | El contenido vive en archivos. Sin base de datos. |
| Catálogo `/herramientas` | SSG | Lista fija de 6 herramientas. |
| Páginas legales | SSG | Contenido estático. |
| API route `/api/subscribe` | Sin cache (Runtime) | Escribe en Supabase. |
| Dashboard (Tier 3) | SSR o RSC dinámico | Datos del usuario en tiempo real. |

**Los cálculos de las herramientas son 100% client-side en Tier 1.** No hay llamada a API para calcular plusvalía o IRPF — toda la lógica vive en el navegador. Esto hace que el resultado sea instantáneo y que no haya costes de servidor por cálculo.

La excepción es el Valorador de mercado (T7 del Tier 2): necesita una API externa (AVM). En Tier 2, ese cálculo pasará por una API route server-side para ocultar la clave de API.

---

## 5. Gestión de variables de entorno por Tier

```
# .env.local (desarrollo)
NEXT_PUBLIC_SUPABASE_URL=...
NEXT_PUBLIC_SUPABASE_ANON_KEY=...
SUPABASE_SERVICE_ROLE_KEY=...       ← Solo en server (API routes)
RESEND_API_KEY=...

# Tier 2 añadirá:
AVM_API_KEY=...                     ← API de valoración (Tinsa/Idealista)
REACT_PDF_FONT_URL=...

# Tier 3 añadirá:
STRIPE_SECRET_KEY=...
STRIPE_WEBHOOK_SECRET=...
IDEALISTA_API_KEY=...               ← Publicación en portales
```

**Regla de seguridad:** ninguna variable sin prefijo `NEXT_PUBLIC_` llega al cliente. Las API keys de servicios externos (Resend, AVM, Stripe) solo se usan en API routes server-side.

---

## 6. Estrategia de repositorios — dos repos separados desde el día 1 (D-009)

**Decisión:** dos repositorios independientes desde el inicio, no monorepo. La justificación completa está en `ADR-003-backend-architecture.md`.

| Repo | Stack | Responsabilidad | Hosting |
|---|---|---|---|
| `sinagencias-web` | Next.js 15 + TypeScript | UI, herramientas client-side, blog, SEO | Vercel |
| `sinagencias-api` | NestJS + TypeScript | Email capture, futura API de auth, AVM, PDFs | Railway o Render |

### Estructura del repo frontend (autoridad: ADR-004)

```
sinagencias-web/
├── src/
│   ├── app/                   ← Routing — URLs en castellano (SEO)
│   ├── features/              ← Módulos autocontenidos por herramienta
│   │   ├── agency-savings/         (T1)
│   │   ├── property-value-tax/     (T2)
│   │   ├── capital-gains-tax/      (T3)
│   │   ├── document-checklist/     (T4)
│   │   ├── notary-fees/            (T5)
│   │   ├── net-sale-proceeds/      (T6)
│   │   ├── email-capture/          (transversal)
│   │   └── blog/                   (MDX engine)
│   ├── components/            ← Compartidos: ui/, layout/, tool/, seo/
│   ├── lib/                   ← Infra: api/, format/, seo/, analytics/
│   ├── hooks/                 ← Hooks compartidos
│   ├── content/blog/          ← Artículos .mdx
│   ├── config/                ← site.ts, tools.ts, env.ts
│   └── types/
├── public/og/                 ← Open Graph images por tool
├── docs/                      ← Documentación del proyecto
├── .claude/                   ← Instrucciones del agente IA
└── tests/e2e/                 ← Playwright (opcional Tier 1)
```

**Detalle completo de la estructura, mapeo brief→feature y reglas de imports en `ADR-004-project-structure.md`.**

### Estructura del repo backend (NestJS)

```
sinagencias-api/
├── src/
│   ├── subscribers/           ← Tier 1: email capture
│   ├── supabase/              ← Cliente Supabase compartido
│   ├── email/                 ← Resend
│   ├── app.module.ts
│   └── main.ts
├── test/
├── .claude/                   ← CLAUDE.md propio del repo backend
└── package.json
```

Crecimiento por Tier (sin reorganizar):
- **Tier 2:** añade `auth/`, `tools/`, `valuation/`
- **Tier 3:** añade `listings/`, `visits/`, `messages/`, `documents/`, `payments/`

---

## 7. Lógica de cálculo — aislada y testeable desde el día 1

Las funciones de cálculo son el núcleo del producto. Cada herramienta tiene su función pura en `features/[name]/lib/calculate-[name].ts`. Sin efectos secundarios, sin dependencias de UI, sin acceso a DOM/red.

```typescript
// src/features/property-value-tax/lib/calculate-property-value-tax.ts
import type { PropertyValueTaxInput, PropertyValueTaxResult } from '../types';

export function calculatePropertyValueTax(
  input: PropertyValueTaxInput
): PropertyValueTaxResult {
  // ... implementación
}
```

```typescript
// src/features/property-value-tax/types.ts
export type PropertyValueTaxInput = {
  purchasePrice: number;
  salePrice: number;
  landCadastralValue: number;
  totalCadastralValue: number;
  purchaseDate: Date;
  saleDate: Date;
  taxRate: number;
};

export type PropertyValueTaxResult = {
  yearsOfOwnership: number;
  hasRealIncrease: boolean;
  objectiveMethod: { coefficient: number; taxableBase: number; taxDue: number };
  realMethod: { /* ... */ } | null;
  favorableMethod: 'objective' | 'real' | 'no-tax';
  totalTaxDue: number;
  savingsVsUnfavorableMethod: number;
};
```

**Por qué esto importa para la escalabilidad:**
- En Tier 2, si el backend NestJS necesita re-calcular en servidor (por ejemplo, para guardar resultados validados), la función pura se replica en el repo del API o se publica vía `@vtm/shared`. La lógica nunca está acoplada a React ni a Next.js.
- Los tests unitarios viven junto al archivo (`calculate-property-value-tax.test.ts`) — Vitest, sin dependencias de DOM.
- Cuando la normativa cambie (tramos IRPF 2027, coeficientes de plusvalía), el cambio es local al feature module.
- T6 (`net-sale-proceeds`) compone las funciones de T1, T2, T3 y T5 importándolas desde sus public APIs respectivas.

---

## 8. Blog — MDX sin base de datos

Los artículos companion del blog son archivos `.mdx` en el repositorio. No hay CMS, no hay base de datos de posts.

```typescript
// lib/blog.ts
import fs from 'fs';
import path from 'path';
import matter from 'gray-matter';

export function getAllPosts() {
  const contentDir = path.join(process.cwd(), 'content/blog');
  const files = fs.readdirSync(contentDir);
  // ...parsear frontmatter
}
```

**Frontmatter de cada artículo:**
```yaml
---
title: "Cómo calcular la plusvalía municipal al vender una vivienda"
slug: como-calcular-plusvalia-municipal
date: 2026-05-01
keyword: cómo calcular plusvalía municipal
tool: calculadora-plusvalia-municipal   ← Para el cross-link automático
description: "Guía completa sobre el impuesto de plusvalía municipal..."
---
```

**Cuándo migrar a CMS:** si el blog escala a >50 artículos o si hay un equipo de redacción externo. En Tier 1–2, los archivos MDX en git son suficientes y más rápidos de desplegar.

---

## 9. CI/CD y entornos

| Entorno | Trigger | URL | Base de datos |
|---|---|---|---|
| Development | Local | localhost:3000 | Supabase proyecto dev |
| Preview | PR o push a rama feature/* | *.vercel.app | Supabase proyecto dev |
| Production | Push a main | dominio.com | Supabase proyecto prod |

**Regla:** nunca apuntar el entorno de desarrollo a la base de datos de producción. Supabase permite crear proyectos separados en el free tier.

**Variables en Vercel:** configurar en el dashboard de Vercel para Production y Preview por separado. Los entornos de Preview usan las variables del proyecto dev.

---

## 10. Decisiones aplazadas conscientemente

Estas decisiones no se toman ahora para no sobre-diseñar el Tier 1. Se revisarán cuando haya datos.

| Decisión | Por qué se aplaza | Cuándo revisarla |
|---|---|---|
| Feature flags | No hay suficientes features concurrentes para justificarlo | Tier 2 si hay A/B de CTAs |
| Queue de emails con workers | Resend es suficiente para <1.000 suscriptores/mes | Tier 2 si el volumen lo requiere |
| CDN propio para imágenes | Vercel Image Optimization es suficiente para Tier 1 | Tier 3 con fotos de inmuebles |
| Search interno | No hay suficiente contenido para justificar un motor de búsqueda | Tier 3 si el blog supera 100 artículos |
| Internacionalización (i18n) | 100% español en Tier 1–2 | Tier 3 solo si hay decisión de expansión |
| Microservicios | Monolito Next.js es suficiente hasta 10K usuarios activos | Tier 3 si hay cuellos de botella medibles |

---

## 11. Hoja de ruta técnica por Tier

```
TIER 1 (ahora)
├── Next.js 15 + App Router + TypeScript
├── Tailwind CSS v4 + shadcn/ui
├── Supabase free tier (subscribers table)
├── Resend (email transaccional)
├── Vercel (deploy + analytics)
├── Google Search Console
├── next-sitemap
└── React Hook Form + Zod (validación de formularios)

TIER 2 (meses 2–6)
├── Supabase Auth (email/password)
├── Tabla profiles + tool_results
├── AVM API (Tinsa o Idealista Data) — proxy via API route
├── React PDF (generación de PDFs de resultado)
├── PostHog EU (analytics avanzado con embudo)
└── Primer acuerdo de afiliado (API o formulario de referral)

TIER 3 (meses 6–18)
├── Supabase Storage (documentos del Expediente Digital)
├── Stripe (pasarela de pago para planes de publicación)
├── Idealista/Fotocasa API (publicación multiportal)
├── OpenAI API (Asistente de anuncio con IA)
├── Calendly o solución propia (Sala de Visitas)
├── Signaturit o DocuSign (firma digital arras)
└── Sistema de notificaciones (Supabase Realtime o pusher)
```

---

*→ Guardado en: `docs/tech/architecture/architecture-scalable.md`*
*✅ F6 completada (arquitectura escalable Tier 1 → Tier 3). Leer junto a `tier1-stack.md` y `ADR-001`.*
