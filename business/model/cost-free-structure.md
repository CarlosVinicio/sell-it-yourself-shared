# Estrategia Tools-First — Coste cero, escala progresiva

> Alternativa al MVP completo. Análisis de la estrategia de entrada gratuita mediante herramientas independientes.
> → Compara con `cost-structure.md` (MVP tradicional) para tomar la decisión de enfoque.

---

## La hipótesis central

En lugar de construir el portal completo antes de lanzar, **construir primero las herramientas individuales como páginas independientes**, cada una optimizada para una keyword de alto valor. Cada herramienta funciona sola, sin necesidad de marketplace, sin cold start y sin coste de infraestructura significativo.

El usuario llega buscando "calculadora plusvalía municipal" en Google, encuentra la herramienta, la usa, y en ese momento se le presenta el resto del ecosistema. El tráfico llega antes que el producto.

---

## Por qué esta estrategia encaja con el proyecto

| Factor | MVP tradicional | Tools-first |
|---|---|---|
| **Cold start (compradores)** | Problema crítico desde el día 1 | No existe — las herramientas funcionan sin compradores |
| **Capital inicial** | ~9.000–22.000 € | ~15–200 €/año |
| **Compatibilidad con trabajo actual** | Difícil — requiere dedicación full-time | Alta — cada herramienta es un sprint de 3-10 días |
| **Validación de demanda** | Se asume antes de tener datos | Se mide con tráfico real antes de construir el marketplace |
| **Riesgo de fracaso** | Medio-alto | Muy bajo |
| **Tiempo hasta primeros usuarios reales** | 4–7 meses | 1–2 semanas |
| **SEO** | Empieza tarde | Es el producto desde el día 1 |
| **Monetización** | Desde el lanzamiento del MVP | Diferida 6–18 meses, pero con audiencia ya construida |

🟢 **Esta estrategia es especialmente adecuada cuando el proyecto es personal, paralelo a otro trabajo, y el objetivo es validar la demanda antes de comprometer tiempo y capital a un MVP completo.**

---

## Taxonomía de herramientas por tipo de construcción

### Tipo A — Pure front-end (no necesitan backend ni auth)
Calculadoras y checklists estáticos. Se construyen en días. Cero coste de infraestructura.

### Tipo B — Front-end + almacenamiento ligero (Supabase free tier)
Herramientas que guardan resultados o permiten exportar. Requieren email capture pero no auth completo.

### Tipo C — Necesitan auth y lógica de negocio
Herramientas con estado persistente del usuario. Primer paso hacia el producto completo.

---

## Catálogo de herramientas ordenado por impacto SEO × complejidad

### Tier 1 — Construir primero (semanas 1–8)
Pure front-end, sin API, sin auth. Coste de construcción: días.

| # | Herramienta | Keyword objetivo | Vol. estimado | Complejidad | Impacto |
|---|---|---|---|---|---|
| **T1** | **Calculadora ahorro vs. agencia** | "comisión agencia inmobiliaria calculadora" | ~500–1.000/mes | 1–2 días | 🔴 Máximo — personaliza el ahorro real del usuario |
| **T2** | **Calculadora plusvalía municipal** | "calculadora plusvalía municipal" | ~3.000–6.000/mes | 3–5 días | 🔴 Alta — keyword muy buscada, fórmula compleja que la gente no entiende |
| **T3** | **Calculadora IRPF venta de piso** | "irpf venta piso calculadora" | ~2.000–4.000/mes | 2–3 días | 🔴 Alta — alta ansiedad fiscal, cálculo no trivial |
| **T4** | **Checklist documentación por CCAA** | "documentos para vender piso" | ~2.000–4.000/mes | 4–6 días | 🔴 Alta — principal pain point del vendedor, dinámico por CCAA |
| **T5** | **Calculadora gastos de notaría** | "gastos notario compraventa piso" | ~1.000–2.000/mes | 2–3 días | 🟡 Media — útil pero menos urgente |
| **T6** | **Simulador neto real de la venta** | "cuanto me quedo de la venta de mi piso" | ~500–1.500/mes | 2–3 días | 🔴 Alta — combina T2+T3 en una sola herramienta. El más emocional de todos |

**Total Tier 1:** 6 herramientas, ~14–22 días de desarrollo, **0 € de coste infraestructura**.

