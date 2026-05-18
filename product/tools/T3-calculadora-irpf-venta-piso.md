# Tool Brief — `T3` · Calculadora IRPF por venta de piso

> Cuando el agente reciba "construye T3", este es el único brief que necesita leer.
> 🔴 Verificar tramos de IRPF de ahorro vigentes para 2026 antes del deploy.

---

## 1. Identificación

| Campo | Valor |
|---|---|
| ID | T3 |
| Slug / URL | `/herramientas/calculadora-irpf-venta-piso` |
| Estado | ⬜ Pendiente |
| Tier | 1 |
| Persona objetivo | B (vendedor activo) |
| Complejidad | Media (2–3 días) |
| Dependencias | T-111 |

---

## 2. SEO

| Elemento | Valor literal |
|---|---|
| H1 | `Calculadora IRPF por venta de piso` |
| Title tag | `Calculadora IRPF Venta de Piso 2026 — Ganancia patrimonial estimada` |
| Meta description | `Calcula el IRPF que pagarás al vender tu piso: introduce el precio de compra, el de venta y los gastos. Incluye exención por reinversión en vivienda habitual.` |
| Keyword primaria | `irpf venta piso calculadora` (~2.000–4.000 búsq/mes) |
| Keywords secundarias | `impuesto venta piso calculadora`, `ganancia patrimonial venta piso`, `cuánto pago a hacienda vender piso` |
| Intención | Alta urgencia — el usuario está cerca de la venta |
| OG image | `/og/irpf-venta-piso.png` |
| Schema.org | `HowTo` + `FAQPage` |

---

## 3. Inputs

| # | Campo | Label | Tipo | Validación | Tooltip |
|---|---|---|---|---|---|
| 1 | `precioCompra` | Precio de compra del piso | number (€) | `z.number().min(0).max(20000000)` | El que figura en la escritura. Si lo heredaste, usa el valor declarado en la sucesión. |
| 2 | `gastosCompra` | Gastos de la compra | number (€) | `z.number().min(0).max(500000)` | Notaría, registro, ITP/IVA, gestoría. Suman al valor de adquisición y reducen la ganancia. |
| 3 | `mejoras` | Mejoras realizadas durante la tenencia | number (€) | `z.number().min(0).max(2000000)` | Solo mejoras (ampliaciones, reformas estructurales). Las reparaciones y mantenimiento NO suman. |
| 4 | `precioVenta` | Precio de venta | number (€) | `z.number().min(10000).max(20000000)` | El precio acordado con el comprador. |
| 5 | `gastosVenta` | Gastos de la venta | number (€) | `z.number().min(0).max(500000)` | Comisión de agencia, plusvalía municipal, gastos de cancelación de hipoteca, certificado energético. Reducen la ganancia. |
| 6 | `esViviendaHabitual` | ¿Era tu vivienda habitual? | boolean | `z.boolean()` | Si vivías en ella al menos durante los últimos 3 años, marca sí. |
| 7 | `reinvierteEnViviendaHabitual` | ¿Reinviertes en otra vivienda habitual? | boolean | `z.boolean()` | Solo aplicable si la vendida era tu vivienda habitual. Reinversión total = exención total. |
| 8 | `importeReinvertido` | Importe que reinviertes (€) | number | `z.number().min(0)` | Solo si marcas reinversión parcial. Por defecto: igual al precio de venta. |
| 9 | `mayor65` | ¿Tienes 65 años o más y era tu vivienda habitual? | boolean | `z.boolean()` | Exención total (Art. 33.4.b LIRPF). |

**Defaults:** booleans = `false`, numéricos = `0`.

---

## 4. Lógica de cálculo

### Función pura

Ubicación: `src/features/capital-gains-tax/lib/calculate-capital-gains-tax.ts`

```typescript
export type CapitalGainsTaxInput = {
  purchasePrice: number;
  purchaseCosts: number;
  improvements: number;
  salePrice: number;
  saleCosts: number;
  isHabitualResidence: boolean;
  reinvestsInHabitualResidence: boolean;
  reinvestmentAmount: number;
  isOver65: boolean;
};

export type CapitalGainsTaxResult = {
  acquisitionValue: number;
  transmissionValue: number;
  grossGain: number;
  exemptionOver65: boolean;
  reinvestmentExemption: number; // proporción exenta (0 a 1)
  taxableGain: number;
  taxByBrackets: { bracket: string; base: number; rate: number; tax: number }[];
  totalTax: number;
  effectiveRate: number; // %
};

export function calculateCapitalGainsTax(input: CapitalGainsTaxInput): CapitalGainsTaxResult;
```

### Fórmulas

