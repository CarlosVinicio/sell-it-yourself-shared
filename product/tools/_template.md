# Tool Brief Template — `T?` · `[Nombre de la herramienta]`

> **Uso:** este es el documento de referencia único para construir una herramienta.
> Cuando el agente reciba "construye T?", debe leer este archivo y poder ejecutar sin abrir ningún otro documento de producto, UX o SEO.
> Solo lee CLAUDE.md + memoria + este brief.

---

## 1. Identificación

| Campo | Valor |
|---|---|
| ID | T? |
| Slug / URL | `/herramientas/[slug]` |
| Estado | ⬜ Pendiente / 🟡 En curso / ✅ Construida |
| Tier | 1 |
| Persona objetivo | A / B / C — ver `docs/marketing/gtm/estrategia-gtm-tier1.md` § 1 |
| Complejidad estimada | Baja / Media / Alta |
| Dependencias | T-111 (scaffolding), otras tools si aplica |

---

## 2. SEO — datos exactos para el desarrollo

| Elemento | Valor literal |
|---|---|
| H1 | `[copia exacta]` |
| Title tag (máx 60 car.) | `[copia exacta]` |
| Meta description (máx 158 car.) | `[copia exacta]` |
| Keyword primaria | `[keyword]` (~X búsq/mes) |
| Keywords secundarias | `[lista]` |
| Intención de búsqueda | Informacional / Transaccional / Navegacional |
| Open Graph image | `/og/[slug].png` (generar) |
| Canonical URL | `https://dominio.com/herramientas/[slug]` |
| Schema.org | `HowTo` + `FAQPage` |

---

## 3. Inputs del formulario

Cada input define: nombre interno, label visible, tipo, validación Zod, placeholder, tooltip.

| # | Campo (ts) | Label | Tipo | Validación | Placeholder | Tooltip |
|---|---|---|---|---|---|---|
| 1 | `[name]` | `[label]` | `number / select / text` | `z.number().min(...).max(...)` | `[placeholder]` | `[tooltip]` |

**Reglas globales:**
- Validación inline (no esperar al submit).
- Placeholder con formato esperado.
- Tooltip obligatorio en términos técnicos.
- Máx 5 inputs visibles a la vez.

---

## 4. Lógica de cálculo

### Función pura

Ubicación: `lib/calculations/[slug].ts`

```typescript
export type [Name]Input = {
  // tipos exactos
};

export type [Name]Result = {
  // shape exacto del resultado
};

export function calcular[Name](input: [Name]Input): [Name]Result {
  // pseudocódigo o implementación
}
```

### Fórmulas

```
[Fórmula matemática exacta, paso a paso]
```

### Tablas / coeficientes

Si el cálculo usa tablas de tramos, coeficientes o tipos, listarlas aquí literalmente con su fuente.

| Tramo / Coeficiente | Valor | Fuente | Vigencia |
|---|---|---|---|

🔴 **Verificar vigencia normativa antes del deploy.** Cualquier valor citado aquí debe tener fuente trazable.

---

## 5. Outputs

### Cifra principal

`[Texto que precede al número]` **`[CIFRA EN €]`** `[Texto posterior si aplica]`

### Desglose secundario

Tabla / lista con los componentes del cálculo (ej: base imponible, cuota, ahorro vs. alternativa).

| Componente | Valor | Nota |
|---|---|---|

### Mensaje contextual

Texto adaptativo según el resultado (ej: "El método objetivo te ahorra X €" vs. "Se aplica el método real").

---

## 6. Edge cases que la implementación debe manejar

| Caso | Comportamiento esperado |
|---|---|
| Input cero o negativo | Validación bloquea submit |
| Resultado negativo / no aplica | Mostrar mensaje específico, no cifra |
| Valor fuera de rango razonable | Warning amarillo, pero permitir cálculo |
| `[caso fiscal específico]` | `[manejo]` |

---

## 7. Disclaimer legal

Texto literal a mostrar bajo el resultado:

> *"`[Disclaimer específico de esta tool]`"*

🔴 Validar texto con asesor legal antes del deploy público.

---

## 8. Email capture post-resultado

| Elemento | Valor |
|---|---|
| Título de la sección | `[copia exacta]` |
| CTA del botón | `[copia exacta]` |
| Valor entregado | `[Qué recibe el usuario en el email]` |
| Source en BD | `T?` (columna `subscribers.source`) |
| Email de bienvenida | `[Asunto + resumen del contenido]` |

---

## 9. Cross-link a otras tools

Tras el resultado, mostrar:

> `[Pregunta que enlaza con la siguiente tool]` → `/herramientas/[slug-destino]`

Razón: `[por qué esa tool y no otra]`

---

## 10. Artículo companion del blog

| Elemento | Valor |
|---|---|
| Slug | `/blog/[slug]` |
| Título | `[título]` |
| Keyword objetivo | `[keyword informacional]` |
| Frontmatter `tool:` | `[slug-de-tool]` (para link automático) |
| Estado | ⬜ Pendiente / ✅ Publicado |

---

## 11. FAQ schema (mínimo 5 preguntas)

Cada pregunta se renderiza al final de la página y se serializa como `FAQPage` en JSON-LD.

| # | Pregunta | Respuesta breve |
|---|---|---|
| 1 | `[pregunta]` | `[respuesta]` |

---

## 12. Definition of done — checklist de aceptación

La herramienta NO se considera terminada hasta cumplir todos estos puntos:

- [ ] Función pura en `lib/calculations/[slug].ts` con tests unitarios (cobertura 100%)
- [ ] Componente `app/(marketing)/herramientas/[slug]/page.tsx` con metadata generada
- [ ] Formulario con React Hook Form + validación Zod
- [ ] Disclaimer visible bajo resultado
- [ ] Email capture con `source` correcto
- [ ] Cross-link a tool siguiente
- [ ] FAQ visible + JSON-LD `FAQPage`
- [ ] JSON-LD `HowTo` para el cálculo
- [ ] OG image generada en `/public/og/[slug].png`
- [ ] Mobile-first revisado en 375px (LCP < 2,5s, CLS < 0,1)
- [ ] Entrada en `sitemap.xml` (next-sitemap)
- [ ] Disclaimer legal validado contra `compliance-tier1.md`
- [ ] Artículo companion publicado o programado
- [ ] Test e2e mínimo: rellenar form → ver resultado → submit email

---

*→ Guardado en: `docs/product/tools/_template.md`*
*Plantilla. Copiar como `T?-[slug].md` y rellenar para cada herramienta.*