---

### Tier 2 — Segunda oleada (meses 2–4)
Requieren una API externa o backend mínimo. Coste marginal bajo.

| # | Herramienta | Keyword objetivo | Vol. estimado | Complejidad | Dependencia |
|---|---|---|---|---|---|
| **T7** | **Valorador de mercado gratuito** | "valorar piso online gratis" | ~5.000–10.000/mes | 2–4 semanas | AVM API (Idealista Data, Tinsa o similar) ~0,50 €/consulta |
| **T8** | **Generador de contrato de arras** | "contrato arras modelo gratis" | ~3.000–5.000/mes | 1–2 semanas | PDF generation (React PDF o similar). Sin backend complejo. |
| **T9** | **Buscador de notarías + calculadora de cita** | "notaria compraventa piso" | ~1.000/mes | 1 semana | API pública Consejo del Notariado (parcial) |
| **T10** | **Guía de trámites por CCAA** | "vender piso sin agencia [ciudad]" | Variable | 1–2 semanas | Contenido estático + diseño. Sin backend. |

**Total Tier 2:** 4 herramientas, ~5–9 semanas de desarrollo, **~50–200 €/mes de coste** (principalmente API AVM del valorador).

---

### Tier 3 — Puente hacia el producto (meses 4–9)
Requieren auth. Es el paso de "herramientas" a "producto". El usuario empieza a tener un perfil.

| # | Herramienta | Keyword objetivo | Complejidad | Monetización |
|---|---|---|---|---|
| **T11** | **Checklist documentación con estado guardado** | — | 1 semana | Requiere cuenta gratuita → email capturado |
| **T12** | **Publicación de anuncio básico (free)** | "publicar piso sin agencia" | 3–5 semanas | Free tier → base para modelo freemium |
| **T13** | **Panel de vendedor lite** | — | 2–3 semanas | Dashboard mínimo: visitas, contactos, estado |
| **T14** | **Sala de visitas básica** | — | 2–3 semanas | Feature que convierte gratuito → pago |

**Tier 3 es el MVP.** Se construye cuando el Tier 1+2 ya tiene tráfico validado.

---

## Secuencia de construcción recomendada

```
SEMANA 1
────────
Dominio + Vercel + Next.js App Router configurado
Primera herramienta: T1 Calculadora ahorro vs. agencia
Landing page principal con CTA a waitlist/newsletter

SEMANA 2–3
──────────
T2 Calculadora plusvalía municipal (ambos métodos: real + objetivo)
T3 Calculadora IRPF venta de piso
Email capture integrado: "Guarda tu cálculo" → Resend / ConvertKit

SEMANA 4–5
──────────
T4 Checklist documentación por CCAA (datos estáticos, UI interactiva)
T5 Calculadora gastos de notaría
Página /herramientas con catálogo de todas las calculadoras

SEMANA 6–8
──────────
T6 Simulador neto real de la venta (combo T2+T3)
Blog: primeros 10 artículos SEO que enlazan a las herramientas
SEO técnico: meta tags, sitemap, structured data, Core Web Vitals

MES 2–3
───────
T7 Valorador de mercado (la más trabajosa, la de mayor tráfico)
T8 Generador de contrato de arras (PDF)
Newsletter mensual con contenido del blog → nutrir lista de emails

MES 4–6
───────
T9 + T10 (guías y notarías)
Analizar qué herramientas tienen más tráfico → priorizar features MVP
Decisión de cuándo arrancar Tier 3 basada en datos reales

MES 6–9
───────
Tier 3: auth + anuncio básico + panel lite + sala de visitas
Primer plan de pago opcional (destacado, multiportal)
```

---

## Estructura de costes reales (tools-first)

### Fase 0 — Solo herramientas Tier 1 (meses 1–2)

| Partida | Coste | Notas |
|---|---|---|
| Dominio `.es` | ~15 €/año | Una sola vez al año |
| Vercel (free tier) | 0 € | Hasta 100 GB/mes de bandwidth. Suficiente para meses iniciales. |
| Supabase (free tier) | 0 € | Para email capture y waitlist. 500 MB de base de datos. |
| Resend (free tier) | 0 € | 100 emails/día, suficiente para newsletter inicial. |
| Herramientas de desarrollo | 0 € | Next.js, Tailwind, React — todo open source. |
| OEPM (marca) | 0 € en esta fase | Diferir hasta que haya tráfico validado. |
| **TOTAL MES 1–2** | **~1,25 €/mes** | Solo el prorrateo del dominio. |