```
acquisitionValue    = purchasePrice + purchaseCosts + improvements
transmissionValue   = salePrice - saleCosts
grossGain           = transmissionValue - acquisitionValue

# Si pérdida: grossGain < 0 → totalTax = 0, mostrar mensaje específico

# Exenciones aplicables (en orden):
si (isHabitualResidence && isOver65):
    exemptionOver65 = true
    taxableGain = 0

sino si (isHabitualResidence && reinvestsInHabitualResidence):
    exemptionProportion = min(reinvestmentAmount / salePrice, 1)
    taxableGain = grossGain × (1 - exemptionProportion)

sino:
    taxableGain = grossGain

# Tributación por tramos (escala del ahorro)
totalTax = applyBrackets(taxableGain, INCOME_TAX_BRACKETS_2026)
effectiveRate = (totalTax / grossGain) × 100   # solo si grossGain > 0
```

### Tramos de la base liquidable del ahorro 2026

🔴 **Verificar antes del deploy.** Tramos de referencia (vigentes 2024–2025):

| Tramo (€) | Tipo |
|---|---|
| 0 – 6.000 | 19% |
| 6.000,01 – 50.000 | 21% |
| 50.000,01 – 200.000 | 23% |
| 200.000,01 – 300.000 | 27% |
| Más de 300.000 | 28% |

**Implementación:** constante `CAPITAL_GAINS_TAX_BRACKETS_2026: { upTo: number; rate: number }[]`.

### Marco normativo

| Norma | Aplicación |
|---|---|
| Art. 33–37 Ley 35/2006 (LIRPF) | Ganancias patrimoniales |
| Art. 38 LIRPF + Art. 41 RIRPF (RD 439/2007) | Exención por reinversión en vivienda habitual |
| Art. 33.4.b LIRPF | Exención mayores de 65 años en vivienda habitual |
| DT 9ª LIRPF | Coeficientes de abatimiento (adquisiciones < 31/12/1994) — **no incluir en T3, fuera de scope para Tier 1** |

---

## 5. Outputs

### Cifra principal

- Si pérdida: `Has obtenido una pérdida patrimonial:` **`[gananciaBruta] €`** `No tributa por IRPF y puedes compensarla con otras ganancias.`
- Si exención total: `Tu venta está exenta de IRPF:` **`0 €`** `[motivo: mayores de 65 / reinversión total]`
- Caso normal: `Pagarás de IRPF por la ganancia:` **`[cuotaTotal] €`**

### Desglose secundario

| Componente | Valor |
|---|---|
| Valor de adquisición | `[valorAdquisicion] €` |
| Valor de transmisión | `[valorTransmision] €` |
| Ganancia bruta | `[gananciaBruta] €` |
| Exenciones aplicadas | `[descripción]` |
| Ganancia sometida a tributación | `[gananciaSometidaTributacion] €` |
| **Cuota total IRPF** | **`[cuotaTotal] €`** |
| Tipo efectivo | `[tipoEfectivo]%` |

### Desglose por tramos (acordeón)

| Tramo | Base | Tipo | Cuota |
|---|---|---|---|
| 0 – 6.000 | `[X]` | 19% | `[X]` |
| 6.000 – 50.000 | `[Y]` | 21% | `[Y]` |
| ... | ... | ... | ... |

### Mensaje contextual

- Si exención por reinversión parcial: "Has reinvertido el X% del precio de venta. Esa proporción de la ganancia queda exenta."
- Si gananciaBruta < 0: "Las pérdidas patrimoniales pueden compensarse con ganancias del mismo ejercicio o de los 4 siguientes."
- Recordatorio: "Esta cuota se declara en la Renta del año siguiente al de la venta (modelo 100, casilla de ganancias patrimoniales)."

---

## 6. Edge cases

| Caso | Comportamiento |
|---|---|
| Pérdida (`gananciaBruta < 0`) | `cuotaTotal = 0`, mensaje sobre compensación |
| `mayor65 && esViviendaHabitual` | Exención total, ignorar reinversión |
| Reinversión > precio venta | Topar a precio venta (proporción = 1) |
| Reinversión 0 con flag activo | Tratar como "no reinvierte" |
| Mejoras imposibles de probar documentalmente | Tooltip avisa que solo se incluyen mejoras justificables con factura |

---

## 7. Disclaimer legal

> *"Esta calculadora estima el IRPF derivado de la ganancia patrimonial por la venta de un inmueble según los arts. 33–38 de la LIRPF. Los tramos pueden variar en cada Ley de Presupuestos. La exención por reinversión exige cumplir requisitos formales (comunicación a Hacienda, plazo de 2 años). No incluye coeficientes de abatimiento por adquisiciones anteriores a 1994 (DT 9ª LIRPF). Esta herramienta no es asesoramiento fiscal — consulta con un profesional antes de presentar la declaración."*

