# Tool Brief — `T1` · Calculadora de ahorro frente a la agencia inmobiliaria

> Cuando el agente reciba "construye T1", este es el único brief que necesita leer (junto a CLAUDE.md y memoria).

---

## 1. Identificación

| Campo | Valor |
|---|---|
| ID | T1 |
| Slug / URL | `/herramientas/calculadora-ahorro-agencia` |
| Estado | ⬜ Pendiente |
| Tier | 1 |
| Persona objetivo | A — vendedor evaluando si vender sin agencia |
| Complejidad | Baja (1–2 días) |
| Dependencias | T-111 (scaffolding) |

---

## 2. SEO

| Elemento | Valor literal |
|---|---|
| H1 | `Calculadora de ahorro frente a la agencia inmobiliaria` |
| Title tag | `Calculadora Comisión Agencia Inmobiliaria 2026 — ¿Cuánto ahorras vendiendo solo?` |
| Meta description | `Introduce el precio de tu piso y descubre cuánto te cobra una agencia inmobiliaria vs. cuánto te ahorras vendiendo tú mismo. Gratis y sin registro.` |
| Keyword primaria | `calculadora comisión agencia inmobiliaria` (~200–500 búsq/mes) |
| Keywords secundarias | `cuánto cobra una inmobiliaria`, `comisión agencia vender piso 2026`, `ahorro vender piso sin agencia` |
| Intención | Transaccional |
| OG image | `/og/ahorro-agencia.png` |
| Canonical | `https://[dominio]/herramientas/calculadora-ahorro-agencia` |
| Schema.org | `HowTo` + `FAQPage` |

---

## 3. Inputs

| # | Campo (ts) | Label | Tipo | Validación | Placeholder | Tooltip |
|---|---|---|---|---|---|---|
| 1 | `precioVenta` | Precio de venta del piso | number (€) | `z.number().min(10000).max(10000000)` | `200.000` | El precio al que esperas vender tu vivienda |
| 2 | `porcentajeComision` | % de comisión de la agencia | number | `z.number().min(1).max(15)` | `4` | Las agencias en España suelen cobrar entre 3% y 6%. Por defecto: 4%. |
| 3 | `incluyeIVA` | El % indicado, ¿incluye IVA? | select (sí/no) | `z.enum(['si','no'])` | — | Las agencias suelen indicar la comisión sin IVA. Marca "no" si tienes dudas. |

**Defaults:** `porcentajeComision = 4`, `incluyeIVA = 'no'`.

---

## 4. Lógica de cálculo

### Función pura

Ubicación: `src/features/agency-savings/lib/calculate-agency-savings.ts`

```typescript
export type CommissionSavingsInput = {
  salePrice: number;
  commissionPercentage: number;
  includesVat: 'si' | 'no';
};

export type CommissionSavingsResult = {
  commissionBeforeVat: number;      // sin IVA
  vat: number;                       // 21% sobre la bruta
  totalCommission: number;           // bruta + IVA (es lo que pagarías)
  effectivePercentageOfSale: number; // % efectivo incluyendo IVA
};

export function calculateAgencySavings(input: CommissionSavingsInput): CommissionSavingsResult;
```

### Fórmulas

```
commissionBeforeVat = salePrice × (commissionPercentage / 100)
vat                 = includesVat === 'si' ? 0 : commissionBeforeVat × 0.21
totalCommission     = commissionBeforeVat + vat
effectivePercentageOfSale = (totalCommission / salePrice) × 100
```

### Constantes

| Constante | Valor | Fuente |
|---|---|---|
| Tipo IVA servicios | 21% | Art. 90 LIVA (Ley 37/1992) |

---

## 5. Outputs

### Cifra principal

`Ahorrarás vendiendo tu piso por tu cuenta:` **`[comisionTotal] €`**

### Desglose secundario

| Componente | Valor |
|---|---|
| Comisión de la agencia (sin IVA) | `[comisionBruta] €` |
| IVA (21%) | `[iva] €` |
| Total que pagarías a la agencia | `[comisionTotal] €` |
| Equivale a un | `[porcentajeRealSobreVenta]%` real sobre el precio de venta |

### Mensaje contextual

- Si `comisionTotal > 10.000`: "Es el coste real de delegar la venta a una agencia. ¿Lo gestionas tú con nuestras herramientas gratuitas?"
- Si `porcentajeComision > 6`: warning amarillo "Has indicado un porcentaje superior a la media del sector (3–6%). Verifica el porcentaje exacto en el contrato de la agencia."

---

## 6. Edge cases

