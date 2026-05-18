# F5 · Arquitectura UX — Tier 1 (herramientas gratuitas)

> Fase 5 ejecutada y adaptada al Tier 1.
> El sistema de diseño completo (tokens, componentes de portal, flujos de vendedor/comprador) es Tier 3.
> Lo que aplica ahora: flujos de herramienta, patrones de captura de email, navegación mínima.

---

## Principio rector de la UX en Tier 1

**La herramienta es el producto.** No hay onboarding, no hay dashboard, no hay cuenta de usuario. El usuario llega buscando un resultado concreto (cuánto pago de plusvalía, qué documentos necesito) y debe obtenerlo en menos de 90 segundos. Todo lo demás es ruido.

Tres mandatos de UX que no se negocian en Tier 1:

1. **Sin fricción hasta el resultado** — no pedir email antes de mostrar el resultado.
2. **El email se captura después del valor, no antes** — el usuario ya confía cuando ha visto que la herramienta funciona.
3. **Mobile-first sin excepciones** — >60% del tráfico de búsquedas fiscales en España llega desde móvil (fuente: GSC benchmark sector finanzas personales).

---

## 1. Los tres journeys del usuario en Tier 1

### Journey 1 — Descubrimiento desde Google (flujo principal)

```
Google (keyword: "calculadora plusvalía municipal")
    │
    ▼
Landing de herramienta (/herramientas/calculadora-plusvalia-municipal)
    │
    ├─ Lee el H1 + descripción breve (10 seg)
    │
    ▼
Completa el formulario (30–60 seg)
    │
    ▼
Ve el resultado con desglose (inmediato)
    │
    ├─ [Si satisfecho] → Ve el CTA de email capture
    │       │
    │       ├─ [Deja email] → Email de bienvenida + guía PDF
    │       │
    │       └─ [No deja email] → Puede usar otra herramienta vinculada
    │
    └─ [Si tiene dudas] → Accede al artículo companion (/blog/...)
```

**Decisión de diseño:** el email capture aparece solo cuando el resultado es visible. Nunca como modal bloqueante antes del resultado. Nunca como popup al aterrizar.

---

### Journey 2 — Usuario recurrente (regresa desde newsletter o bookmark)

```
Email de bienvenida / newsletter
    │
    ▼
Llega a /herramientas (catálogo)
    │
    ▼
Elige otra herramienta
    │
    ▼
Completa → Resultado → CTA a herramienta siguiente (cross-sell interno)
```

**Decisión de diseño:** el catálogo `/herramientas` es la segunda página más importante después de las herramientas individuales. Es el hub que convierte una visita en múltiples usos.

---

### Journey 3 — Explorador (llega a la landing principal)

```
Referral (Reddit, foro, Facebook group) → Landing principal (/)
    │
    ▼
Entiende la propuesta de valor
    │
    ▼
Elige herramienta desde la landing → Journey 1
    │
    └─ O: Suscribe al newsletter desde la landing → Email de bienvenida
```

**Decisión de diseño:** la landing principal no intenta capturar todos los journeys. Su único trabajo es enviar al usuario a la herramienta más relevante para su intención.

---

## 2. Plantilla de página por herramienta

Cada una de las 6 herramientas sigue la misma estructura. La consistencia reduce la curva de aprendizaje entre herramientas y facilita el desarrollo.

```
┌─────────────────────────────────────────┐
│  HERO                                   │
│  H1: [Nombre de la herramienta]         │
│  Subtítulo: beneficio en una línea      │
│  Badges: "Gratuita · Sin registro · Actualizada 2026"
└─────────────────────────────────────────┘

┌─────────────────────────────────────────┐
│  FORMULARIO DE INPUTS                   │
│  Campos mínimos para calcular           │
│  Labels descriptivos con tooltips       │
│  Validación inline (no al submit)       │
│  Botón CTA: "Calcular" / "Ver resultado"│
└─────────────────────────────────────────┘

┌─────────────────────────────────────────┐
│  RESULTADO (aparece tras el submit)     │
│  Cifra principal destacada              │
│  Desglose secundario (tabla o lista)    │
│  Nota legal: "resultado orientativo"    │
└─────────────────────────────────────────┘

┌─────────────────────────────────────────┐
│  EMAIL CAPTURE (inline, post-resultado) │
│  Título: beneficio específico de esta herramienta
│  Ej: "Te enviamos el PDF con el desglose completo"
│  Input email + checkbox RGPD + botón    │
│  Sin nombre. Sin teléfono.              │
└─────────────────────────────────────────┘

┌─────────────────────────────────────────┐
│  CROSS-LINK A HERRAMIENTA SIGUIENTE     │
│  "¿Quieres calcular también el IRPF?" → T3
└─────────────────────────────────────────┘

┌─────────────────────────────────────────┐
│  CONTENIDO SEO                          │
│  FAQ (5–8 preguntas con schema FAQ)     │
│  Explicación del método de cálculo      │
│  Enlace al artículo companion           │
└─────────────────────────────────────────┘
```

