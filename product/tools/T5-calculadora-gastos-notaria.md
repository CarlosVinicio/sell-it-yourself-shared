# Tool Brief — `T5` · Calculadora de gastos de notaría en una compraventa

> Cuando el agente reciba "construye T5", este es el único brief que necesita leer.

---

## 1. Identificación

| Campo | Valor |
|---|---|
| ID | T5 |
| Slug / URL | `/herramientas/calculadora-gastos-notaria-compraventa` |
| Estado | ⬜ Pendiente |
| Tier | 1 |
| Persona objetivo | B + C (planificación de gastos) |
| Complejidad | Baja-media (2–3 días) |
| Dependencias | T-111 |

---

## 2. SEO

| Elemento | Valor literal |
|---|---|
| H1 | `Calculadora de gastos de notaría en una compraventa` |
| Title tag | `Gastos de Notaría Compraventa Piso 2026 — Calculadora gratuita` |
| Meta description | `¿Cuánto cobra el notario en una compraventa de vivienda? Introduce el precio de venta y calcula los aranceles notariales exactos. Gratis y actualizado 2026.` |
| Keyword primaria | `gastos notario compraventa piso` (~1.000–2.000 búsq/mes) |
| Keywords secundarias | `cuánto cobra el notario compraventa`, `arancel notarial compraventa vivienda` |
| Intención | Informacional |
| OG image | `/og/gastos-notaria.png` |
| Schema.org | `HowTo` + `FAQPage` |

---

## 3. Inputs

| # | Campo | Label | Tipo | Validación | Tooltip |
|---|---|---|---|---|---|
| 1 | `precioEscritura` | Precio que figurará en la escritura | number (€) | `z.number().min(1000).max(20000000)` | El precio de compraventa que se hará constar en la escritura pública. |
| 2 | `numeroCopiasAutorizadas` | Nº de copias autorizadas | number | `z.number().min(1).max(10)` | Cada parte (vendedor, comprador, banco si hay hipoteca) suele necesitar una. Por defecto: 2. |
| 3 | `numeroCopiasSimples` | Nº de copias simples | number | `z.number().min(0).max(20)` | Para gestiones administrativas. Por defecto: 3. |

**Defaults:** `numeroCopiasAutorizadas = 2`, `numeroCopiasSimples = 3`.

---

## 4. Lógica de cálculo

### Función pura

Ubicación: `src/features/notary-fees/lib/calculate-notary-fees.ts`

```typescript
export type NotaryFeesInput = {
  scriptPrice: number;
  authorizedCopies: number;
  simpleCopies: number;
};

export type NotaryFeesResult = {
  baseHonorarium: number;         // arancel base por la escritura
  authorizedCopiesCost: number;   // coste de las copias autorizadas
  simpleCopiesCost: number;
  taxableBase: number;            // suma antes de IVA
  vat: number;                    // 21%
  totalWithVat: number;
  scaledBreakdown: { bracket: string; amount: number }[];
};

export function calculateNotaryFees(input: NotaryFeesInput): NotaryFeesResult;
```

### Fórmulas — escala de aranceles (RD 1426/1989, Anexo II)

🔴 **Verificar antes del deploy.** El RD 1426/1989 lleva años sin actualización significativa pero confirmar.

```
# Cálculo del arancel base por escala marginal
si scriptPrice ≤ 6010,12:
    baseHonorarium = 90,15

sino:
    baseHonorarium = 90,15
    + min(scriptPrice - 6010,12, 30050,61 - 6010,12) × 0,0045
    + max(0, min(scriptPrice - 30050,61, 60101,21 - 30050,61)) × 0,0015
    + max(0, min(scriptPrice - 60101,21, 150253,03 - 60101,21)) × 0,0010
    + max(0, min(scriptPrice - 150253,03, 601012,10 - 150253,03)) × 0,0005
    + max(0, min(scriptPrice - 601012,10, 6010121,04 - 601012,10)) × 0,0003
    # > 6.010.121,04: pactado libremente

# Mínimo legal facturable
baseHonorarium = max(baseHonorarium, 90,15)

# Copias
authorizedCopiesCost = authorizedCopies × 30     # ~30 € cada una
simpleCopiesCost     = simpleCopies × 3          # ~3 € cada una

# Total
taxableBase = baseHonorarium + authorizedCopiesCost + simpleCopiesCost
vat         = taxableBase × 0,21
totalWithVat = taxableBase + vat
```

### Tramos de escala (referencia visual)

| Tramo (€) | Tipo marginal |
|---|---|
| 0 – 6.010,12 | 90,15 € (mínimo fijo) |
| 6.010,13 – 30.050,61 | 4,5 ‰ |
| 30.050,62 – 60.101,21 | 1,50 ‰ |
| 60.101,22 – 150.253,03 | 1,00 ‰ |
| 150.253,04 – 601.012,10 | 0,50 ‰ |
| 601.012,11 – 6.010.121,04 | 0,30 ‰ |
| > 6.010.121,04 | Pactado |

### Marco normativo

| Norma | Aplicación |
|---|---|
| RD 1426/1989 (Anexo II) | Aranceles notariales — escala vigente |
| Art. 90 LIVA | IVA 21% sobre servicios notariales |
| Art. 1455 Código Civil | Gastos de escritura matriz a cargo del vendedor (salvo pacto en contrario) |

**Reparto habitual de gastos notariales:**
- **Vendedor:** escritura matriz (la principal)
- **Comprador:** copias autorizadas, gestiones del banco si hay hipoteca

---

## 5. Outputs

### Cifra principal

`Los gastos notariales totales serán aproximadamente:` **`[totalConIVA] €`**

### Desglose

