# Tool Brief — `T2` · Calculadora de plusvalía municipal (IIVTNU)

> Cuando el agente reciba "construye T2", este es el único brief que necesita leer.
> 🔴 **Tool con mayor riesgo legal del Tier 1.** Coeficientes y tipos de gravamen requieren verificación normativa antes del deploy.

---

## 1. Identificación

| Campo | Valor |
|---|---|
| ID | T2 |
| Slug / URL | `/herramientas/calculadora-plusvalia-municipal` |
| Estado | ⬜ Pendiente — **prioridad #1** del Tier 1 |
| Tier | 1 |
| Persona objetivo | B (vendedor preparándose) + C (informacional) |
| Complejidad | Media (3–5 días) |
| Dependencias | T-111 |

---

## 2. SEO

| Elemento | Valor literal |
|---|---|
| H1 | `Calculadora de plusvalía municipal 2026` |
| Title tag | `Calculadora Plusvalía Municipal 2026 — Método real y método objetivo` |
| Meta description | `Calcula la plusvalía municipal de tu venta en segundos. Incluye los dos métodos de cálculo (real e índices objetivos) y te muestra cuál es más favorable. Gratis.` |
| Keyword primaria | `calculadora plusvalía municipal` (~3.000–6.000 búsq/mes) ⭐ **mayor volumen del Tier 1** |
| Keywords secundarias | `plusvalía municipal venta piso`, `calcular plusvalía municipal`, `impuesto plusvalía venta vivienda` |
| Intención | Informacional + transaccional |
| OG image | `/og/plusvalia-municipal.png` |
| Canonical | `https://[dominio]/herramientas/calculadora-plusvalia-municipal` |
| Schema.org | `HowTo` + `FAQPage` |

---

## 3. Inputs

| # | Campo | Label | Tipo | Validación | Tooltip |
|---|---|---|---|---|---|
| 1 | `precioCompra` | Precio al que compraste el inmueble | number (€) | `z.number().min(0).max(20000000)` | El precio que figura en la escritura de compra. Si lo heredaste o recibiste como donación, usa el valor declarado entonces. |
| 2 | `precioVenta` | Precio al que vendes | number (€) | `z.number().min(10000).max(20000000)` | El precio acordado con el comprador. |
| 3 | `valorCatastralSuelo` | Valor catastral del suelo | number (€) | `z.number().min(0).max(5000000)` | Aparece en tu último recibo del IBI o en la sede del Catastro. ¡Es el valor del SUELO, no el del inmueble completo! |
| 4 | `valorCatastralTotal` | Valor catastral total | number (€) | `z.number().min(0).max(20000000)` | Suelo + construcción. Se usa para prorratear en el método real. |
| 5 | `fechaCompra` | Fecha de adquisición | date | `z.date()` | Se usa para calcular los años de tenencia. |
| 6 | `fechaVenta` | Fecha de venta | date | `z.date()` (≥ fechaCompra) | Por defecto: hoy. |
| 7 | `tipoGravamen` | Tipo de gravamen del ayuntamiento (%) | number | `z.number().min(0.1).max(30)` | Cada ayuntamiento fija el suyo (máximo 30%). Por defecto: 30%. Consúltalo en la ordenanza fiscal de tu ayuntamiento. |

**Defaults:** `tipoGravamen = 30`, `fechaVenta = hoy`.

---

## 4. Lógica de cálculo

### Función pura

Ubicación: `src/features/property-value-tax/lib/calculate-property-value-tax.ts`

```typescript
export type PropertyValueTaxInput = {
  purchasePrice: number;
  salePrice: number;
  landCadastralValue: number;
  totalCadastralValue: number;
  purchaseDate: Date;
  saleDate: Date;
  taxRate: number; // %
};

export type PropertyValueTaxResult = {
  yearsOfOwnership: number;
  hasRealIncrease: boolean;       // si false, NO se paga (STC 182/2021)
  objectiveMethod: {
    coefficient: number;
    taxableBase: number;
    taxDue: number;
  };
  realMethod: {
    realIncrease: number;
    landProportion: number;         // landCadastralValue / totalCadastralValue
    taxableBase: number;
    taxDue: number;
  } | null; // null si no hay incremento real
  favorableMethod: 'objective' | 'real' | 'no-tax';
  totalTaxDue: number;
  savingsVsUnfavorableMethod: number;
};

export function calculatePropertyValueTax(input: PropertyValueTaxInput): PropertyValueTaxResult;
```

### Fórmulas

#### Caso A: NO hay incremento real (precioVenta ≤ precioCompra)
> Por aplicación de la STC 182/2021, **no se devenga el impuesto**. Resultado: `cuotaAPagar = 0`, `metodoFavorable = 'no-tributa'`.

#### Caso B: Hay incremento real