### Fase 1 — Tier 1 + Tier 2 con valorador (meses 3–6)

| Partida | Coste/mes | Notas |
|---|---|---|
| Vercel (free tier → Pro cuando aplique) | 0–20 € | Pro necesario cuando superes 100 GB/mes o necesites analytics avanzados. |
| Supabase (free tier) | 0 € | El free tier aguanta bien hasta ~10.000 usuarios activos. |
| AVM API (valorador de mercado) | 20–100 € | Depende del volumen. Idealista Data: tarifa empresa (negociar). Alternativa: Tinsa API, Atlas Real Estate Analytics. |
| Resend Pro | 0–20 € | Free hasta 100 emails/día. Pro si la newsletter crece. |
| SEO tools (Ahrefs Lite / Semrush) | 0–99 € | Opcional. Se puede empezar con Google Search Console (gratuito). |
| **TOTAL MES 3–6** | **~20–240 €/mes** | Variable por el AVM. Si el valorador no tiene API cara, se mantiene bajo. |

### Fase 2 — Tier 3 / producto (meses 6–18)

| Partida | Coste/mes | Notas |
|---|---|---|
| Vercel Pro | 20 € | |
| Supabase Pro | 25 € | Cuando superes el free tier. |
| AVM API + Catastro | 50–200 € | Escala con volumen de valoraciones. |
| Email marketing (ConvertKit / Brevo) | 30–80 € | Para listas >5.000 contactos. |
| Stripe (comisiones) | 1,4% + 0,25 € por transacción | Solo cuando haya pagos. |
| Infra adicional (CDN, backups) | 10–30 € | |
| **TOTAL MES 6–18** | **~135–355 €/mes** | |

### Comparativa total de inversión

| Horizonte | MVP tradicional | Tools-first |
|---|---|---|
| Mes 1–2 | ~5.000–10.000 € | **~2–3 €** |
| Mes 1–6 | ~15.000–25.000 € | **~500–1.500 €** |
| Mes 1–12 | ~25.000–40.000 € | **~2.000–5.000 €** |
| Mes 1–24 | ~50.000–80.000 € | **~5.000–15.000 €** |

🟢 La diferencia de coste en los primeros 12 meses es de 20–35x. El coste total del approach tools-first durante 2 años equivale al presupuesto de legal y compliance del MVP tradicional.

---

## Modelo de monetización progresiva

El catálogo de herramientas gratuitas no es el negocio final — es el embudo hacia el negocio real. La monetización se introduce de forma natural conforme crece el tráfico y la confianza de marca.

### Escalón 1 — Captura de leads (meses 1–3)
Sin monetización. El único objetivo es construir la lista de email.

- Herramienta gratuita → "Guarda tu cálculo" → email capturado
- Newsletter semanal con contenido sobre vender sin agencia
- **KPI:** 500 emails capturados al mes 3

### Escalón 2 — Primer producto de pago opcional (meses 4–8)

| Producto | Precio | Mecanismo |
|---|---|---|
| Informe PDF del valorador | 4,99–9,99 € | Valoración gratuita en pantalla, informe descargable de pago |
| Checklist documentación con alertas (guardado persistente) | Gratis con cuenta | Requiere registro → email capturado |
| Generador de arras con revisión de abogado | 49–99 € | La plantilla es gratis, la revisión por abogado afiliado tiene precio |

**KPI:** 1-3% de conversión de visitas → compra en herramientas de pago. Con 10.000 visitas/mes y 2% conversión → ~200 ventas × 7 € = 1.400 €/mes.

### Escalón 3 — Anuncio gratuito + planes (meses 8–18)
Cuando el tráfico es suficiente, se lanza el listing gratuito como imán para que los vendedores publiquen:

| Plan | Precio | Qué incluye |
|---|---|---|
| Gratuito | 0 € | Anuncio básico en el portal, herramientas lite |
| Profesional | 199 € (único) | Anuncio destacado + todas las herramientas + panel completo |
| Completo | 490 € (único) | Todo Profesional + publicación en Idealista/Fotocasa |
| Éxito | 0 € + 990 € al cierre | Solo si se vende |

