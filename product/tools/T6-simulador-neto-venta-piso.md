# Tool Brief — `T6` · Simulador del neto real de la venta

> Cuando el agente reciba "construye T6", este es el único brief que necesita leer.
> ⚠️ T6 reutiliza las funciones puras de T1, T2, T3 y T5. Construir **última**, cuando esas tools estén estables.

---

## 1. Identificación

| Campo | Valor |
|---|---|
| ID | T6 |
| Slug / URL | `/herramientas/simulador-neto-venta-piso` |
| Estado | ⬜ Pendiente — última del Tier 1 |
| Tier | 1 |
| Persona objetivo | A + B (alta intención) |
| Complejidad | Media (2–3 días, depende de T1/T2/T3/T5) |
| Dependencias | T-111, T1, T2, T3, T5 |

---

## 2. SEO

| Elemento | Valor literal |
|---|---|
| H1 | `¿Cuánto dinero te quedas al vender tu piso?` |
| Title tag | `Simulador Neto Venta Piso 2026 — Calcula lo que realmente te llevas` |
| Meta description | `Calcula el dinero neto que recibirás al vender tu piso: precio menos IRPF, plusvalía municipal, gastos de cancelación de hipoteca y otros costes. Todo en un cálculo.` |
| Keyword primaria | `cuánto me quedo al vender mi piso` (~500–1.500 búsq/mes) |
| Keywords secundarias | `dinero neto venta piso`, `beneficio real vender vivienda`, `simulador venta piso` |
| Intención | Muy alta intención — usuario en momento de decisión |
| OG image | `/og/simulador-neto.png` |
| Schema.org | `HowTo` + `FAQPage` |

---

## 3. Inputs

T6 reúne inputs de T1+T2+T3+T5. Para no abrumar al usuario, dividir en pasos (wizard de 3 pantallas):

### Paso 1 — Datos básicos

| Campo | Label | Tipo | Validación |
|---|---|---|---|
| `precioVenta` | Precio de venta esperado | number (€) | `z.number().min(10000).max(20000000)` |
| `precioCompra` | Precio al que lo compraste | number (€) | `z.number().min(0).max(20000000)` |
| `aniosTenencia` | Años que has sido propietario | number | `z.number().min(0).max(100)` |
| `esViviendaHabitual` | ¿Es tu vivienda habitual? | boolean | `z.boolean()` |

### Paso 2 — Costes asociados (con defaults razonables)

| Campo | Label | Tipo | Default |
|---|---|---|---|
| `valorCatastralSuelo` | Valor catastral del suelo | number (€) | — (con tooltip ayuda) |
| `valorCatastralTotal` | Valor catastral total | number (€) | — |
| `tipoGravamenPlusvalia` | % plusvalía del ayuntamiento | number | 30 (máximo legal) |
| `gastosCompra` | Gastos originales de la compra | number (€) | 0 |
| `mejoras` | Mejoras realizadas (con factura) | number (€) | 0 |
| `cancelacionHipoteca` | Gastos de cancelación de hipoteca | number (€) | 0 |
| `usaAgencia` | ¿Vas a usar agencia? | boolean | false |
| `comisionAgencia` | % comisión (si usa agencia) | number | 4 |

### Paso 3 — Exenciones

| Campo | Label | Tipo |
|---|---|---|
| `reinvierte` | ¿Reinvertirás en otra vivienda habitual? | boolean |
| `importeReinvertido` | Importe a reinvertir | number (€) |
| `mayor65` | ¿Tienes 65 o más años? | boolean |

---

## 4. Lógica de cálculo

### Función pura — composición

Ubicación: `src/features/net-sale-proceeds/lib/calculate-net-sale-proceeds.ts`

> **Excepción documentada de la regla de imports entre features (ADR-002 §5.bis):** este módulo importa de las public APIs de T1, T2, T3 y T5 — composición justificada por el brief.

```typescript
import { calculatePropertyValueTax } from '@/features/property-value-tax';
import { calculateCapitalGainsTax } from '@/features/capital-gains-tax';
import { calculateAgencySavings } from '@/features/agency-savings';
import { calculateNotaryFees } from '@/features/notary-fees';

export type NetSaleProceedsInput = {
  // Paso 1
  salePrice: number;
  purchasePrice: number;
  yearsOwned: number;
  isHabitualResidence: boolean;
  // Paso 2
  landCadastralValue: number;
  totalCadastralValue: number;
  propertyTaxRate: number;
  purchaseCosts: number;
  improvements: number;
  mortgageCancellation: number;
  usesAgency: boolean;
  agencyCommissionRate: number;
  // Paso 3
  reinvests: boolean;
  reinvestmentAmount: number;
  isOver65: boolean;
};

export type NetSaleProceedsResult = {
  salePrice: number;
  costs: {
    incomeTax: number;
    propertyValueTax: number;
    mortgageCancellation: number;
    notaryFees: number;             // estimado: ~50% del arancel matriz
    agencyCommission: number;       // 0 si usesAgency = false
    other: number;                  // CEE estimado, certificados, ~150 €
  };
  totalCosts: number;
  netProceeds: number;
  netPercentage: number;            // netProceeds / salePrice
  agencySavings: number;            // solo si usesAgency = false: cuánto se ahorra vs. con agencia
};

export function calculateNetSaleProceeds(input: NetSaleProceedsInput): NetSaleProceedsResult;
```

