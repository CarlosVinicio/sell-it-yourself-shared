# Arquitectura técnica — Tier 1 (`sinagencias-web`)

> Stack y estructura del repo del frontend para las 6 herramientas del Tier 1.
> Backend (NestJS) en repo separado — ver `ADR-003-backend-architecture.md`.
> Estructura de carpetas — ver `ADR-004-project-structure.md` (autoridad sobre este documento).

---

## Principios de diseño

1. **Coste cero hasta escala real** — free tier en todo. No pagar nada hasta que el tráfico lo exija.
2. **SEO primero** — cada herramienta es una landing SSG con metadata completa. El SEO no es un añadido, es la arquitectura.
3. **Feature-first sin sobreingeniería** — cada herramienta es un módulo autocontenido, borrable y testeable de forma aislada.
4. **Código en inglés, contenido en castellano** — D-008. Las URLs son la única excepción consciente (carpetas dentro de `app/(marketing)/` reflejan URLs en castellano por SEO).
5. **Extensible** — la estructura se mantiene de Tier 1 a Tier 3 sin reorganización.

---

## Stack

| Capa | Tecnología | Tier | Por qué |
|---|---|---|---|
| Framework | **Next.js 15 (App Router)** | 1–3 | SSR/SSG nativo, Metadata API, file-based routing, Server Components |
| Lenguaje | **TypeScript strict** | 1–3 | `strict: true`, `noUncheckedIndexedAccess: true` |
| Estilos | **Tailwind CSS v4** | 1–3 | Sin setup de diseño externo |
| Componentes | **shadcn/ui v2** (Radix UI + CVA) | 1–3 | Accesibilidad Radix (keyboard nav, aria), Tailwind v4 compatible, copy-paste sin runtime |
| Formularios | **React Hook Form + Zod** | 1–3 | Validación tipada en cliente |
| Contenido (blog) | **MDX + gray-matter** | 1–3 | Archivos `.mdx` en el repo, sin CMS externo |
| HTTP client | **Native `fetch` con wrapper tipado** | 1–3 | Sin axios. Wrapper en `lib/api/client.ts` |
| Email capture | **Backend NestJS → Supabase + Resend** | 1–2 | El frontend solo llama `POST {API_URL}/subscribers` |
| Analytics | **Vercel Analytics + Google Search Console** | 1–3 | Free tier. GSC esencial para keywords reales |
| Hosting | **Vercel (hobby)** | 1–2 | HTTPS, CDN global, deploy desde git |
| SEO técnico | **next-sitemap** | 1–3 | sitemap.xml + robots.txt automáticos |
| Tests | **Vitest** | 1–3 | Unit tests de funciones puras, cobertura 100% en `lib/calculations/` |

**Coste total Tier 1: ~0 €/mes** (dominio aparte, ~1,25 €/mes prorrateado).

---

## Estructura de carpetas (autoridad: ADR-004)

```
sinagencias-web/
├── src/
│   ├── app/                  # Routing — URLs en castellano (SEO)
│   ├── features/             # Módulos autocontenidos por herramienta
│   ├── components/           # Componentes compartidos (ui, layout, tool, seo)
│   ├── lib/                  # Infra compartida (api, format, seo, analytics)
│   ├── hooks/                # Hooks compartidos
│   ├── content/              # MDX del blog
│   ├── config/               # Config estática (site, tools, env)
│   ├── styles/
│   └── types/
├── public/
└── tests/
```

**Detalle completo y reglas de imports en `ADR-004-project-structure.md`.**

---

## Mapeo herramienta → feature module → ruta pública

| Brief | Feature module (inglés, código) | URL pública (castellano, SEO) |
|---|---|---|
| T1 | `features/agency-savings/` | `/herramientas/calculadora-ahorro-agencia` |
| T2 | `features/property-value-tax/` | `/herramientas/calculadora-plusvalia-municipal` |
| T3 | `features/capital-gains-tax/` | `/herramientas/calculadora-irpf-venta-piso` |
| T4 | `features/document-checklist/` | `/herramientas/checklist-documentacion-venta-piso` |
| T5 | `features/notary-fees/` | `/herramientas/calculadora-gastos-notaria-compraventa` |
| T6 | `features/net-sale-proceeds/` | `/herramientas/simulador-neto-venta-piso` |

---

## Patrón de cada herramienta

Cada herramienta sigue el mismo patrón. Sin excepciones.

### 1. Función pura de cálculo (`features/[name]/lib/calculate-[name].ts`)

Sin React, sin side effects, sin `console.log`, sin acceso a DOM/red. Recibe un objeto tipado, devuelve un objeto tipado.