**KPI:** 50 anuncios activos al mes 12.

### Escalón 4 — Servicios adyacentes (año 2+)
Referral de hipotecas (800–2.000 €/referral), seguros, profesionales afiliados.
El modelo del Módulo 2 ([income-model.md](income-model.md)) se aplica íntegramente en esta fase.

---

## Validación de demanda integrada en la estrategia

La mayor ventaja del approach tools-first es que cada herramienta es un experimento de validación:

| Señal | Qué valida |
|---|---|
| Tráfico orgánico a la calculadora fiscal | El keyword funciona. Los vendedores tienen el problema. |
| Tasa de captura de email en "guarda tu cálculo" | El vendedor está lo suficientemente motivado como para dar su email. |
| Tasa de conversión email → registro en el portal | El paso de herramienta a producto es viable. |
| Tráfico orgánico al valorador vs. calculadoras | Qué tipo de usuario domina: vendedor informacional vs. vendedor activo. |
| NPS de la herramienta (encuesta post-uso) | Calidad de la experiencia antes de tener producto completo. |

🟢 **Con estas señales, cuando llegue el momento de construir el MVP, no habrá suposiciones — habrá datos reales de 6–12 meses de usuarios reales.**

---

## Stack técnico recomendado para tools-first

Todo open source, todo en free tier hasta escala.

```
FRAMEWORK
  Next.js 14+ (App Router)
  → SEO out of the box: SSR, metadata API, sitemap automático
  → Cada herramienta es una ruta /herramientas/[slug]
  → Blog como /blog/[slug] con MDX o CMS headless (Contentlayer)

STYLING
  Tailwind CSS v4 (CSS-first) + shadcn/ui v2 (Radix UI + CVA)
  → Componentes accesibles con keyboard nav y aria sin esfuerzo extra
  → Sistema de diseño coherente desde el día 1, escalable a Tier 2–3

BACKEND (cuando sea necesario)
  Supabase (PostgreSQL + Auth + Storage + Realtime)
  → Free tier aguanta bien el Tier 1 y parte del Tier 2
  → No necesitas servidor propio hasta escala real

EMAIL / LEADS
  Resend (transaccional) + Brevo / ConvertKit (newsletter)
  → Resend free: 100 emails/día
  → Brevo free: 300 emails/día, hasta 1.000 contactos

HOSTING
  Vercel
  → Free tier: deploy automático desde git, HTTPS, CDN global
  → Pro (20 €/mes) solo cuando el tráfico lo exija

FORMULARIOS
  React Hook Form + Zod
  → Sin dependencias externas. Validación en cliente.

ANALYTICS
  Google Search Console (gratis) + PostHog (free tier)
  → Search Console es imprescindible para ver qué keywords posicionan
  → PostHog para comportamiento de usuario dentro de las herramientas

PAGOS (cuando aplique)
  Stripe
  → Integración sencilla con Next.js
  → Solo pagar cuando hay transacciones (1,4% + 0,25 €)
```

---

## Riesgos específicos de esta estrategia

### R1 — El tráfico llega pero no convierte a usuarios del portal
**Descripción:** La calculadora de plusvalía recibe 5.000 visitas/mes pero nadie se registra para publicar su anuncio.

**Probabilidad:** Media. Ocurre si las herramientas están desconectadas del flujo de conversión.

**Mitigación:** Cada herramienta debe tener un CTA contextual claro hacia el siguiente paso del proceso de venta. "Has calculado tu plusvalía → ¿quieres saber qué documentos necesitas para vender?" La herramienta no termina en el resultado — termina en la siguiente acción.

---

### R2 — Un competidor capitalizado lanza herramientas similares
**Descripción:** Fotocasa o una fintech bien financiada lanza un conjunto de calculadoras mejor diseñadas.

**Probabilidad:** Baja en el corto plazo. Los portales grandes no tienen incentivo para facilitar la venta sin agencia.

**Mitigación:** La velocidad de ejecución es la ventaja. En 8 semanas se pueden tener 6 herramientas posicionadas. Una empresa grande tardaría meses en aprobar, diseñar y lanzar algo equivalente.

---

### R3 — El SEO tarda más de lo esperado
**Descripción:** Las herramientas no posicionan en los primeros 6 meses y el tráfico orgánico es mínimo.

