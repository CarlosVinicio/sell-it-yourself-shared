# ADR-002 · Convenciones de código y nombrado

| Campo | Valor |
|---|---|
| **Fecha** | 2026-04-25 |
| **Estado** | ✅ Aceptada |
| **Área** | Tech |
| **Afecta a** | Tier 1, Tier 2, Tier 3 |

---

## Contexto

Carlos opera en solitario pero el agente de IA escribe la mayor parte del código. Sin convenciones explícitas, cada sesión decidirá nombres y estructura de forma distinta, generando inconsistencia que cuesta refactorizar más adelante.

---

## Decisiones

### 1. Nombrado de archivos

| Tipo | Convención | Ejemplo |
|---|---|---|
| Componentes React (.tsx) | `PascalCase.tsx` (inglés) | `EmailCaptureForm.tsx` |
| Utilidades, lógica, hooks (.ts) | `kebab-case.ts` (inglés) | `calculate-property-value-tax.ts` |
| Páginas Next.js | `page.tsx`, `layout.tsx`, `route.ts` | (impuesto por Next.js) |
| Carpetas dentro de `src/` (excepto `app/(marketing)/`) | `kebab-case` (inglés) | `features/property-value-tax/` |
| Carpetas dentro de `app/(marketing)/herramientas/` | `kebab-case` (castellano por SEO) | `calculadora-plusvalia-municipal/` |
| Tests | `[archivo].test.ts` (al lado del archivo testeado) | `calculate-property-value-tax.test.ts` |
| MDX del blog | `kebab-case.mdx` (castellano — slug del artículo) | `como-calcular-plusvalia-municipal.mdx` |
| Schemas Zod | `kebab-case-schema.ts` en `features/[name]/schemas/` | `property-value-tax-schema.ts` |
| Tipos TypeScript | `PascalCase` dentro del archivo `types.ts` del feature | `type PropertyValueTaxInput = {...}` |
| Public API del feature | `index.ts` | (un solo punto de import por módulo) |

**Regla:** Las únicas carpetas en castellano del repo están dentro de `app/(marketing)/herramientas/`, `app/(marketing)/blog/[slug]/` y las páginas legales (`privacidad/`, `aviso-legal/`, `cookies/`). Su nombre se justifica porque corresponde a una URL pública que necesita posicionar SEO. Resto del repo: 100% inglés (D-008, ADR-004).

### 2. Nombrado de identificadores

| Elemento | Convención | Ejemplo |
|---|---|---|
| Componentes React | `PascalCase` | `function EmailCaptureForm()` |
| Hooks personalizados | `use` + `camelCase` | `useToolResult()` |
| Funciones puras de cálculo | Verbo + `camelCase` | `calculatePropertyValueTax()`, `calculateNetSaleProceeds()` |
| Tipos / Interfaces | `PascalCase`, sin prefijo `I` | `type PropertyValueTaxResult`, `type NetSaleProceedsInput` |
| Constantes globales | `SCREAMING_SNAKE_CASE` | `const CAPITAL_GAINS_TAX_BRACKETS_2026 = [...]` |
| Variables y propiedades | `camelCase` | `const salePrice`, `let taxableBase` |
| Booleanos | Prefijo `is`/`has`/`should` | `isInputValid`, `hasResult`, `isOver65`, `usesAgency` |

### 3. Idioma

| Elemento | Idioma |
|---|---|
| **Identificadores de código** (variables, funciones, tipos) | **Inglés exclusivamente** — `calculatePropertyValueTax`, `salePrice`, `taxableBase`. Los nombres deben ser claros en inglés, incluso para conceptos del dominio inmobiliario. |
| Comentarios y JSDoc | Castellano — explica el "por qué", no el "qué" |
| Mensajes de UI | Castellano de España |
| Mensajes de error técnicos (no UI) | Inglés |
| Commits | Castellano (consistente con histórico actual) |
| Documentación (`docs/`) | Castellano — el usuario lee en español |

### 4. Estructura de imports

Orden estricto con líneas en blanco entre bloques:

```typescript
// 1. Externos
import { useState } from 'react';
import { z } from 'zod';

// 2. Internos absolutos (con alias @/) — SOLO public APIs (index.ts)
import { calculatePropertyValueTax } from '@/features/property-value-tax';
import { Button } from '@/components/ui/button';
import { formatCurrency } from '@/lib/format/currency';

// 3. Relativos (solo dentro del mismo feature module)
import { PropertyValueTaxForm } from './PropertyValueTaxForm';

// 4. Tipos (al final, con `import type`)
import type { PropertyValueTaxResult } from '@/features/property-value-tax';
```

### 5. Path aliases (tsconfig.json)

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

### 5.bis Reglas de imports entre módulos (feature-first)