| Concepto | Importe |
|---|---|
| Arancel matriz (la escritura) | `[arancelMatriz] €` |
| Copias autorizadas (`[N]`) | `[copiasAutorizadas] €` |
| Copias simples (`[N]`) | `[copiasSimples] €` |
| Base imponible | `[baseImponible] €` |
| IVA (21%) | `[iva] €` |
| **TOTAL** | **`[totalConIVA] €`** |

### Detalle del escalado (acordeón colapsado)

| Tramo aplicado | Importe parcial |
|---|---|
| Mínimo (hasta 6.010,12 €) | 90,15 € |
| Tramo 6.010 – 30.050 | `[X] €` |
| ... | ... |

### Mensaje contextual

- "El **vendedor** paga la escritura matriz (≈ `[arancelMatriz × 1,21] €`); el **comprador** paga las copias autorizadas y las gestiones bancarias."
- Recordatorio: "Estos importes son estimación según el RD 1426/1989. Cada notaría aplica los aranceles oficiales — la diferencia entre notarías es mínima."

---

## 6. Edge cases

| Caso | Comportamiento |
|---|---|
| `precioEscritura < 6.010,12` | Aplicar mínimo de 90,15 € |
| `precioEscritura > 6.010.121,04` | Mensaje informativo: "Para precios superiores a 6 millones de euros, los aranceles son pactables libremente con la notaría." |
| `numeroCopiasAutorizadas = 0` | No permitir, mínimo 1 (la escritura matriz necesita al menos una copia) |

---

## 7. Disclaimer legal

> *"Esta calculadora estima los aranceles notariales según el RD 1426/1989 (Anexo II) vigente. El coste real puede variar ligeramente según la complejidad de la escritura (cláusulas adicionales, número de otorgantes, anejos). El IVA aplicado es el 21% (Art. 90 LIVA). Estos gastos no incluyen otros costes de la operación (Registro, AJD, plusvalía, ITP). Consulta a tu notaría para un presupuesto exacto."*

---

## 8. Email capture post-resultado

| Elemento | Valor |
|---|---|
| Título | `¿Quieres el desglose completo de TODOS los gastos de la venta?` |
| CTA botón | `Recibir el desglose completo` |
| Valor entregado | PDF con: gastos notaría + Registro + plusvalía + IRPF estimado + cancelación hipoteca + comparativa con/sin agencia |
| Source | `T5` |
| Email de bienvenida | Cross-sell directo a T6 (simulador neto). |

---

## 9. Cross-link

> ¿Quieres ver el neto real que te llevas tras todos los gastos? → `/herramientas/simulador-neto-venta-piso`

---

## 10. Artículo companion

| Elemento | Valor |
|---|---|
| Slug | `/blog/gastos-notaria-compraventa-vivienda` |
| Título | `Gastos de notaría en una compraventa de vivienda (2026)` |
| Keyword | `gastos notario compraventa` |
| `tool:` | `calculadora-gastos-notaria-compraventa` |
| Estado | ⬜ Pendiente — semana 2–3 (no de los 4 prioritarios) |

---

## 11. FAQ schema

| # | Pregunta | Respuesta |
|---|---|---|
| 1 | ¿Cuánto cobra el notario en una compraventa? | Para un piso de 200.000 €, los aranceles notariales rondan los 600–900 € con IVA, según el número de copias. |
| 2 | ¿Quién paga al notario, comprador o vendedor? | Por defecto (Art. 1455 CC), el vendedor paga la escritura matriz y el comprador las copias. Es habitual pactar en el contrato un reparto distinto. |
| 3 | ¿Las notarías cobran lo mismo en toda España? | Sí, los aranceles notariales son fijos por ley (RD 1426/1989). Las pequeñas diferencias entre notarías vienen del número de copias y servicios accesorios. |
| 4 | ¿Cuánto cuestan las copias del notario? | Las copias autorizadas (con valor legal) cuestan unos 30 € cada una. Las copias simples (informativas) unos 3 € cada una. |
| 5 | ¿Lleva IVA la factura del notario? | Sí, los servicios notariales tributan al 21% de IVA. |
| 6 | ¿Puedo elegir notaría libremente? | Sí. Por ley el comprador (que asume las copias y la gestoría) puede elegir la notaría. En la práctica, comprador y vendedor suelen pactarla. |

---

## 12. Definition of done

- [ ] Feature module `src/features/notary-fees/` completo (components/, lib/, schemas/, content/, types.ts, index.ts)
- [ ] `calculate-notary-fees.ts` con la escala marginal exacta del RD 1426/1989
- [ ] Tests unitarios en `calculate-notary-fees.test.ts`: caso mínimo (<6.010 €), tramos intermedios, caso > 6 millones (cobertura 100%)
- [ ] `src/app/(marketing)/herramientas/calculadora-gastos-notaria-compraventa/page.tsx` thin
- [ ] Schema Zod en `src/features/notary-fees/schemas/notary-fees-schema.ts`
- [ ] `src/features/notary-fees/content/seo.ts` con metadata + HowTo
- [ ] `src/features/notary-fees/content/faq.ts` con preguntas
- [ ] Disclaimer
- [ ] Email capture `source: 'T5'`
- [ ] Cross-link a T6
- [ ] FAQ + JSON-LD `FAQPage`
- [ ] JSON-LD `HowTo`
- [ ] OG image en `public/og/notary-fees.png`
- [ ] LCP < 2,5s
- [ ] Sitemap
- [ ] Disclaimer revisado 🔴
- [ ] Artículo companion (semana 2–3)
- [ ] Test e2e

---

*→ Guardado en: `docs/product/tools/T5-calculadora-gastos-notaria.md`*
