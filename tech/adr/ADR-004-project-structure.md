# ADR-004 · Estructura del proyecto: organización feature-first

| Campo | Valor |
|---|---|
| **Fecha** | 2026-04-26 |
| **Estado** | ✅ Aceptada |
| **Área** | Tech |
| **Afecta a** | `sinagencias-web` (Next.js) — Tier 1, Tier 2, Tier 3 |
| **Supersede** | Estructura propuesta en `tier1-stack.md` v1 (layer-first) |

---

## Contexto

La estructura inicial propuesta en `tier1-stack.md` seguía un patrón **layer-first** (carpetas raíz por tipo de archivo: `components/`, `lib/`, `hooks/`). Funciona para 6 calculadoras pero **se rompe en Tier 3** cuando aparezcan listings, visits, messages, documents y dashboard — el código de un feature queda esparcido por todo el repo.

Adicionalmente, la propuesta usaba nombres de archivo en castellano (`ahorro-agencia.ts`, `plusvalia.ts`), lo que viola D-008 (código 100% en inglés).

---

## Opciones evaluadas

### Organización del código

| Opción | Pros | Contras |
|---|---|---|
| **Layer-first** (`components/`, `lib/`, `hooks/`) | Familiar, simple para proyectos pequeños | No escala — el código de un feature se esparce; difícil de borrar features completas |
| **Feature-first** (`features/[name]/`) ✅ | Cada feature es autocontenida, borrable, con public API explícita; escala a Tier 3 sin reorganizar | Más boilerplate inicial, requiere disciplina con los imports |

### URLs en castellano vs. carpetas en inglés

| Opción | Pros | Contras |
|---|---|---|
| **A. Carpetas de ruta en castellano** ✅ | Simple, sin config extra, estándar de la industria en proyectos para mercado hispano | Las carpetas dentro de `app/(marketing)/` reflejan URLs en castellano (excepción consciente) |
| **B. Carpetas de ruta en inglés + rewrites** | 100% inglés en el repo | Mayor complejidad, riesgo de duplicate content, configuración frágil |

---

## Decisión

**Organización feature-first. Opción A para URLs.**

- Todo el código (`features/`, `components/`, `lib/`, `hooks/`, `config/`) está en inglés.
- Las carpetas dentro de `app/(marketing)/` reflejan URLs en castellano por SEO — única excepción consciente y documentada.

---

## Estructura completa