### Algoritmo

```
# Reutilizar las funciones de las tools previas
propertyValueTax = calculatePropertyValueTax({...})
incomeTax        = calculateCapitalGainsTax({...})
estimatedNotaryFees = calculateNotaryFees({scriptPrice: salePrice}).baseHonorarium × 1,21 × 0,5
agencyCommissionCalc = calculateAgencySavings({salePrice, commissionPercentage: agencyCommissionRate, includesVat: 'no'})

costs.incomeTax            = incomeTax.totalTax
costs.propertyValueTax     = propertyValueTax.totalTaxDue
costs.mortgageCancellation = input.mortgageCancellation
costs.notaryFees           = estimatedNotaryFees
costs.agencyCommission     = usesAgency ? agencyCommissionCalc.totalCommission : 0
costs.other                = 200  # CEE + certificados varios estimados

totalCosts = sum(costs)
netProceeds = salePrice - totalCosts
netPercentage = (netProceeds / salePrice) × 100

# Comparativa: si NO usa agencia, calcular cuánto se "ahorra" vs. usarla
agencySavings = !usesAgency ? agencyCommissionCalc.totalCommission : 0
```

---

## 5. Outputs

### Cifra principal

`Vas a recibir aproximadamente:` **`[netProceeds] €`** `(${netPercentage}% del precio de venta)`

### Desglose de costes

| Concepto | Importe | % sobre venta |
|---|---|---|
| Precio de venta | `[salePrice] €` | 100% |
| − IRPF (ganancia patrimonial) | `[incomeTax] €` | `[%]` |
| − Plusvalía municipal | `[propertyValueTax] €` | `[%]` |
| − Cancelación de hipoteca | `[mortgageCancellation] €` | `[%]` |
| − Notaría (parte del vendedor) | `[notaryFees] €` | `[%]` |
| − Comisión de agencia (si usa) | `[agencyCommission] €` | `[%]` |
| − Otros (CEE, certificados) | `~200 €` | — |
| **TOTAL costes** | `[totalCosts] €` | `[%]` |
| **NETO FINAL** | **`[netProceeds] €`** | `[netPercentage]%` |

### Mensaje destacado (siempre)

- Si `usesAgency = false`:
  > 🎉 **Vendiendo sin agencia te ahorras `[agencySavings] €`** comparado con una agencia al `[agencyCommissionRate]%`. Eso es lo que te queda en el bolsillo.

- Si `usesAgency = true`:
  > Si vendieras sin agencia, te quedarías con `[netProceeds + agencySavingsPotential] €` adicionales en el bolsillo.

### Mensaje contextual

- Si `irpf = 0` (exención): "Buenas noticias: tu venta queda exenta de IRPF [por el motivo aplicable]."
- Si `plusvaliaMunicipal = 0` (no incremento): "No pagas plusvalía municipal porque no ha habido incremento de valor (STC 182/2021)."

---

## 6. Edge cases

| Caso | Comportamiento |
|---|---|
| Pérdida en la venta (`precioVenta < precioCompra + gastos`) | IRPF = 0; mensaje sobre compensación de pérdidas |
| `valorCatastralSuelo = 0` | Tooltip explica cómo encontrarlo; permitir continuar con plusvalía estimada por método real solo |
| Wizard incompleto | No mostrar resultado hasta que paso 1 esté completo (los pasos 2 y 3 tienen defaults) |
| Resultado negativo (`netoFinal < 0`) | Mostrar warning rojo: "Los costes superarían el precio de venta. Revisa los datos o consulta a un asesor." |

---

## 7. Disclaimer legal

> *"Este simulador combina estimaciones de IRPF (Arts. 33–38 LIRPF), plusvalía municipal (RDL 26/2021 + STC 182/2021), aranceles notariales (RD 1426/1989) y comisiones de agencia. Es una estimación orientativa basada en la normativa vigente. La cifra final depende de la ordenanza fiscal del ayuntamiento, del notario elegido, de las exenciones aplicables y del contrato con la agencia. No constituye asesoramiento fiscal ni jurídico — consulta con un profesional antes de la venta."*