### Reglas de formulario

| Regla | Motivo |
|---|---|
| Máximo 5 campos por herramienta | Más campos = abandono |
| Todos los campos con placeholder numérico | El usuario no debe pensar en el formato |
| Tooltips en términos técnicos (plusvalía, IRPF, AJD) | Reduce abandono por desconocimiento |
| Validación inline (no al submit) | Feedback inmediato reduce frustración |
| Botón siempre visible en móvil (sticky si el form es largo) | Reduce scroll hasta el CTA |

---

## 3. Estructura de navegación

### Header (todas las páginas)

```
[Logo / Nombre del portal]    [Herramientas ▾]    [Blog]    [CTA Newsletter]
```

- Sin auth, sin login, sin avatar — no existe en Tier 1.
- El menú "Herramientas" despliega las 6 herramientas (mega-menu en desktop, drawer en móvil).
- El CTA Newsletter en el header es secundario — solo aparece si el usuario lleva >30 seg en la página (evitar distracción en la entrada).

### Footer

```
[Logo]  [Herramientas] [Blog] [Nosotros]
        [Privacidad]   [Aviso legal]   [Cookies]
        © 2026 · No somos una agencia inmobiliaria.
```

- Páginas legales obligatorias: `/privacidad`, `/aviso-legal`, `/cookies`.
- Texto de posicionamiento en el footer: refuerza que no somos agencia (diferencial).

### /herramientas — catálogo

Grid de 6 cards. Cada card:
```
[Icono] [Nombre]
[Descripción en 1 línea]
[Keyword que captura] → ayuda al SEO de la propia página de catálogo
[Botón: "Abrir herramienta"]
```

La página `/herramientas` debe tener su propia metadata SEO con keyword: "calculadoras gratuitas para vender piso".

---

## 4. Cinco principios UX del Tier 1

### P1 — El resultado antes que el registro
El usuario no sabe si la herramienta merece su email hasta que ve el resultado. Si se pide el email primero, la tasa de abandono supera el 70%. El email se captura cuando el usuario ya confía.

### P2 — Un número grande, visible, sin ambigüedad
El resultado de cada herramienta debe tener UNA cifra protagonista. Si hay más información, va en un desglose secundario colapsado por defecto. Ejemplo: la cifra es "12.340 €" (plusvalía a pagar), no una tabla con tres columnas.

### P3 — Transparencia del método
Debajo del resultado, siempre un enlace o acordeón: "¿Cómo se calcula esto?". Dos razones: (1) genera confianza, (2) es contenido SEO que Google indexa. No esconder el método: es el diferencial frente a calculadoras de competencia que dan solo el número.

### P4 — Cada herramienta envía a la siguiente
El funnel no termina en el resultado. Cada herramienta tiene un cross-link hacia la herramienta más lógica. Esto aumenta el tiempo en sitio y multiplica las oportunidades de captura de email.

```
T1 (ahorro agencia) → T6 (neto real)
T2 (plusvalía)      → T3 (IRPF)
T3 (IRPF)           → T2 (plusvalía) o T6 (neto real)
T4 (checklist)      → T1 (ahorro agencia)
T5 (notaría)        → T6 (neto real)
T6 (neto real)      → T4 (checklist)
```

### P5 — Disclaimer siempre visible, nunca invasivo
El disclaimer legal ("resultado orientativo, no asesoramiento fiscal") debe aparecer cerca del resultado, en texto pequeño pero no oculto. No como modal. No como banner bloqueante. Es una nota de pie de resultado.

---

## 5. Patrones de email capture por herramienta

La propuesta de valor del email capture es diferente en cada herramienta. Un mensaje genérico ("suscríbete a la newsletter") convierte mal. Un mensaje específico ("te enviamos el PDF con el desglose de tu plusvalía") convierte bien.

| Herramienta | CTA email capture | Valor entregado |
|---|---|---|
| T1 · Ahorro vs. agencia | "Te enviamos la guía para vender sin agencia" | PDF guía 10 pasos |
| T2 · Plusvalía municipal | "Recibe el cálculo en PDF con ambos métodos" | PDF resultado + método |
| T3 · IRPF venta piso | "Te explicamos las exenciones que puedes aplicar" | PDF tramos + exenciones |
| T4 · Checklist documentación | "Te enviamos el checklist completo con plazos y costes" | PDF checklist por CCAA |
| T5 · Gastos notaría | "¿Quieres el desglose completo de gastos de la venta?" | Link a T6 + PDF resumen |
| T6 · Simulador neto | "Este es tu ahorro vendiendo sin agencia: +X.XXX €" | Email personalizado con cifra |

**Regla de copy:** siempre mencionar el beneficio concreto e inmediato. Nunca "suscríbete". Siempre "te enviamos / recibirás / accede a".

