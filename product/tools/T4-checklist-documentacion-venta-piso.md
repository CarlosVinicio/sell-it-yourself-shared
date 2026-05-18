# Tool Brief — `T4` · Checklist de documentación por CCAA

> Cuando el agente reciba "construye T4", este es el único brief que necesita leer.
> Esta tool **no es un cálculo** — es contenido interactivo dinámico. La lógica vive en datos, no en fórmulas.

---

## 1. Identificación

| Campo | Valor |
|---|---|
| ID | T4 |
| Slug / URL | `/herramientas/checklist-documentacion-venta-piso` |
| Estado | ⬜ Pendiente — alta prioridad por captura de email |
| Tier | 1 |
| Persona objetivo | B (vendedor activo) |
| Complejidad | Media-alta (4–6 días — el contenido por CCAA es el grueso) |
| Dependencias | T-111 |

---

## 2. SEO

| Elemento | Valor literal |
|---|---|
| H1 | `Checklist de documentos para vender un piso` |
| Title tag | `Documentos para Vender un Piso 2026 — Checklist por Comunidad Autónoma` |
| Meta description | `Lista interactiva de documentos necesarios para vender tu piso, adaptada a tu comunidad autónoma. Marca los que ya tienes y descubre cómo obtener los que faltan.` |
| Keyword primaria | `documentos para vender un piso` (~2.000–4.000 búsq/mes) |
| Keywords secundarias | `qué necesito para vender mi piso`, `checklist venta piso particular`, `papeles para vender casa` |
| Intención | Informacional con alto valor para email capture |
| OG image | `/og/checklist-documentacion.png` |
| Schema.org | `HowTo` (cada documento como step) + `FAQPage` |

---

## 3. Inputs (selectores, no formulario tradicional)

| # | Campo | Label | Tipo | Validación | Tooltip |
|---|---|---|---|---|---|
| 1 | `ccaa` | Comunidad Autónoma del inmueble | select (17 + Ceuta + Melilla) | `z.enum([...])` | Selecciona la CCAA donde se ubica el inmueble. La normativa autonómica determina algunos documentos obligatorios. |
| 2 | `tipoInmueble` | Tipo de inmueble | select | `z.enum(['piso', 'chalet', 'local', 'terreno'])` | Algunos documentos varían según tipología (ej. estatutos comunidad solo aplican a piso/chalet adosado). |
| 3 | `antiguedadAnios` | Antigüedad de la construcción | number (años) | `z.number().min(0).max(500)` | Necesaria para saber si requiere ITE/IEE (>30/45/50 años según municipio). |
| 4 | `tieneHipoteca` | ¿Tiene hipoteca pendiente? | boolean | `z.boolean()` | Si sí, añadiremos el certificado de saldo y la cancelación al checklist. |

**No hay submit clásico.** El checklist se renderiza reactivamente al cambiar los inputs. Persistencia opcional en `localStorage` para que el usuario no pierda su progreso.

---

## 4. Lógica — sistema de datos

### Estructura de datos

Ubicación: `src/features/document-checklist/lib/get-document-checklist.ts` y `src/features/document-checklist/data/`

```typescript
export type DocumentoChecklist = {
  id: string;
  nombre: string;
  descripcion: string;
  comoObtenerlo: string;
  plazoDias: number | null;     // tiempo estimado para obtenerlo
  costeEstimado: { min: number; max: number } | null;
  organismo: string;
  enlaceOficial: string | null;
  obligatorio: boolean;
  aplicaSi: (ctx: ChecklistContext) => boolean;
  caducidad: string | null;     // "10 años" para CEE, "indefinido" para nota simple
};

export type ChecklistContext = {
  ccaa: CCAA;
  tipoInmueble: TipoInmueble;
  antiguedadAnios: number;
  tieneHipoteca: boolean;
};

export function getChecklistFor(ctx: ChecklistContext): DocumentoChecklist[];
```

El usuario marca cada documento como `obtenido | pendiente | no-aplica`. Estado en `localStorage` (no en BD — sin auth en Tier 1).

### Documentos comunes (todas las CCAA)

| ID | Documento | Organismo | Coste | Plazo |
|---|---|---|---|---|
| `nota-simple` | Nota simple registral actualizada | Registro de la Propiedad | 9–15 € | Inmediato (online) |
| `escritura-compra` | Escritura pública de la propiedad actual | Notaría que la otorgó | Copia: 15–30 € | 2–5 días |
| `ibi-ultimo` | Último recibo del IBI | Ayuntamiento / domiciliación | 0 € | Inmediato |
| `cee` | Certificado de Eficiencia Energética | Técnico habilitado | 80–250 € | 3–10 días |
| `referencia-catastral` | Ficha catastral / consulta descriptiva | Sede del Catastro | 0 € | Inmediato |
| `dni-vendedor` | DNI / NIE en vigor | — | 0 € | — |
| `certificado-comunidad` | Certificado al corriente de pagos en la comunidad | Administrador de fincas o secretario | 0–60 € | 1–7 días |
| `estatutos-comunidad` | Estatutos de la comunidad de propietarios | Comunidad / administrador | 0 € | 1–3 días |
| `actas-junta` | Últimas actas de junta de propietarios (informativo) | Comunidad | 0 € | 1–3 días |