🔴 Disclaimer crítico — esta tool da una cifra que el usuario puede usar para tomar la decisión de vender o no.

---

## 8. Email capture post-resultado

| Elemento | Valor |
|---|---|
| Título | `[Si usaAgencia=false] Tu ahorro vendiendo sin agencia: +[ahorroSinAgencia] €. ¿Quieres la guía paso a paso?` |
| | `[Si usaAgencia=true] ¿Quieres ver cómo vender sin agencia y quedarte +[ahorroSinAgenciaPotencial] €?` |
| CTA botón | `Recibir la guía` |
| Valor entregado | PDF: cálculo personalizado + 10 pasos para vender sin agencia + checklist de documentación de su CCAA |
| Source | `T6` |
| Email de bienvenida | Asunto: "Tu cálculo neto + el primer paso para vender sin agencia" — dirige al checklist (T4) |

---

## 9. Cross-link

> Ya conoces la cifra final. ¿Empezamos con la documentación? → `/herramientas/checklist-documentacion-venta-piso`

---

## 10. Artículo companion

| Elemento | Valor |
|---|---|
| Slug | `/blog/cuanto-dinero-te-quedas-al-vender-tu-piso` |
| Título | `Cuánto dinero te quedas realmente al vender tu piso (2026)` |
| Keyword | `neto venta piso` |
| `tool:` | `simulador-neto-venta-piso` |
| Estado | ⬜ Pendiente — semana 3–4 |

---

## 11. FAQ schema

| # | Pregunta | Respuesta |
|---|---|---|
| 1 | ¿Cuánto me queda neto al vender un piso? | Depende del precio, IRPF (19–28% de la ganancia), plusvalía municipal, cancelación de hipoteca y comisión de agencia (3–6%). En general, entre el 80% y el 95% del precio de venta si vendes sin agencia. |
| 2 | ¿Cuáles son los principales gastos al vender un piso? | IRPF por la ganancia, plusvalía municipal, cancelación de hipoteca (≈ 1.000–1.500 €), notaría (parte del vendedor), certificado energético (80–250 €) y, opcionalmente, comisión de agencia (3–6% + IVA). |
| 3 | ¿Cuánto se ahorra vendiendo sin agencia? | Entre el 3% y el 7% del precio de venta (la comisión de agencia con IVA). En un piso de 200.000 € son entre 7.260 € y 16.940 €. |
| 4 | ¿Quién paga los gastos del notario en una venta? | Por defecto, el vendedor paga la escritura matriz y el comprador las copias autorizadas. Es habitual pactar en el contrato un reparto distinto. |
| 5 | ¿Cuándo voy a recibir el dinero de la venta? | Al firmar la escritura ante notario. Si hay hipoteca pendiente, se cancela en ese mismo acto y recibes la diferencia. |

---

## 12. Definition of done

- [ ] Feature module `src/features/net-sale-proceeds/` completo (components/, lib/, schemas/, content/, types.ts, index.ts)
- [ ] `calculate-net-sale-proceeds.ts` que importe y combine T1+T2+T3+T5 desde sus public APIs (`@/features/...`)
- [ ] Tests unitarios en `calculate-net-sale-proceeds.test.ts`: composición correcta, exenciones aplicadas, comparativa con/sin agencia (cobertura 100%)
- [ ] `src/app/(marketing)/herramientas/simulador-neto-venta-piso/page.tsx` thin con wizard de 3 pasos
- [ ] Componente `<WizardStep>` reutilizable en `src/components/tool/WizardStep.tsx`
- [ ] Schema Zod en `src/features/net-sale-proceeds/schemas/net-sale-proceeds-schema.ts`
- [ ] `src/features/net-sale-proceeds/content/seo.ts` con metadata + HowTo
- [ ] `src/features/net-sale-proceeds/content/faq.ts` con preguntas
- [ ] Disclaimer
- [ ] Email capture `source: 'T6'`
- [ ] Cross-link a T4 (checklist)
- [ ] FAQ + JSON-LD `FAQPage`
- [ ] JSON-LD `HowTo`
- [ ] OG image en `public/og/net-sale-proceeds.png`
- [ ] LCP < 2,5s
- [ ] Sitemap
- [ ] Disclaimer crítico revisado por abogado 🔴
- [ ] Artículo companion publicado
- [ ] Test e2e: completar wizard → ver resultado correcto compuesto → submit email

---

*→ Guardado en: `docs/product/tools/T6-simulador-neto-venta-piso.md`*
