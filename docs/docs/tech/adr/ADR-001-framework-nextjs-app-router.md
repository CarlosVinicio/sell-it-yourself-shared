# ADR-001 · Framework: Next.js con App Router

| Campo | Valor |
|---|---|
| **Fecha** | 2026-04-25 |
| **Estado** | ✅ Aceptada |
| **Área** | Tech |
| **Afecta a** | Tier 1, Tier 2, Tier 3 |

---

## Contexto

El Tier 1 es un conjunto de herramientas gratuitas orientadas a SEO orgánico. El criterio más importante de la decisión de framework es el rendimiento SEO (SSR/SSG, metadata nativa, Core Web Vitals) seguido de la velocidad de desarrollo para un solo desarrollador con experiencia en React.

## Opciones consideradas

| Opción | SSR/SSG | SEO | Velocidad dev | Coste infra | Extensible a Tier 3 |
|---|---|---|---|---|---|
| **Next.js App Router** | ✅ Nativo | ✅ Excelente | ✅ Alta | ✅ Vercel free | ✅ Sí |
| Astro | ✅ Nativo | ✅ Excelente | 🟡 Media (nuevo paradigma) | ✅ Free | 🟡 Parcial — no tiene API routes ni auth nativo |
| Remix | ✅ Nativo | ✅ Muy buena | 🟡 Media | 🟡 Requiere servidor | ✅ Sí |
| Vite + React SPA | ❌ No (CSR) | ❌ Mala | ✅ Alta | ✅ Free | ❌ No escala a SSR |

## Decisión

**Next.js 15 con App Router.**

## Razones

1. **El desarrollador ya conoce React** — curva de aprendizaje cero en el paradigma de componentes. App Router añade Server Components y `generateMetadata`, que se aprenden en horas.
2. **Vercel free tier** — el autor de Next.js es Vercel. El deploy es automático desde git, con HTTPS, CDN global y previews por branch sin configuración.
3. **Metadata API nativa** — `generateMetadata` por ruta genera title, description, og:tags, canonical y structured data sin plugins externos.
4. **API Routes** — cuando Tier 2 necesite endpoints (email capture, PDF generation, AVM proxy), están disponibles sin añadir un servidor separado.
5. **Auth en Tier 3** — next-auth o Supabase Auth tienen integración directa con Next.js App Router. No habrá que reescribir.
6. **MDX nativo** — el blog como archivos `.mdx` en el repositorio funciona out-of-the-box.

## Consecuencias

- **Positivas:** SEO excelente desde el primer día, deploy instantáneo, extensible sin reescritura.
- **A gestionar:** App Router tiene conceptos nuevos (Server Components, `use client`, `use server`) que requieren disciplina para no introducir hidratación innecesaria. Regla: todo es Server Component por defecto; solo marcar `'use client'` en componentes que necesiten estado de UI o eventos del navegador (las calculadoras sí lo necesitan — son interactivas).
- **No aplica:** Astro habría sido más ligero para contenido estático puro, pero el Tier 2–3 necesita interactividad y auth — cambiar de Astro a Next.js sería una reescritura. Esta decisión evita esa deuda.