```
sinagencias-web/
│
├── src/
│   ├── app/                                    # ROUTING — URLs en castellano (SEO)
│   │   ├── layout.tsx                          # Root layout
│   │   ├── globals.css
│   │   ├── sitemap.ts
│   │   ├── robots.ts
│   │   ├── manifest.ts
│   │   │
│   │   ├── (marketing)/                        # Tier 1: público, sin auth
│   │   │   ├── layout.tsx                      # Header + Footer público
│   │   │   ├── page.tsx                        # Landing /
│   │   │   ├── herramientas/
│   │   │   │   ├── page.tsx                    # /herramientas
│   │   │   │   ├── calculadora-ahorro-agencia/page.tsx
│   │   │   │   ├── calculadora-plusvalia-municipal/page.tsx
│   │   │   │   ├── calculadora-irpf-venta-piso/page.tsx
│   │   │   │   ├── calculadora-gastos-notaria-compraventa/page.tsx
│   │   │   │   ├── checklist-documentacion-venta-piso/page.tsx
│   │   │   │   └── simulador-neto-venta-piso/page.tsx
│   │   │   ├── blog/
│   │   │   │   ├── page.tsx
│   │   │   │   └── [slug]/page.tsx
│   │   │   ├── privacidad/page.tsx
│   │   │   ├── aviso-legal/page.tsx
│   │   │   └── cookies/page.tsx
│   │   │
│   │   └── (app)/                              # Tier 2–3: área autenticada (vacío en Tier 1)
│   │       └── .gitkeep
│   │
│   ├── features/                               # CORE — un módulo autocontenido por feature
│   │   ├── agency-savings/                     # T1 — Calculadora ahorro vs. agencia
│   │   │   ├── components/
│   │   │   │   ├── AgencySavingsForm.tsx
│   │   │   │   └── AgencySavingsResult.tsx
│   │   │   ├── lib/
│   │   │   │   ├── calculate-agency-savings.ts
│   │   │   │   └── calculate-agency-savings.test.ts
│   │   │   ├── schemas/
│   │   │   │   └── agency-savings-schema.ts
│   │   │   ├── content/
│   │   │   │   ├── faq.ts
│   │   │   │   └── seo.ts
│   │   │   ├── types.ts
│   │   │   └── index.ts                        # Public API del módulo
│   │   │
│   │   ├── property-value-tax/                 # T2 — Calculadora plusvalía municipal
│   │   ├── capital-gains-tax/                  # T3 — Calculadora IRPF venta piso
│   │   ├── document-checklist/                 # T4 — Checklist por CCAA
│   │   ├── notary-fees/                        # T5 — Gastos de notaría
│   │   ├── net-sale-proceeds/                  # T6 — Simulador neto (compone T1+T2+T3+T5)
│   │   │
│   │   ├── email-capture/                      # Feature transversal
│   │   │   ├── components/EmailCaptureInline.tsx
│   │   │   ├── lib/track-conversion.ts
│   │   │   ├── schemas/subscriber-schema.ts
│   │   │   └── index.ts
│   │   │
│   │   └── blog/                               # MDX engine
│   │       ├── components/
│   │       │   ├── MdxRenderer.tsx
│   │       │   └── BlogPostCard.tsx
│   │       ├── lib/
│   │       │   ├── get-posts.ts
│   │       │   └── get-post-by-slug.ts
│   │       ├── types.ts
│   │       └── index.ts
│   │
│   ├── components/                             # Componentes COMPARTIDOS (no de feature)
│   │   ├── ui/                                 # shadcn/ui v2 — generado por `npx shadcn@latest add`
│   │   ├── layout/
│   │   │   ├── Header.tsx
│   │   │   ├── Footer.tsx
│   │   │   ├── ToolsMegaMenu.tsx
│   │   │   └── MobileDrawer.tsx
│   │   ├── tool/                               # Primitivas que usan TODAS las tools
│   │   │   ├── ToolLayout.tsx
│   │   │   ├── ToolHero.tsx
│   │   │   ├── ResultCard.tsx
│   │   │   ├── InputCurrency.tsx
│   │   │   ├── InputPercent.tsx
│   │   │   ├── ToolFaq.tsx
│   │   │   ├── ToolCrossLink.tsx
│   │   │   └── ToolDisclaimer.tsx
│   │   └── seo/
│   │       ├── JsonLd.tsx
│   │       ├── HowToSchema.tsx
│   │       ├── FaqSchema.tsx
│   │       └── BreadcrumbSchema.tsx
│   │
│   ├── lib/                                    # Infraestructura compartida
│   │   ├── api/                                # Cliente HTTP del backend NestJS
│   │   │   ├── client.ts                       # fetch wrapper tipado
│   │   │   ├── errors.ts                       # ApiError, NetworkError
│   │   │   ├── subscribers.ts                  # subscribe()
│   │   │   └── types.ts                        # ApiResponse<T>
│   │   ├── seo/
│   │   │   ├── generate-metadata.ts
│   │   │   └── canonical.ts
│   │   ├── analytics/
│   │   │   └── track-event.ts                  # Vercel Analytics wrapper
│   │   ├── format/
│   │   │   ├── currency.ts                     # formatCurrency(8240) → "8.240 €"
│   │   │   ├── percent.ts
│   │   │   └── date.ts
│   │   ├── validation/
│   │   │   └── refinements.ts                  # Helpers Zod compartidos
│   │   └── utils/
│   │       ├── cn.ts                           # tailwind-merge
│   │       └── compose.ts
│   │
│   ├── hooks/                                  # Hooks COMPARTIDOS (no de feature)
│   │   ├── use-local-storage.ts
│   │   ├── use-debounce.ts
│   │   └── use-media-query.ts
│   │
│   ├── content/                                # MDX del blog
│   │   └── blog/
│   │       ├── como-calcular-plusvalia-municipal.mdx
│   │       ├── irpf-venta-piso-guia-completa.mdx
│   │       └── ...
│   │
│   ├── config/                                 # Configuración estática
│   │   ├── site.ts                             # Nombre, URL, metadata global
│   │   ├── tools.ts                            # Registro de las 6 tools (slug, persona, brief)
│   │   ├── navigation.ts                       # Estructura de header/footer
│   │   └── env.ts                              # Validación Zod de process.env
│   │
│   ├── styles/
│   │
│   └── types/                                  # Tipos GLOBALES (no de feature)
│       └── global.d.ts
│
├── public/
│   ├── og/                                     # Open Graph images por tool
│   ├── icons/
│   └── favicon.ico
│
├── tests/
│   └── e2e/                                    # Playwright (opcional Tier 1)
│
├── .env.example
├── .env.local                                  # gitignored
├── components.json                             # shadcn/ui config
├── next.config.ts
├── next-sitemap.config.js
├── tailwind.config.ts
├── tsconfig.json
└── package.json
```