🔴 Validar con asesor fiscal antes del deploy.

---

## 8. Email capture post-resultado

| Elemento | Valor |
|---|---|
| Título | `Te explicamos las exenciones que puedes aplicar` |
| CTA botón | `Recibir la guía de exenciones IRPF` |
| Valor entregado | PDF: tramos vigentes + exenciones (reinversión, mayores 65) + plazos + ejemplos |
| Source | `T3` |
| Email de bienvenida | Asunto: "Tu IRPF estimado + cómo calcular la plusvalía municipal" — cross-sell a T2 |

---

## 9. Cross-link

> ¿Quieres calcular también la plusvalía municipal? → `/herramientas/calculadora-plusvalia-municipal`

(Y en segunda posición) `¿Quieres ver el neto real que te llevas? → /herramientas/simulador-neto-venta-piso`

---

## 10. Artículo companion

| Elemento | Valor |
|---|---|
| Slug | `/blog/irpf-venta-piso-guia-completa` |
| Título | `IRPF por venta de piso: guía completa 2026` |
| Keyword | `irpf venta piso 2026` |
| `tool:` | `calculadora-irpf-venta-piso` |
| Estado | ⬜ **Entre los 4 artículos de lanzamiento (D-006)** |

Artículo secundario: `/blog/exencion-irpf-reinversion-vivienda-habitual`.

---

## 11. FAQ schema

| # | Pregunta | Respuesta |
|---|---|---|
| 1 | ¿Cuánto se paga a Hacienda al vender un piso? | Entre el 19% y el 28% sobre la ganancia patrimonial (precio de venta menos precio de compra y gastos), por tramos progresivos. |
| 2 | ¿Cómo se calcula la ganancia patrimonial? | Valor de transmisión (precio de venta menos gastos de venta) menos valor de adquisición (precio de compra más gastos y mejoras). |
| 3 | ¿Cuándo no se paga IRPF al vender un piso? | Si reinviertes en otra vivienda habitual (exención total o parcial), si tienes 65 años o más y era tu vivienda habitual, o si vendes con pérdida. |
| 4 | ¿Qué gastos puedo deducir? | De la compra: notaría, registro, ITP o IVA, gestoría. De la venta: comisión agencia, plusvalía municipal, cancelación hipoteca, certificado energético. |
| 5 | ¿Las reformas reducen el IRPF? | Solo las mejoras (ampliaciones, instalaciones nuevas), no las reparaciones ni el mantenimiento ordinario. Y siempre con factura. |
| 6 | ¿Cuándo se declara el IRPF de la venta? | En la Renta del año siguiente al de la venta. Si vendes en 2026, lo declaras en la Renta de 2026 que se presenta en 2027. |
| 7 | ¿Cómo aplico la exención por reinversión? | Comunicándolo en la Renta del ejercicio de la venta y reinvirtiendo en una nueva vivienda habitual en un plazo de 2 años. |

---

## 12. Definition of done

- [ ] Feature module `src/features/capital-gains-tax/` completo (components/, lib/, schemas/, content/, types.ts, index.ts)
- [ ] `calculate-capital-gains-tax.ts` + constante `CAPITAL_GAINS_TAX_BRACKETS_2026`
- [ ] Tests unitarios en `calculate-capital-gains-tax.test.ts`: pérdida, exención mayores 65, exención reinversión total/parcial, cálculo por tramos (cobertura 100%)
- [ ] `src/app/(marketing)/herramientas/calculadora-irpf-venta-piso/page.tsx` thin
- [ ] Schema Zod en `src/features/capital-gains-tax/schemas/capital-gains-tax-schema.ts`
- [ ] `src/features/capital-gains-tax/content/seo.ts` con metadata + HowTo
- [ ] `src/features/capital-gains-tax/content/faq.ts` con preguntas
- [ ] Disclaimer
- [ ] Email capture `source: 'T3'`
- [ ] Cross-link a T2 + T6
- [ ] FAQ + JSON-LD `FAQPage`
- [ ] JSON-LD `HowTo`
- [ ] OG image en `public/og/capital-gains-tax.png`
- [ ] LCP < 2,5s
- [ ] Sitemap
- [ ] **Tramos verificados con AEAT antes del deploy**
- [ ] Disclaimer revisado por asesor fiscal 🔴
- [ ] Artículo companion publicado
- [ ] Test e2e

---

*→ Guardado en: `docs/product/tools/T3-calculadora-irpf-venta-piso.md`*