```typescript
// features/property-value-tax/lib/calculate-property-value-tax.ts
import type { PropertyValueTaxInput, PropertyValueTaxResult } from '../types';

export function calculatePropertyValueTax(
  input: PropertyValueTaxInput
): PropertyValueTaxResult {
  // ... cálculo
}
```

### 2. Schema Zod (`features/[name]/schemas/[name]-schema.ts`)

```typescript
import { z } from 'zod';

export const propertyValueTaxSchema = z.object({
  purchasePrice: z.number().min(0).max(20_000_000),
  salePrice: z.number().min(10_000).max(20_000_000),
  // ...
});

export type PropertyValueTaxFormValues = z.infer<typeof propertyValueTaxSchema>;
```

### 3. Componentes UI (`features/[name]/components/`)

Server Component cuando es posible; Client Component (`'use client'`) solo cuando hay estado de formulario o interacción.

```typescript
// features/property-value-tax/components/PropertyValueTaxForm.tsx
'use client';
// ... React Hook Form + Zod
```

### 4. Contenido SEO (`features/[name]/content/seo.ts`)

```typescript
import type { Metadata } from 'next';

export const propertyValueTaxSeo = {
  metadata: {
    title: 'Calculadora Plusvalía Municipal 2026 — Método real y método objetivo',
    description: '...',
    // ...
  } satisfies Metadata,
  howToSchema: { /* JSON-LD HowTo */ },
};
```

### 5. FAQ (`features/[name]/content/faq.ts`)

```typescript
export const propertyValueTaxFaq = [
  {
    question: '¿Qué es la plusvalía municipal?',
    answer: 'Impuesto local (IIVTNU) que grava...',
  },
  // ... mínimo 5 preguntas del brief
];
```

### 6. Public API (`features/[name]/index.ts`)

Único punto de entrada del módulo desde fuera.

```typescript
export { PropertyValueTaxForm } from './components/PropertyValueTaxForm';
export { PropertyValueTaxResult } from './components/PropertyValueTaxResult';
export { calculatePropertyValueTax } from './lib/calculate-property-value-tax';
export { propertyValueTaxSchema } from './schemas/property-value-tax-schema';
export { propertyValueTaxSeo } from './content/seo';
export { propertyValueTaxFaq } from './content/faq';
export type { PropertyValueTaxInput, PropertyValueTaxResult } from './types';
```

### 7. Página (thin) (`app/(marketing)/herramientas/[slug-castellano]/page.tsx`)

```typescript
import {
  PropertyValueTaxForm,
  PropertyValueTaxResult,
  propertyValueTaxSeo,
  propertyValueTaxFaq,
} from '@/features/property-value-tax';
import { ToolLayout } from '@/components/tool/ToolLayout';
import { ToolFaq } from '@/components/tool/ToolFaq';
import { EmailCaptureInline } from '@/features/email-capture';
import { ToolCrossLink } from '@/components/tool/ToolCrossLink';
import { JsonLd } from '@/components/seo/JsonLd';

export const generateMetadata = () => propertyValueTaxSeo.metadata;

export default function PropertyValueTaxPage() {
  return (
    <ToolLayout>
      <JsonLd data={propertyValueTaxSeo.howToSchema} />
      <PropertyValueTaxForm />
      <PropertyValueTaxResult />
      <EmailCaptureInline source="T2" />
      <ToolCrossLink
        href="/herramientas/calculadora-irpf-venta-piso"
        label="¿Y cuánto pagarás de IRPF?"
      />
      <ToolFaq items={propertyValueTaxFaq} />
    </ToolLayout>
  );
}
```

---

## Comunicación con el backend (NestJS)

El frontend NO ejecuta lógica de negocio en el servidor. Las calculadoras son **100% client-side**. El único caso de llamada a backend es el email capture.

```typescript
// lib/api/client.ts
const baseUrl = process.env.NEXT_PUBLIC_API_URL!;

async function post<T>(path: string, body: unknown): Promise<T> {
  const response = await fetch(`${baseUrl}${path}`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify(body),
  });
  if (!response.ok) throw new ApiError(response.status, await response.text());
  return response.json();
}

export const apiClient = { post };

// lib/api/subscribers.ts
import { apiClient } from './client';
import type { SubscriberPayload, SubscriberResponse } from './types';

export function subscribe(payload: SubscriberPayload) {
  return apiClient.post<SubscriberResponse>('/subscribers', payload);
}
```

**Variables de entorno (`.env.local`):**
```
NEXT_PUBLIC_API_URL=http://localhost:3001         # dev
NEXT_PUBLIC_API_URL=https://api.sinagencias.es  # prod
NEXT_PUBLIC_SITE_URL=https://sinagencias.es
```

---

## SEO técnico por herramienta

### `generateMetadata` en cada `page.tsx`