---

## Mapeo herramienta → feature

| Brief | Slug URL (castellano) | Feature module (inglés) |
|---|---|---|
| T1 | `/herramientas/calculadora-ahorro-agencia` | `features/agency-savings/` |
| T2 | `/herramientas/calculadora-plusvalia-municipal` | `features/property-value-tax/` |
| T3 | `/herramientas/calculadora-irpf-venta-piso` | `features/capital-gains-tax/` |
| T4 | `/herramientas/checklist-documentacion-venta-piso` | `features/document-checklist/` |
| T5 | `/herramientas/calculadora-gastos-notaria-compraventa` | `features/notary-fees/` |
| T6 | `/herramientas/simulador-neto-venta-piso` | `features/net-sale-proceeds/` |

---

## Estructura interna de un feature module

Todos los features siguen este patrón:

```
features/[name]/
├── components/                  # UI específica del feature
│   ├── [Name]Form.tsx           # Formulario de inputs
│   └── [Name]Result.tsx         # Visualización del resultado
├── lib/                         # Lógica de negocio pura
│   ├── calculate-[name].ts      # Función pura de cálculo
│   └── calculate-[name].test.ts # Tests unitarios (cobertura 100%)
├── schemas/                     # Validación Zod
│   └── [name]-schema.ts
├── content/                     # Contenido estático del feature
│   ├── faq.ts                   # FAQs del brief (para FAQ schema)
│   └── seo.ts                   # Title, description, JSON-LD HowTo
├── types.ts                     # Input, Result, intermedios
└── index.ts                     # Public API — único punto de import
```

### Public API por feature (`index.ts`)

Cada feature exporta SOLO lo que el resto del repo necesita:

```typescript
// features/property-value-tax/index.ts
export { PropertyValueTaxForm } from './components/PropertyValueTaxForm';
export { PropertyValueTaxResult } from './components/PropertyValueTaxResult';
export { calculatePropertyValueTax } from './lib/calculate-property-value-tax';
export { propertyValueTaxSchema } from './schemas/property-value-tax-schema';
export { propertyValueTaxSeo } from './content/seo';
export type { PropertyValueTaxInput, PropertyValueTaxResult } from './types';
```

**Imports válidos desde fuera del feature:**
```typescript
import { calculatePropertyValueTax } from '@/features/property-value-tax';
```

**Imports prohibidos:**
```typescript
// ❌ Acceso directo a internos del módulo
import { calculatePropertyValueTax } from '@/features/property-value-tax/lib/calculate-property-value-tax';
```

---

## Reglas de imports entre módulos

```
features/X  ─── puede importar de ───▶  components/, lib/, hooks/, config/
features/X  ─── NUNCA importa de ────▶  features/Y
```