| Caso | Comportamiento |
|---|---|
| Precio < 10.000 € | Validación bloquea, mensaje "El precio parece demasiado bajo. Revisa el dato." |
| Comisión > 10% | Permitir cálculo pero mostrar warning |
| Comisión < 1% | Validación bloquea ("Verifica el porcentaje. Las agencias en España rara vez cobran menos del 3%.") |
| Sin marcar IVA | Default `'no'` (asumir IVA no incluido — caso más común y conservador) |

---

## 7. Disclaimer legal

> *"Esta calculadora ofrece una estimación basada en el porcentaje de comisión que tú indiques. Las agencias en España aplican comisiones del 3% al 6% del precio de venta, más IVA del 21%. Verifica los términos exactos en el contrato de intermediación. Esta herramienta no constituye asesoramiento jurídico ni fiscal."*

---

## 8. Email capture post-resultado

| Elemento | Valor |
|---|---|
| Título | `¿Quieres vender sin agencia? Te enviamos la guía paso a paso.` |
| CTA botón | `Recibir la guía gratuita` |
| Valor entregado | PDF "10 pasos para vender tu piso sin agencia" + secuencia de bienvenida |
| Source en BD | `T1` |
| Email de bienvenida | Asunto: "Tu guía para vender sin agencia (y un dato importante)" — cuerpo: enlace al PDF + invitación a usar T2 (plusvalía) |

---

## 9. Cross-link a otra tool

> ¿Sabes cuánto te quedará realmente al vender? → `/herramientas/simulador-neto-venta-piso`

Razón: T6 es el complemento natural de T1 — el usuario que calculó el ahorro quiere saber el neto final.

---

## 10. Artículo companion

| Elemento | Valor |
|---|---|
| Slug | `/blog/cuanto-cobra-una-agencia-inmobiliaria` |
| Título | `Cuánto cobra una agencia inmobiliaria en España (2026)` |
| Keyword objetivo | `cuánto cobra una agencia inmobiliaria` |
| `tool:` (frontmatter) | `calculadora-ahorro-agencia` |
| Estado | ⬜ Pendiente — entre los 4 artículos de lanzamiento (D-006) |

---

## 11. FAQ schema

| # | Pregunta | Respuesta breve |
|---|---|---|
| 1 | ¿Cuánto cobra una agencia inmobiliaria en España? | Entre el 3% y el 6% del precio de venta, más IVA del 21%. La media nacional ronda el 4%. |
| 2 | ¿La comisión de la agencia incluye IVA? | Casi nunca. La mayoría de agencias indican la comisión sin IVA y lo añaden al facturar. |
| 3 | ¿Es legal vender un piso sin agencia? | Totalmente. En España no es obligatorio contratar agencia para vender una vivienda. |
| 4 | ¿Quién paga la comisión, comprador o vendedor? | En España la paga normalmente el vendedor, aunque puede pactarse repartirla. |
| 5 | ¿Se puede negociar el porcentaje de comisión? | Sí. Las agencias suelen aceptar negociación, especialmente en zonas con alta competencia o pisos de precio elevado. |
| 6 | ¿Qué incluye la comisión de la agencia? | Publicación en portales, gestión de visitas, fotografías y, en algunos casos, asesoramiento legal básico. |

---

## 12. Definition of done

- [ ] Feature module `src/features/agency-savings/` con estructura completa (components/, lib/, schemas/, content/, types.ts, index.ts)
- [ ] `calculate-agency-savings.ts` con tests unitarios (cobertura 100%) en `calculate-agency-savings.test.ts`
- [ ] `src/app/(marketing)/herramientas/calculadora-ahorro-agencia/page.tsx` thin (importa del feature)
- [ ] Schema Zod en `src/features/agency-savings/schemas/agency-savings-schema.ts`
- [ ] `src/features/agency-savings/content/seo.ts` con metadata + HowTo schema
- [ ] `src/features/agency-savings/content/faq.ts` con las preguntas
- [ ] Disclaimer visible bajo el resultado
- [ ] Email capture con `source: 'T1'`
- [ ] Cross-link a T6
- [ ] FAQ + JSON-LD `FAQPage`
- [ ] JSON-LD `HowTo`
- [ ] OG image en `public/og/agency-savings.png`
- [ ] LCP < 2,5s en mobile (Lighthouse)
- [ ] Entrada en sitemap
- [ ] Disclaimer cruzado contra `compliance-tier1.md`
- [ ] Artículo companion publicado
- [ ] Test e2e: rellenar form → ver resultado → submit email captura

---

*→ Guardado en: `docs/product/tools/T1-calculadora-ahorro-agencia.md`*
