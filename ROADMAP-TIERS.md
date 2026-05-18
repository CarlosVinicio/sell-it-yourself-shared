# Roadmap por Tiers — SINAGENCIAS.ES

> Documento maestro de alcance. Define qué se construye en cada Tier, cuándo se pasa al siguiente y qué documentación aplica en cada fase.
> **Estrategia activa: Tier 1.** Los Tiers 2 y 3 son referencia futura — no construir anticipadamente.

---

## Visión general

```
TIER 1                    TIER 2                    TIER 3
Herramientas gratuitas    Herramientas avanzadas    Portal completo
(ahora)                   (mes 2–6)                 (mes 6–18)
     │                         │                         │
     ▼                         ▼                         ▼
Tráfico orgánico          Leads cualificados        Operaciones reales
Lista de emails           Auth + datos usuario      Monetización activa
Validación de demanda     Primer ingreso opcional   Marketplace
```

---

## Tier 1 · Herramientas gratuitas

**Estado:** 🟢 Activo — construir ahora  
**Coste infraestructura:** ~0 €/mes (Vercel + Supabase free tier)  
**Duración estimada:** semanas 1–8

### Objetivo
Generar tráfico SEO orgánico y construir una lista de emails antes de tener producto. Validar qué keywords funcionan y qué herramientas usan los vendedores reales.

### Qué se construye

| ID | Herramienta | URL | Keyword primaria | Complejidad |
|---|---|---|---|---|
| T1 | Calculadora ahorro vs. agencia | `/herramientas/calculadora-ahorro-agencia` | comisión agencia inmobiliaria | 1–2 días |
| T2 | Calculadora plusvalía municipal | `/herramientas/calculadora-plusvalia-municipal` | calculadora plusvalía municipal | 3–5 días |
| T3 | Calculadora IRPF venta de piso | `/herramientas/calculadora-irpf-venta-piso` | irpf venta piso calculadora | 2–3 días |
| T4 | Checklist documentación por CCAA | `/herramientas/checklist-documentacion-venta-piso` | documentos para vender un piso | 4–6 días |
| T5 | Calculadora gastos de notaría | `/herramientas/calculadora-gastos-notaria-compraventa` | gastos notario compraventa piso | 2–3 días |
| T6 | Simulador neto real de la venta | `/herramientas/simulador-neto-venta-piso` | cuánto me quedo al vender mi piso | 2–3 días |

**También incluye:**
- Landing page principal con propuesta de valor y email capture
- Página `/herramientas` — catálogo de todas las herramientas
- Blog: 10 artículos companion (uno por herramienta + pillar pages)
- SEO técnico: sitemap, structured data (HowTo + FAQ schema), Core Web Vitals
- Configuración de analytics: Google Search Console + Vercel Analytics

### Qué NO se construye en Tier 1
- Auth / login
- Base de datos de inmuebles
- Ningún tipo de anuncio o listing
- Pasarela de pago
- Integraciones externas (Catastro, AVM, firma digital)
- Funcionalidades del portal completo

### Condiciones para pasar a Tier 2
Cumplir **al menos 3** de estos 6 criterios:

| Criterio | Umbral | Dónde medirlo |
|---|---|---|
| Sesiones orgánicas/mes | > 5.000 | Google Search Console |
| Emails capturados (total) | > 1.000 | Supabase `subscribers` |
| Herramientas con > 500 sesiones/mes | ≥ 3 herramientas | Vercel Analytics |
| Tasa de captura de email | > 8% | Emails / sesiones |
| NPS herramientas | > 50 | Encuesta Tally/Typeform |
| Usuarios pidiendo publicar su anuncio | Cualquiera | Email replies |

### Documentación de referencia

| Área | Documento |
|---|---|
| Estrategia | `docs/business/model/cost-free-structure.md` |
| Stack técnico | `docs/tech/architecture/tier1-stack.md` |
| Framework (ADR) | `docs/tech/adr/ADR-001-framework-nextjs-app-router.md` |
| SEO y keywords | `docs/marketing/gtm/estrategia-gtm-tier1.md` |
| Métricas y KPIs | `docs/data/kpis/kpis-tier1.md` |
| Legal y compliance | `docs/legal/compliance/compliance-tier1.md` |

---

## Tier 2 · Herramientas avanzadas

**Estado:** ⬜ Pendiente — no construir hasta cumplir condiciones del Tier 1  
**Coste infraestructura:** ~50–200 €/mes (AVM API, Supabase Pro si aplica)  
**Duración estimada:** meses 2–6 (paralelo al crecimiento del Tier 1)

### Objetivo
Añadir herramientas que requieren API externas o backend mínimo. Introducir el primer ingreso opcional (informe PDF de pago). Implementar auth básico para que el usuario pueda guardar su progreso.

### Qué se construye

| ID | Herramienta | Dependencia técnica | Ingreso posible |
|---|---|---|---|
| T7 | Valorador de mercado gratuito | AVM API (Idealista Data / Tinsa / Atlas) ~0,50 €/consulta | Informe PDF premium: 4,99–9,99 € |
| T8 | Generador de contrato de arras | PDF generation (React PDF) | Revisión por abogado afiliado: 49–99 € |
| T9 | Buscador de notarías por código postal | API Consejo del Notariado (parcial) | Afiliado: referral a notaría |
| T10 | Guías de trámites por CCAA | Contenido estático + diseño | — |

**También incluye:**
- Auth básico (Supabase Auth) para guardar resultados y progreso del checklist
- Email capture mejorado: secuencia de onboarding personalizada por herramienta usada
- Primer acuerdo con profesional afiliado (abogado o gestor para revisión de arras)