### Documentos condicionales

| ID | Documento | Aplica si | Notas |
|---|---|---|---|
| `cedula-habitabilidad` | Cédula de habitabilidad | `ccaa ∈ [Cataluña, Baleares, Valencia, Asturias, Cantabria, La Rioja, Murcia, Navarra]` | Vigencia 15–25 años según CCAA |
| `licencia-primera-ocupacion` | Licencia de primera ocupación | Construcción reciente (< 10 años) | Algunos municipios la exigen |
| `ite-iee` | Inspección Técnica de Edificios (ITE/IEE) | `antiguedadAnios > umbral_municipal` | Madrid: ≥45 años; Cataluña: 45+ obligatorio; Andalucía: 50+. Verificar ordenanza. |
| `certificado-saldo-hipoteca` | Certificado de saldo pendiente de hipoteca | `tieneHipoteca === true` | Lo emite el banco — gratis o ~30 € |
| `nota-simple-cancelacion` | Cancelación registral si la hipoteca ya está pagada | Hipoteca pagada pero sin cancelar | ~1.000–1.500 € |
| `certificado-no-deuda-suministros` | Certificados de no deuda en agua, luz, gas (recomendado) | `tipoInmueble ∈ [piso, chalet]` | Opcional pero genera confianza |
| `seguro-decenal` | Seguro decenal | Construcción nueva (< 10 años) y vendedor = promotor | Caso poco frecuente |

### Datos por CCAA

🔴 La cédula de habitabilidad y los umbrales de ITE/IEE varían por CCAA y por municipio. Crear una tabla `src/features/document-checklist/data/ccaa-data.ts` con la información específica. El agente debe documentar fuente de cada dato (BOE, BOJA, BOCM, etc.).

---

## 5. Outputs

### Vista principal — checklist interactivo

Lista agrupada por categoría:

```
🏛️ Identidad y propiedad
  □ Nota simple registral             [Obtener]  [No aplica]
  □ Escritura de compra
  □ DNI en vigor
  ✓ Referencia catastral

📊 Información económica
  □ Último recibo IBI
  □ Certificado al corriente comunidad

⚡ Energía y habitabilidad
  □ Certificado de Eficiencia Energética    🔴 80–250 € · 3–10 días
  □ Cédula de habitabilidad (Cataluña)      🔴 obligatorio en tu CCAA

💰 Financiación (si tiene hipoteca)
  □ Certificado de saldo
  □ Cancelación registral (si aplica)
```

Cada documento expandible con: descripción, cómo obtenerlo, plazo, coste, enlace oficial.

### Resumen lateral / sticky en mobile

```
Progreso: 3 de 12 documentos
Coste total estimado: 280–520 €
Tiempo estimado: 7–15 días
[Botón: Recibir checklist completo en PDF]
```

### Mensaje contextual

- Si progreso = 100% → "Tienes toda la documentación. Estás listo para firmar."
- Si quedan documentos críticos sin marcar → "Te faltan X documentos imprescindibles."

---

## 6. Edge cases

| Caso | Comportamiento |
|---|---|
| Usuario cambia de CCAA con progreso guardado | Mantener marcas de documentos comunes, recalcular condicionales |
| `antiguedadAnios = 0` (vivienda nueva) | Añadir licencia de primera ocupación, eliminar ITE/IEE |
| `tipoInmueble = 'terreno'` | Quitar documentos de comunidad y CEE, añadir cédula urbanística |
| Usuario sin localStorage habilitado | Mostrar warning, ofrecer envío del checklist por email |

---

## 7. Disclaimer legal

> *"Este checklist es orientativo y se basa en la normativa estatal y autonómica vigente. Algunos municipios pueden exigir documentación adicional (licencias urbanísticas, certificados de comunidad específicos). Verifica siempre los requisitos exactos con tu notario, registrador o asesor antes de la firma."*

---

## 8. Email capture post-resultado