Definida en `features/[name]/content/seo.ts` y exportada en la public API. La página solo la pasa al export `generateMetadata`.

### JSON-LD

Cada herramienta inyecta dos schemas (Server Component):

- **`HowTo`** — para que Google muestre los pasos en resultados ricos.
- **`FAQPage`** — para que el FAQ aparezca como rich snippet.

```typescript
// components/seo/JsonLd.tsx (Server Component)
export function JsonLd({ data }: { data: Record<string, unknown> }) {
  return (
    <script
      type="application/ld+json"
      dangerouslySetInnerHTML={{ __html: JSON.stringify(data) }}
    />
  );
}
```

### `next-sitemap`

Las 6 herramientas tienen prioridad 0.9. El blog 0.7. Páginas legales 0.3.

---

## Blog y relación herramienta → artículo companion

Cada herramienta tiene un artículo companion en `src/content/blog/` (MDX). El artículo enlaza al feature; el feature enlaza al artículo.

| Feature module | URL artículo companion |
|---|---|
| `features/property-value-tax/` | `/blog/como-calcular-plusvalia-municipal` |
| `features/capital-gains-tax/` | `/blog/irpf-venta-piso-guia-completa` |
| `features/document-checklist/` | `/blog/documentos-para-vender-piso-guia-completa` |
| `features/agency-savings/` | `/blog/cuanto-cobra-una-agencia-inmobiliaria` |
| `features/notary-fees/` | `/blog/gastos-notaria-compraventa-vivienda` |
| `features/net-sale-proceeds/` | `/blog/cuanto-dinero-te-quedas-al-vender-tu-piso` |

Frontmatter MDX:
```yaml
---
title: "..."
slug: kebab-case-del-titulo
date: 2026-MM-DD
description: "..."
keyword: keyword primaria
tool: slug-castellano-de-la-herramienta
author: Carlos
readingTime: X min
---
```

---

## Lo que NO se construye en Tier 1

- ❌ Auth / login (Tier 2)
- ❌ Base de datos de inmuebles (Tier 3)
- ❌ Mensajería o sala de visitas (Tier 3)
- ❌ Catastro o AVM (Tier 2)
- ❌ Pasarela de pago (Tier 3)
- ❌ Panel de admin (Tier 3)
- ❌ Internacionalización (Tier 3 si aplica)
- ❌ Tests E2E completos (Vitest unit es suficiente para Tier 1)
- ❌ CI/CD complejo (Vercel auto-deploy desde git)

---

## Bootstrap del proyecto

```bash
# 1. Crear el proyecto
pnpm create next-app@latest sinagencias-web \
  --typescript \
  --tailwind \
  --app \
  --src-dir \
  --import-alias "@/*"

cd sinagencias-web

# 2. Crear estructura feature-first
mkdir -p src/{features,components/{ui,layout,tool,seo},lib/{api,seo,analytics,format,validation,utils},hooks,content/blog,config,types}

# 3. shadcn/ui (usar npx, no pnpm dlx — workaround bug corepack keyid en local)
npx shadcn@latest init
npx shadcn@latest add button input label card badge accordion separator
# Añadir más componentes según necesidad: tooltip, select, dialog, popover…

# 4. Formularios y validación
pnpm add react-hook-form zod @hookform/resolvers

# 5. Blog MDX
pnpm add gray-matter next-mdx-remote

# 6. SEO
pnpm add -D next-sitemap

# 7. Tests
pnpm add -D vitest @vitest/ui @testing-library/react @testing-library/jest-dom jsdom
```

`.env.example` (sin valores reales):
```
NEXT_PUBLIC_API_URL=
NEXT_PUBLIC_SITE_URL=
```

---

## Orden de construcción

```
1. Bootstrap (T-111) — estructura feature-first vacía + Vercel + dominio (día 1)
2. config/site.ts + config/tools.ts + lib/api/client.ts (día 1)
3. components/layout/ (Header + Footer) + components/tool/ (ToolLayout, ResultCard...) (día 2)
4. features/email-capture/ (necesario para todas las tools) (día 2)
5. features/property-value-tax/ → T2 (mayor keyword) (día 3-5)
6. features/capital-gains-tax/ → T3 (día 6-8)
7. features/document-checklist/ → T4 (día 9-12)
8. features/agency-savings/ → T1 (día 13-14)
9. features/notary-fees/ → T5 (día 15-16)
10. features/net-sale-proceeds/ → T6 (compone los anteriores) (día 17-19)
11. features/blog/ + 4 artículos prioritarios (semana 4)
12. SEO técnico: sitemap, JSON-LD, GSC (semana 4)
```

---

*→ Guardado en: `docs/tech/architecture/tier1-stack.md`*