**Excepción documentada:** `features/net-sale-proceeds` (T6) compone `agency-savings`, `property-value-tax`, `capital-gains-tax` y `notary-fees` por diseño del brief T6. Esta dependencia se importa vía la public API (`index.ts`) de cada uno y se documenta explícitamente en `features/net-sale-proceeds/lib/calculate-net-sale-proceeds.ts`.

**Si dos features comparten algo nuevo:** ese algo se promueve a `components/`, `lib/` o `hooks/`. Nunca se importa directamente entre features.

---

## Path aliases (`tsconfig.json`)

```json
{
  "compilerOptions": {
    "paths": {
      "@/*":            ["./src/*"],
      "@/app/*":        ["./src/app/*"],
      "@/features/*":   ["./src/features/*"],
      "@/components/*": ["./src/components/*"],
      "@/lib/*":        ["./src/lib/*"],
      "@/hooks/*":      ["./src/hooks/*"],
      "@/config/*":     ["./src/config/*"],
      "@/content/*":    ["./src/content/*"],
      "@/types/*":      ["./src/types/*"]
    }
  }
}
```

Regla obligatoria: dentro de un feature, los imports relativos están permitidos (`./components/X`). Fuera de un feature, **siempre** alias absoluto (`@/features/X`).

---

## Patrón de página (`app/.../page.tsx`)

Las páginas son **finas**: importan del feature, configuran metadata, componen.

```typescript
// app/(marketing)/herramientas/calculadora-plusvalia-municipal/page.tsx
import {
  PropertyValueTaxForm,
  PropertyValueTaxResult,
  propertyValueTaxSeo,
} from '@/features/property-value-tax';
import { ToolLayout } from '@/components/tool/ToolLayout';
import { EmailCaptureInline } from '@/features/email-capture';
import { ToolCrossLink } from '@/components/tool/ToolCrossLink';

export const generateMetadata = () => propertyValueTaxSeo.metadata;

export default function PropertyValueTaxPage() {
  return (
    <ToolLayout>
      <PropertyValueTaxForm />
      <PropertyValueTaxResult />
      <EmailCaptureInline source="T2" />
      <ToolCrossLink href="/herramientas/calculadora-irpf-venta-piso" />
    </ToolLayout>
  );
}
```

---

## Crecimiento por Tier (sin reorganizar)

### Tier 2 añade nuevos features (no reorganiza)
```
features/
├── ...                     ← Tier 1 features (sin tocar)
├── market-valuation/       ← T7 — Valorador AVM (proxy a backend)
├── deposit-contract/       ← T8 — Generador de arras
└── saved-results/          ← Resultados guardados con auth
```

### Tier 3 añade nuevos features (sin reorganizar)
```
features/
├── ...                     ← Tier 1–2 features (sin tocar)
├── listings/               ← Publicación de inmuebles
├── visits/                 ← Sala de visitas
├── messages/               ← Mensajería
├── documents/              ← Expediente digital
├── dashboard/              ← Panel del vendedor
└── ai-assistant/           ← Asistente IA del anuncio
```

Las rutas en `app/(app)/` se añaden y consumen estos features.

---

## Consecuencias

**Positivas:**
- Cada feature es autocontenido, borrable y testeable de forma aislada.
- La estructura no se reorganiza al pasar de Tier 1 a Tier 3 — solo crece.
- La public API explícita (`index.ts`) previene acoplamiento accidental.
- Path aliases coherentes hacen los imports legibles desde cualquier punto.
- Las páginas en `app/` son finas: composición, no lógica.

**A gestionar:**
- Hay que disciplinar a no importar entre features. Un linter rule (`eslint-plugin-boundaries`) puede automatizarlo en Tier 2.
- El boilerplate inicial por feature es mayor que en layer-first (≈ 6 archivos vacíos al crear un feature). Una plantilla / generador puede mitigarlo.

**No aplica:**
- Atomic Design (`atoms/`, `molecules/`, `organisms/`) — sobreingeniería para 6 tools.
- Domain-Driven Design completo — innecesario para Tier 1, evaluable en Tier 3.

---

*→ Guardado en: `docs/tech/adr/ADR-004-project-structure.md`*