```
yearsOfOwnership = floor((saleDate - purchaseDate) en años, máximo 20)

# Método objetivo
coefficient     = TABLA_COEFICIENTES[yearsOfOwnership]
objectiveTaxBase = landCadastralValue × coefficient
objectiveTaxDue  = objectiveTaxBase × (taxRate / 100)

# Método real
realIncrease    = salePrice - purchasePrice
landProportion  = landCadastralValue / totalCadastralValue
realTaxBase     = realIncrease × landProportion
realTaxDue      = realTaxBase × (taxRate / 100)

# Resultado
totalTaxDue     = min(objectiveTaxDue, realTaxDue)
favorableMethod = objectiveTaxDue < realTaxDue ? 'objective' : 'real'
```

### Tabla de coeficientes — método objetivo

🔴 **Verificar antes del deploy.** Los coeficientes los actualiza la Ley de Presupuestos cada año. Tabla de referencia (RDL 26/2021, valores máximos):

| Años completos | Coeficiente |
|---|---|
| Inferior a 1 año | 0,15 |
| 1 año | 0,15 |
| 2 años | 0,14 |
| 3 años | 0,15 |
| 4 años | 0,17 |
| 5 años | 0,18 |
| 6 años | 0,19 |
| 7 años | 0,18 |
| 8 años | 0,15 |
| 9 años | 0,12 |
| 10 años | 0,10 |
| 11 años | 0,09 |
| 12 años | 0,09 |
| 13 años | 0,10 |
| 14 años | 0,13 |
| 15 años | 0,17 |
| 16 años | 0,23 |
| 17 años | 0,29 |
| 18 años | 0,35 |
| 19 años | 0,41 |
| 20 años o más | 0,45 |

**Implementación:** constante exportada `PROPERTY_VALUE_TAX_COEFFICIENTS_2026: readonly number[]` con los 21 valores indexados por años (0–20).

### Marco normativo

| Norma | Aplicación |
|---|---|
| RDL Legislativo 2/2004 (TRLHL) | Marco general del IIVTNU (arts. 104–110) |
| STC 182/2021 (26-oct-2021) | Inconstitucionalidad del cálculo objetivo cuando no hay incremento |
| RDL 26/2021 (8-nov-2021) | Nueva regulación: dos métodos, no tributación si no hay incremento |
| Ordenanza fiscal del ayuntamiento | Tipo de gravamen aplicable (máx 30%) y bonificaciones |

🔴 Validar con asesor antes del deploy. La normativa puede haber cambiado.

---

## 5. Outputs

### Cifra principal

- **Caso "no tributa":** `Buenas noticias:` **`0 €`** `No pagas plusvalía municipal porque no ha habido incremento de valor (STC 182/2021).`
- **Caso normal:** `Pagarás de plusvalía municipal:` **`[cuotaAPagar] €`**

### Desglose secundario (método aplicado)

| Componente | Valor |
|---|---|
| Años de tenencia | `[aniosCompletos]` años |
| Método aplicado | `[Objetivo / Real]` (el más favorable) |
| Base imponible | `[base] €` |
| Tipo de gravamen | `[tipoGravamen]%` |
| **Cuota a pagar** | **`[cuotaAPagar] €`** |

### Desglose comparativo (acordeón colapsado)

| Concepto | Método objetivo | Método real |
|---|---|---|
| Base imponible | `[X] €` | `[Y] €` |
| Cuota | `[X] €` | `[Y] €` |
| Diferencia | — | `[ahorro] €` a favor del método más favorable |

### Mensaje contextual

- Si `cuotaAPagar = 0` → "Conserva la prueba documental (escrituras de compra y venta) por si Hacienda lo solicita."
- Si `metodoFavorable = 'real'` → "El método real es más favorable. Para aplicarlo, debes solicitarlo expresamente en la autoliquidación."
- Si `ahorroVsMetodoMenosFavorable > 500` → destacar el ahorro.

---

## 6. Edge cases

| Caso | Comportamiento |
|---|---|
| `precioVenta ≤ precioCompra` | "No tributa" — explicar STC 182/2021 |
| `valorCatastralSuelo > valorCatastralTotal` | Validación bloquea ("El valor del suelo no puede ser mayor que el catastral total") |
| `fechaVenta < fechaCompra` | Validación bloquea |
| `aniosCompletos < 1` | Aplicar coeficiente "inferior a 1 año" |
| `aniosCompletos > 20` | Topar a 20 (máximo legal) |
| Vivienda heredada/donada | Tooltip explica que el "precio de compra" es el valor declarado en la sucesión/donación |
| Ayuntamiento con bonificaciones (ej. herencias, vivienda habitual) | Mensaje informativo: "Algunos ayuntamientos aplican bonificaciones (50–95%) en transmisiones por herencia o vivienda habitual. Consulta la ordenanza fiscal de tu municipio." |

---

## 7. Disclaimer legal