### Condiciones para pasar a Tier 3
- Tier 1 con métricas validadas (3 de 6 criterios cumplidos)
- Al menos 1 herramienta de Tier 2 activa con usuarios reales
- Decisión tomada sobre modelo de monetización del portal (Q-002 revisada con datos)
- Capital disponible para afrontar el OPEX del Tier 3 (~25.000 €/año mínimo)

### Documentación de referencia

| Área | Documento |
|---|---|
| Modelo de ingresos | `docs/business/model/income-model.md` |
| Estructura de costes | `docs/business/model/cost-structure.md` |
| Pregunta abierta AVM | `docs/memory/decisions.md` Q-003 |

---

## Tier 3 · Portal completo (MVP)

**Estado:** ⬜ Pendiente — no construir hasta validar Tier 1–2  
**Coste infraestructura:** ~135–355 €/mes  
**Duración estimada:** meses 6–18

### Objetivo
Construir el portal completo que permite al vendedor particular gestionar la venta de su inmueble de forma autónoma: publicar su anuncio, gestionar visitas, negociar y cerrar. Monetización activa.

### Qué se construye

**Bloque A — Captación y publicación**
- A1 · Flujo de publicación guiado (step-by-step)
- A2 · Asistente de descripción con IA
- A3 · Subida y guía de fotografía
- A4 · Autocompletado con datos del Catastro
- A5 · Vista previa del anuncio
- A6 · Publicación multiportal (Idealista, Fotocasa) — vía API

**Bloque B — Valoración y precio**
- B1 · Valorador de mercado (evolución del T7 del Tier 2)
- B2 · Comparador de precio en tiempo real
- B3 · Calculadora fiscal integrada (evolución de T2 + T3 del Tier 1)
- B4 · Alertas de precio de mercado

**Bloque C — Visitas y demanda**
- C1 · Sala de visitas (calendario + confirmaciones + recordatorios)
- C2 · Mensajería estructurada comprador–vendedor
- C3 · Filtro de compradores cualificados
- C4 · Pipeline de interesados (kanban)

**Bloque D — Documentación y legal**
- D1 · Checklist de documentación dinámico (evolución del T4 del Tier 1)
- D2 · Expediente Digital (repositorio seguro de documentos)
- D3 · Generador de contrato de arras (evolución del T8 del Tier 2)
- D4 · Checklist pre-notaría

**Bloque E — Negociación y cierre**
- E1 · Herramienta de oferta estructurada
- E2 · Comparador de oferta vs. mercado

**Bloque F — Analítica**
- F1 · Panel de rendimiento del anuncio
- F2 · Optimizador de visibilidad (destacado de pago)

**Bloque G — Comunidad**
- G1 · Centro de conocimiento SEO (evolución del blog del Tier 1)
- G2 · Suite de calculadoras (evolución del Tier 1 completo)

### Modelo de monetización activo en Tier 3

| Plan | Precio | Contenido |
|---|---|---|
| Esencial | Gratuito | Publicación básica + herramientas Tier 1 |
| Profesional | 199 € (único) | Destacado + herramientas completas + panel avanzado |
| Completo | 490 € (único) | Todo Profesional + publicación en Idealista/Fotocasa |
| Éxito | 0 € + 990 € al cierre | Solo se paga si se vende |
| Servicios adyacentes | Variable | Hipotecas, seguros, profesionales afiliados |

### Fases conceptuales a ejecutar antes de construir el Tier 3

| Fase | Contenido | Documento de destino |
|---|---|---|
| F5 · UX y flujos | Flujos de usuario, wireframes, sistema de diseño | `docs/ux/flows/` |
| F6 · Arquitectura técnica | Stack completo portal, integraciones externas, ADRs | `docs/tech/architecture/` |
| F7 · Legal completa | T&C vendedor/comprador, custodia documental, arras | `docs/legal/` |
| F8 · GTM portal | Lanzamiento, canales de pago, PR, alianzas | `docs/marketing/gtm/` |
| F9 · KPIs portal | Métricas de marketplace: LTV, CAC, DOM, tasa de cierre | `docs/data/kpis/` |
| F10 · Roadmap MVP | Priorización features, sprints, hitos de lanzamiento | `docs/product/roadmap/` |

### Documentación de referencia (ya disponible)

| Área | Documento |
|---|---|
| Oportunidad de mercado | `docs/business/model/tam-sam-som.md` |
| Modelo de ingresos | `docs/business/model/income-model.md` |
| Estructura de costes | `docs/business/model/cost-structure.md` |
| Análisis de riesgos | `docs/business/model/risk-analysis.md` |
| Veredicto de viabilidad | `docs/business/model/viability-verdict.md` |
| Inventario de funcionalidades | `docs/product/features/inventario-funcionalidades.md` |
| Análisis de competencia | `docs/data/market-research/analisis-competencia.md` |
| Glosario fundacional | `docs/business/glosario.md` |

---

## Documentación transversal (aplica a todos los Tiers)

| Documento | Contenido | Aplica en |
|---|---|---|
| `docs/business/glosario.md` | Terminología del proyecto | Siempre |
| `docs/data/market-research/analisis-competencia.md` | Ecosistema competitivo | Siempre |
| `docs/business/model/tam-sam-som.md` | Tamaño de mercado | Decisiones de inversión |
| `docs/skills/agents/financial-advisor.md` | Perfil del agente financiero | Cuando se evalúa viabilidad |
| `.claude/CLAUDE.md` | Instrucciones del agente IA | Siempre |
| `memory/` | Estado del proyecto entre sesiones | Siempre |

---

*→ Guardado en: `docs/ROADMAP-TIERS.md`*
*Actualizar cuando se cumplan las condiciones de paso entre Tiers.*