| Elemento | Valor |
|---|---|
| Título | `Te enviamos el checklist completo en PDF con plazos y costes por CCAA` |
| CTA botón | `Enviarme el PDF personalizado` |
| Valor entregado | PDF generado con la CCAA del usuario, sus marcas de progreso, instrucciones detalladas, enlaces oficiales |
| Source | `T4` |
| Campo extra capturado | `ccaa` (en columna `subscribers.ccaa`) |
| Email de bienvenida | Asunto: "Tu checklist personalizado para vender en [CCAA]" + secuencia de seguimiento (consejos por documento durante 5 semanas) |

🌟 **Esta tool tiene el mayor potencial de captura de email del Tier 1** — el usuario quiere guardar su progreso, no solo ver un cálculo.

---

## 9. Cross-link

> ¿Sabes ya cuánto pagarás de impuestos por la venta? → `/herramientas/calculadora-irpf-venta-piso` y `/herramientas/calculadora-plusvalia-municipal`

---

## 10. Artículo companion

| Elemento | Valor |
|---|---|
| Slug | `/blog/documentos-para-vender-piso-guia-completa` |
| Título | `Documentos para vender un piso: guía completa por comunidad autónoma (2026)` |
| Keyword | `documentos vender piso` |
| `tool:` | `checklist-documentacion-venta-piso` |
| Estado | ⬜ **Entre los 4 artículos de lanzamiento (D-006)** |

Secundario: `/blog/certificado-energetico-venta-piso` (link a la sección CEE del checklist).

---

## 11. FAQ schema

| # | Pregunta | Respuesta |
|---|---|---|
| 1 | ¿Qué documentos necesito para vender un piso en España? | Como mínimo: nota simple, escritura, último IBI, certificado al corriente de comunidad, certificado de eficiencia energética (CEE), DNI y, si la CCAA lo exige, cédula de habitabilidad. |
| 2 | ¿En qué CCAA es obligatoria la cédula de habitabilidad? | Cataluña, Baleares, Valencia, Asturias, Cantabria, La Rioja, Murcia y Navarra. En el resto, no es obligatoria pero algunos compradores la solicitan. |
| 3 | ¿Cuánto cuesta el certificado de eficiencia energética? | Entre 80 € y 250 € según la superficie del inmueble y la zona. Es obligatorio en toda España y tiene una vigencia de 10 años. |
| 4 | ¿Cuándo es obligatoria la ITE / IEE? | Para edificios de más de 45 años (orientativo, varía por municipio). En Madrid, Barcelona y otras grandes ciudades es exigible. |
| 5 | ¿Qué pasa si vendo con la hipoteca sin cancelar? | Puedes cancelarla con el dinero de la venta en el mismo acto notarial. Necesitarás el certificado de saldo del banco. |
| 6 | ¿Cuánto tarda obtener todos los documentos? | Entre 7 y 15 días si se solicitan en paralelo. La nota simple es inmediata; el CEE 3–10 días; el certificado de comunidad 1–7 días. |
| 7 | ¿Qué documentos son responsabilidad del comprador? | El comprador suele encargarse de su financiación, ITP/IVA, y nuevas escrituras. El vendedor aporta la documentación del inmueble. |

---

## 12. Definition of done

- [ ] Feature module `src/features/document-checklist/` completo (components/, lib/, data/, schemas/, content/, types.ts, index.ts)
- [ ] `src/features/document-checklist/lib/get-document-checklist.ts` con la función `getDocumentChecklist`
- [ ] `src/features/document-checklist/data/ccaa-data.ts` con los datos específicos por CCAA (cédula, ITE/IEE, etc.) y fuentes
- [ ] Tests unitarios en `get-document-checklist.test.ts`: cobertura de combinaciones CCAA × propertyType × age × hasMortgage (mínimo 20 casos)
- [ ] `src/app/(marketing)/herramientas/checklist-documentacion-venta-piso/page.tsx` thin
- [ ] Persistencia en `localStorage` con clave versionada (`vtm-checklist-v1`)
- [ ] Componente `<DocumentCard>` reutilizable con estados (obtained / pending / not-applicable)
- [ ] `src/features/document-checklist/content/seo.ts` con metadata
- [ ] `src/features/document-checklist/content/faq.ts` con preguntas
- [ ] Disclaimer
- [ ] Email capture con `source: 'T4'` y `ccaa` capturado
- [ ] Cross-link a T2 y T3
- [ ] FAQ + JSON-LD `FAQPage` y `HowTo`
- [ ] OG image en `public/og/document-checklist.png`
- [ ] LCP < 2,5s
- [ ] Sitemap
- [ ] **Datos por CCAA verificados con BOE / boletines autonómicos**
- [ ] Disclaimer revisado por abogado 🔴
- [ ] Artículo companion publicado
- [ ] Test e2e: cambiar CCAA → ver documentos cambiar → marcar uno → recargar → progreso conservado

---

*→ Guardado en: `docs/product/tools/T4-checklist-documentacion-venta-piso.md`*