Ver `ADR-004-project-structure.md` para el contexto completo. Resumen:

| Origen | Puede importar de | NO puede importar de |
|---|---|---|
| `app/.../page.tsx` | `@/features/*`, `@/components/*`, `@/lib/*`, `@/config/*` | Nada prohibido — la página solo compone |
| `features/X/**` | `@/components/*`, `@/lib/*`, `@/hooks/*`, `@/config/*` | `@/features/Y` (otra feature) |
| `components/**` | `@/lib/*`, `@/hooks/*` | `@/features/*`, `@/app/*` |
| `lib/**` | Solo otros archivos de `lib/` | `@/features/*`, `@/components/*`, `@/app/*` |

**Único acceso permitido entre features:** vía la public API (`@/features/X` → resuelve a `index.ts`). **Nunca** acceso directo a archivos internos (`@/features/X/lib/calculate-x` está prohibido).

**Excepción documentada:** `features/net-sale-proceeds` (T6) importa de `agency-savings`, `property-value-tax`, `capital-gains-tax` y `notary-fees` por diseño del brief T6. Dependencia justificada y limitada a las public APIs.

### 6. Server vs. Client Components

- **Por defecto Server Component.** No añadir `'use client'` salvo que sea necesario.
- Solo marcar `'use client'` si el componente usa: `useState`, `useEffect`, event handlers, `localStorage`, APIs del navegador.
- Las calculadoras del Tier 1 son `'use client'` (necesitan estado de formulario y cálculo en cliente).
- El layout, header, footer y FAQ son Server Components.

### 7. Estilos

- **Tailwind CSS v4 exclusivamente.** No CSS modules, no styled-components.
- Variables de color en `app/globals.css` con tokens de shadcn/ui.
- Composiciones largas: extraer a componente, no a clase de utilidad.
- Mobile-first: empezar sin breakpoint, añadir `md:`, `lg:` solo cuando necesario.

### 8. Validación de formularios

- **React Hook Form + Zod siempre.** No validación manual.
- El schema Zod vive en `features/[name]/schemas/[name]-schema.ts`.
- El schema se exporta vía la public API del feature (`index.ts`).
- Mensajes de error en castellano dentro del schema.

### 9. Funciones puras de cálculo

- Viven en `features/[name]/lib/calculate-[name].ts`.
- Sin efectos secundarios, sin `console.log`, sin acceso a DOM/red.
- Todo input se valida antes de entrar a la función (la función asume input válido — la validación es responsabilidad del caller, vía Zod).
- Devuelven un objeto tipado `[Name]Result`, nunca números sueltos.
- Tests al lado del archivo (`calculate-[name].test.ts`) con **cobertura 100%**.

### 10. Tooling

| Herramienta | Versión | Configuración |
|---|---|---|
| ESLint | El que trae `create-next-app` | `eslint-config-next` + reglas estrictas |
| Prettier | Última estable | Default + `singleQuote: true`, `printWidth: 100` |
| TypeScript | strict: true | `noUncheckedIndexedAccess: true` |
| Tests | Vitest | Decisión confirmada para el Tier 1 |

### 11. Commits

- Formato Conventional Commits en castellano: `feat:`, `fix:`, `docs:`, `refactor:`, `test:`, `chore:`.
- Cuerpo opcional explicando el "por qué".
- Trailer `Co-Authored-By: Claude Sonnet 4.6 <noreply@anthropic.com>` cuando el agente edite.
- No `--no-verify`, no `--amend` sin permiso explícito.

### 12. Estructura interna de un componente

```typescript
'use client';

import { ... } from '...';

// 1. Tipos del componente
type Props = { source: string };

// 2. Constantes locales (si aplica)
const DEFAULT_COMMISSION_RATE = 4;

// 3. Componente
export function EmailCaptureForm({ source }: Props) {
  // 3.1 Hooks de estado
  const [email, setEmail] = useState('');

  // 3.2 Hooks derivados (form, query, mutation)
  // ...

  // 3.3 Handlers
  const handleSubmit = (e: FormEvent) => { ... };

  // 3.4 Render
  return ( ... );
}

// 4. Subcomponentes locales (si los hay y no se reutilizan)
function ResultBadge() { ... }
```

---

## Consecuencias

- **Positivas:** consistencia automática entre sesiones del agente, refactor más fácil, menos discusión en cada PR.
- **A gestionar:** ESLint + Prettier deben estar configurados desde el primer commit del scaffolding para que las reglas sean ejecutables y no aspiracionales.
- **No aplica:** convenciones que asumen equipo (CODEOWNERS, RFC process) — Carlos opera solo, esa fricción no aporta nada.

---

*→ Guardado en: `docs/tech/adr/ADR-002-conventions.md`*