**Probabilidad:** Media. El SEO para sites nuevos puede tardar 3–9 meses en arrancar.

**Mitigación:**
- Publicar las herramientas con al menos un artículo de blog asociado que contextualice la herramienta y ataque la keyword informacional.
- Construir backlinks desde el primer mes: comunidades de Reddit, foros inmobiliarios, Facebook groups de vendedores. No hace falta escala — 5-10 backlinks de calidad en los primeros meses acelera significativamente.
- Compartir en comunidades relevantes: "construí una calculadora de plusvalía municipal, es gratis" tiene buena tracción orgánica en redes.

---

### R4 — Dificultad para monetizar la audiencia de herramientas
**Descripción:** Los usuarios de calculadoras tienen una intención de búsqueda informacional, no transaccional. Pueden nunca convertir a usuarios del portal.

**Probabilidad:** Media.

**Mitigación:** Este riesgo es real. La calculadora de plusvalía atrae a personas en fase muy temprana del proceso (o incluso a personas que ya vendieron y están calculando su declaración de la renta). El diseño de cada herramienta debe detectar en qué fase está el usuario y ofrecer el CTA adecuado. El valorador de mercado (T7) tiene la mayor intención transaccional — esa herramienta es la más importante para capturar usuarios activos.

---

## Cuándo pasar de tools-first a producto completo

El momento de arrancar el Tier 3 (MVP del portal) no debe ser arbitrario — debe estar gatekeado por métricas reales:

| KPI | Umbral para avanzar a Tier 3 | Señal |
|---|---|---|
| Visitas orgánicas/mes | >5.000 | El SEO está funcionando |
| Emails capturados | >1.000 | Hay audiencia real |
| Tasa de captura email | >8% sobre visitas | La propuesta de valor conecta |
| Herramientas con >500 visitas/mes c/u | ≥3 herramientas | Múltiples keywords posicionando |
| NPS herramientas (encuesta) | >50 | Los usuarios están satisfechos |
| Usuarios que preguntan "¿puedo publicar mi piso aquí?" | Cualquiera | Señal de demanda del producto completo |

🟢 **Cuando se alcancen 3 de estos 6 umbrales, es el momento de construir el Tier 3.** No antes.

---

## Comparativa estratégica: tools-first vs. MVP tradicional

| Dimensión | MVP tradicional | Tools-first |
|---|---|---|
| **Capital inicial** | ~9.000–22.000 € | ~15–200 € |
| **Tiempo hasta primer usuario real** | 4–7 meses | 1–2 semanas |
| **Compatibilidad con otro trabajo** | Baja | Alta |
| **Riesgo de "construir lo incorrecto"** | Alto — se descubre tarde | Bajo — el tráfico valida cada herramienta |
| **Problema del cold start** | Crítico desde el día 1 | No existe en Tier 1–2 |
| **Velocidad de posicionamiento SEO** | Tardío (el blog empieza con el MVP) | Inmediato (las herramientas son el SEO) |
| **Monetización** | Desde el lanzamiento | Diferida 6–18 meses |
| **Riesgo de fracaso total** | Medio | Muy bajo |
| **Potencial de escala** | Alto | Idéntico — la escalabilidad llega igual |
| **Adecuado para proyecto personal** | Solo si hay dedicación full-time | ✅ Perfecto para proyecto paralelo |

---

## Veredicto

🟢 **La estrategia tools-first es la más adecuada para el contexto actual del proyecto.**

No porque el MVP sea incorrecto — el MVP del portal es el destino final correcto. Sino porque el camino más eficiente hacia ese MVP pasa por construir primero la audiencia, validar las keywords, capturar los primeros emails y aprender qué herramientas generan más conversión.

Cuando el MVP se construya, no estará construyendo para el vacío — estará construyendo para 1.000+ personas que ya conocen la marca, han usado las herramientas y están esperando poder publicar su anuncio.

**El orden natural:**

```
Herramientas gratuitas → Audiencia SEO → Lista de emails
→ Validación de demanda → MVP del portal → Monetización
```

No al revés.

---

*→ Guardado en: `docs/business/model/cost-free-structure.md`*
*✅ Alternativa estratégica documentada. Comparar con `cost-structure.md` para tomar decisión de enfoque.*