> *"Esta calculadora ofrece una estimación de la plusvalía municipal (IIVTNU) basada en el RDL 26/2021 y la STC 182/2021. El tipo de gravamen y posibles bonificaciones varían en cada ayuntamiento — consulta la ordenanza fiscal de tu municipio. Los coeficientes pueden actualizarse cada año en la Ley de Presupuestos. Esta herramienta no constituye asesoramiento fiscal. Antes de presentar la autoliquidación, consulta con un asesor o con tu ayuntamiento."*

🔴 Validar con abogado/asesor fiscal antes del deploy público.

---

## 8. Email capture post-resultado

| Elemento | Valor |
|---|---|
| Título | `Recibe el cálculo en PDF con el desglose de ambos métodos` |
| CTA botón | `Enviarme el PDF` |
| Valor entregado | PDF con: cifra principal, comparativa de métodos, marco normativo, pasos para presentar la autoliquidación |
| Source en BD | `T2` |
| Email de bienvenida | Asunto: "Tu cálculo de plusvalía + un dato sobre el IRPF que te puede ahorrar miles" — cross-sell a T3 |

---

## 9. Cross-link a otra tool

> ¿Quieres saber también cuánto pagarás de IRPF por la venta? → `/herramientas/calculadora-irpf-venta-piso`

Razón: el IRPF y la plusvalía son los dos impuestos principales en una venta. El usuario que calculó uno necesita el otro.

---

## 10. Artículo companion

| Elemento | Valor |
|---|---|
| Slug | `/blog/como-calcular-plusvalia-municipal` |
| Título | `Cómo calcular la plusvalía municipal al vender una vivienda (2026)` |
| Keyword | `cómo calcular plusvalía municipal` |
| `tool:` | `calculadora-plusvalia-municipal` |
| Estado | ⬜ **Entre los 4 artículos de lanzamiento (D-006)** |

---

## 11. FAQ schema

| # | Pregunta | Respuesta breve |
|---|---|---|
| 1 | ¿Qué es la plusvalía municipal? | Impuesto local (IIVTNU) que grava el incremento de valor de los terrenos urbanos al transmitirlos. Lo recauda el ayuntamiento. |
| 2 | ¿Quién paga la plusvalía municipal en una venta? | El vendedor, salvo que ambas partes pacten lo contrario en el contrato. |
| 3 | ¿Cuándo NO se paga plusvalía municipal? | Cuando el precio de venta es igual o inferior al de compra (STC 182/2021), si se prueba documentalmente. |
| 4 | ¿Cuáles son los dos métodos de cálculo? | El método objetivo (valor catastral × coeficiente × tipo) y el método real (incremento × proporción suelo × tipo). El contribuyente elige el más favorable. |
| 5 | ¿En qué plazo hay que pagar la plusvalía? | 30 días hábiles desde la firma de la escritura, en autoliquidación o liquidación según el ayuntamiento. |
| 6 | ¿Existen bonificaciones en la plusvalía? | Sí, muchos ayuntamientos las aplican en transmisiones por herencia (hasta 95%) o vivienda habitual. Consulta la ordenanza fiscal local. |
| 7 | ¿De dónde saco el valor catastral del suelo? | Del último recibo del IBI o en la sede electrónica del Catastro con tu certificado digital. |

---

## 12. Definition of done

- [ ] Feature module `src/features/property-value-tax/` completo (components/, lib/, schemas/, content/, types.ts, index.ts)
- [ ] `calculate-property-value-tax.ts` + constante `PROPERTY_VALUE_TAX_COEFFICIENTS_2026`
- [ ] Tests unitarios en `calculate-property-value-tax.test.ts` cubriendo: caso "no tributa", método objetivo, método real, elección del favorable, edge case de >20 años (cobertura 100%)
- [ ] `src/app/(marketing)/herramientas/calculadora-plusvalia-municipal/page.tsx` thin
- [ ] Schema Zod en `src/features/property-value-tax/schemas/property-value-tax-schema.ts`
- [ ] `src/features/property-value-tax/content/seo.ts` con metadata + HowTo schema
- [ ] `src/features/property-value-tax/content/faq.ts` con preguntas
- [ ] Disclaimer visible bajo el resultado
- [ ] Email capture con `source: 'T2'`
- [ ] Cross-link a T3
- [ ] FAQ + JSON-LD `FAQPage` (mínimo 7 preguntas)
- [ ] JSON-LD `HowTo`
- [ ] OG image en `public/og/property-value-tax.png`
- [ ] LCP < 2,5s en mobile
- [ ] Entrada en sitemap
- [ ] **Coeficientes verificados con BOE / web del ayuntamiento de Madrid o Barcelona como referencia**
- [ ] Disclaimer revisado por abogado o asesor fiscal 🔴
- [ ] Artículo companion publicado
- [ ] Test e2e

---

*→ Guardado en: `docs/product/tools/T2-calculadora-plusvalia-municipal.md`*