---

## 6. Comportamiento móvil (mobile-first)

### Orden de prioridad en viewport móvil (<768px)

1. H1 + subtítulo (sin imagen de hero — consume espacio)
2. Formulario de inputs
3. Botón "Calcular" (sticky bottom en mobile si el form tiene >3 campos)
4. Resultado (scroll-into-view automático al recibir respuesta)
5. Email capture (inline, no popup)
6. FAQ (acordeón colapsado — no bloquea el scroll)

### Lo que NO se hace en móvil

- ❌ Modal de email capture antes del resultado
- ❌ Hero con imagen grande (retrasa LCP)
- ❌ Sidebar de contenido relacionado (no hay espacio)
- ❌ Sticky header alto (roba viewport)
- ❌ Formularios con más de 5 campos visibles a la vez

### Core Web Vitals — objetivos por página de herramienta

| Métrica | Objetivo | Cómo conseguirlo |
|---|---|---|
| LCP | <2,5 seg | Sin imagen de hero, fuentes con `font-display: swap`, Vercel CDN |
| INP | <200 ms | Calculadoras como Client Components, sin bloqueos en el render |
| CLS | <0,1 | Reservar espacio para el bloque de resultado antes de que aparezca |

---

## 7. Las tres pantallas más críticas

### Pantalla 1 — Tool page en móvil (estado: resultado visible)

```
┌──────────────────────────────┐
│ ← Logo           [≡ Menu]   │ ← Header mínimo (48px)
├──────────────────────────────┤
│ Calculadora Plusvalía        │ ← H1 compacto
│ Municipal 2026               │
├──────────────────────────────┤
│ Valor catastral del suelo    │
│ [          150.000 €       ] │
│                               │
│ Años de posesión              │
│ [              12          ] │
│                               │
│ [  ✓ Calcular plusvalía    ] │ ← Botón primario full-width
├──────────────────────────────┤
│ ┌──────────────────────────┐ │ ← Resultado (aparece tras submit)
│ │  Pagarás de plusvalía:   │ │
│ │       8.240 €            │ ← Cifra grande, color primario
│ │  Método más favorable:   │ │
│ │  Objetivo (-340 €)       │ │
│ └──────────────────────────┘ │
├──────────────────────────────┤
│ Recibe el cálculo en PDF     │ ← Email capture post-resultado
│ [     tu@email.com        ]  │
│ ☐ Acepto recibir la guía...  │
│ [ Enviarme el PDF          ] │
└──────────────────────────────┘
```

### Pantalla 2 — /herramientas (catálogo, móvil)

```
┌──────────────────────────────┐
│ Herramientas gratuitas       │ ← H1
│ para vender tu piso          │
├──────────────────────────────┤
│ ┌──────────────────────────┐ │
│ │ 🧮 Calculadora plusvalía │ │ ← Card 1
│ │ Calcula el impuesto...   │ │
│ │ [Abrir herramienta →]    │ │
│ └──────────────────────────┘ │
│ ┌──────────────────────────┐ │
│ │ 📋 Checklist documentos  │ │ ← Card 2
│ │ Lista por CCAA...        │ │
│ └──────────────────────────┘ │
│ ... (6 cards en total)       │
└──────────────────────────────┘
```

### Pantalla 3 — Landing principal / (above the fold, móvil)

```
┌──────────────────────────────┐
│ ← Logo           [≡ Menu]   │
├──────────────────────────────┤
│                               │
│  Las herramientas que antes  │ ← H1 (propuesta de valor)
│  solo tenían las agencias,   │
│  ahora son tuyas. Gratis.    │
│                               │
│  [  Ver todas las herramientas  ]  │ ← CTA primario
│                               │
├──────────────────────────────┤
│  Las más usadas:             │ ← Links directos a T2, T3, T4
│  · Calculadora plusvalía     │
│  · Calculadora IRPF          │
│  · Checklist documentación   │
└──────────────────────────────┘
```

---

## 8. Lo que espera al Tier 2–3 (no diseñar ahora)

- **Sistema de diseño completo** (tokens de color, tipografía, componentes de portal) → Tier 3 F5
- **Flujo de publicación de anuncio** (step-by-step wizard) → Tier 3 Bloque A
- **Sala de visitas** (calendario + confirmaciones) → Tier 3 Bloque C
- **Dashboard del vendedor** (panel de rendimiento) → Tier 3 Bloque F
- **Flujo de auth** (login/registro, onboarding) → Tier 2
- **Mensajería comprador-vendedor** → Tier 3 Bloque C
- **Estados de loading con skeleton** (para herramientas con API externa) → Tier 2

---

*→ Guardado en: `docs/ux/flows/ux-tier1.md`*
*✅ F5 completada (versión Tier 1). Input directo para el desarrollo de cada herramienta.*
