# Módulo 2 · Modelo de ingresos y unit economics

> Output del Asesor Financiero Inmobiliario · Fase 4 (Modelo de negocio).
> Evalúa las opciones de monetización y la sostenibilidad económica por unidad.
> → Input directo para Módulo 3 (Estructura de costes) y Módulo 5 (Veredicto).

---

## 2.1 Opciones de monetización — Análisis comparativo

Existen cuatro arquetipos de modelo de ingresos para un portal inmobiliario de particulares. Se analizan con sus precedentes reales.

### Opción A — Tarifa fija de publicación (upfront)

El vendedor paga al publicar su inmueble, independientemente del resultado.

| Variable | Dato |
|---|---|
| Rango de tarifa viable | 490–1.990 € |
| Referente | Housell (~1.990 €), Purplebricks UK (~1.200 £) |
| Cash flow | Inmediato |
| Alineación con el vendedor | Baja — paga sin garantía de resultado |

**Fortaleza:** Flujo de caja predecible desde el día 1.

🔴 **Debilidad crítica:** Purplebricks murió por este modelo. El vendedor paga en el momento de mayor ansiedad (antes de saber si venderá) y lo percibe como un riesgo. En un mercado conservador como el español, la barrera psicológica del pago anticipado es el principal inhibidor de conversión. Solo funciona si la marca tiene credibilidad consolidada. **Para un portal sin marca, es el modelo de mayor riesgo de adopción.**

---

### Opción B — Tarifa de éxito (success fee)

El vendedor paga solo si consigue vender. El portal cobra al cierre.

| Variable | Dato |
|---|---|
| Rango de tarifa viable | 1.500–3.500 € (fija) o 0,5–1,5% del precio de venta |
| Referente | Sin referente puro en España. Parcialmente inspirado en Homelight (referral model) |
| Cash flow | Diferido — solo al cierre (60–180 días después de publicación) |
| Alineación con el vendedor | Muy alta — el portal gana si y solo si el vendedor vende |

**Fortaleza:** Es la propuesta más honesta para el vendedor. Elimina la objeción "pago y no vendo". Refuerza el argumento de que somos el aliado del vendedor, no un intermediario.

🟡 **Complejidades operativas:**
- Verificación del cierre: el portal no puede saber automáticamente si se produjo la escrituración. Requiere buena fe del vendedor o integración con notaría (complejo técnicamente). El riesgo de impago es real.
- Cash flow: si el DOM medio es 90 días, los ingresos llegan con ese retardo. Necesita financiación para cubrir el gap operativo.
- Escalabilidad: en escenario de bajo volumen (año 1), la base de caja es frágil.

🟢 **Por qué es el modelo más diferencial:** Ningún portal español lo ofrece hoy. Es el argumento de venta más potente posible frente a agencias ("solo pago si vendo y pago mucho menos que con una agencia").

---

### Opción C — Freemium con servicios adyacentes

Publicación básica gratuita. Ingresos por servicios de valor añadido.

| Fuente de ingreso | Mecanismo | Ticket estimado |
|---|---|---|
| Destacado / visibilidad premium | Pago por posicionamiento mejorado en el portal | 29–99 €/semana |
| Fotografía profesional | Servicio propio o afiliado (fotógrafo homologado) | 150–300 € |
| Certificado Energético afiliado | Referral a técnico CEE. Comisión ~20-30% | 25–45 € de comisión |
| Cédula de Habitabilidad afiliado | Referral a técnico habilitado | 20–40 € de comisión |
| Hipoteca afiliada (comprador) | Referral a broker hipotecario. Comisión ~0,5–1% del capital | 800–2.000 € por hipoteca |
| Seguro de hogar | Referral a aseguradora. Comisión ~15–25% de prima anual | 80–150 € por póliza |
| Abogado para arras/escritura | Referral. Comisión ~10–15% del honorario | 60–120 € de comisión |
| Informe de valoración premium | AVM + informe descargable firmado | 19–49 € |

**Fortaleza:** Modelo escalable. El coste marginal de cada servicio adyacente es cercano a cero (es referral puro). Housfy construyó su rentabilidad precisamente diversificando hacia hipotecas.

🟡 **Debilidad:** Requiere construir red de afiliados antes de monetizar. En año 1, el ingreso por afiliados es mínimo hasta consolidar volumen. El canal de hipotecas es el más potente pero también el más lento de desarrollar (requiere acuerdos con bancos o brokers).

---

### Opción D — Suscripción mensual

El vendedor paga una cuota mensual mientras su anuncio está activo.

| Variable | Dato |
|---|---|
| Rango viable | 29–99 €/mes |
| DOM medio estimado | 90–120 días → 3–4 meses de suscripción |
| LTV por operación | 87–396 € |
| Referente | Sin referente relevante en inmobiliario español |

🔴 **Modelo inadecuado para este proyecto.** El vendedor no quiere una relación mensual recurrente; quiere vender y desaparecer. La suscripción genera ansiedad sobre el tiempo y conflicto si no vende rápido ("estoy pagando cada mes y no consigo compradores"). Descartado como modelo primario.

---

## 2.2 Modelo recomendado — Freemium + Success Fee híbrido

Tras analizar los benchmarks internacionales y las condiciones del mercado español, la recomendación es un **modelo híbrido en dos capas**:

### Capa 1 — Publicación gratuita (captación de volumen)

El vendedor publica gratis. Sin barrera de entrada. El objetivo es maximizar el número de anuncios activos para construir la base de compradores y tracción SEO.

- Anuncio en el portal SINAGENCIAS.ES: **gratuito**
- Herramientas básicas incluidas: Asistente de Anuncio (IA), Valorador de Mercado, Checklist Documentación, Panel de Seguimiento básico

### Capa 2 — Plan Premium (conversión a ingresos)

| Plan | Precio | Contenido |
|---|---|---|
| **Esencial** | Gratuito | Publicación + herramientas básicas |
| **Profesional** | 199 € (pago único) | Publicación destacada + Sala de Visitas completa + Panel avanzado + Generador de Arras |
| **Completo** | 490 € (pago único) | Todo Profesional + publicación en Idealista/Fotocasa vía API + Expediente Digital completo + soporte prioritario |
| **Éxito** | 0 € upfront + 990 € al cierre | Solo se paga si se produce la venta. Incluye todo el plan Completo + acompañamiento en negociación |

🟢 **Lógica del modelo:** El plan gratuito alimenta el volumen. El plan Profesional/Completo captura al vendedor motivado que valora las herramientas. El plan Éxito es la propuesta premium diferencial sin riesgo para el vendedor.

### Capa 3 — Servicios adyacentes (el motor de rentabilidad a largo plazo)

A medida que el volumen crece, los servicios adyacentes se convierten en la fuente de ingresos más importante y de mayor margen:

| Servicio | Ingreso estimado/operación | Margen |
|---|---|---|
| Referral hipoteca comprador | 800–2.000 € | ~90% (es comisión pura) |
| Referral seguro hogar comprador | 80–150 € | ~90% |
| Certificado energético vendedor | 25–45 € | ~85% |
| Fotografía profesional | 30–60 € (referral) | ~80% |
| Abogado revisión arras | 60–120 € | ~85% |
| **Total servicios por operación (estimado)** | **200–600 €** | ~85% |

🟢 **El referral hipotecario es el activo de mayor valor.** En España, ~75% de las compras se financian con hipoteca. Si el portal facilita la conexión comprador-banco y cobra una comisión de referral, este canal solo puede igualar o superar los ingresos de la tarifa de publicación. Es el modelo que convirtió a Housfy en rentable.

---

## 2.3 Unit economics

### Escenario base — Ingreso por operación (mix de planes)

Asumiendo distribución de planes estimada en año 2-3 (cuando hay volumen y confianza de marca):

| Plan | % operaciones | Ingreso directo | Servicios adyacentes | Total por op. |
|---|---|---|---|---|
| Esencial (gratuito) | 40% | 0 € | 150 € | 150 € |
| Profesional | 25% | 199 € | 200 € | 399 € |
| Completo | 20% | 490 € | 250 € | 740 € |
| Éxito | 15% | 990 € | 300 € | 1.290 € |
| **Media ponderada** | 100% | **~280 €** | **~210 €** | **~490 €** |

🟡 En año 1 (sin red de afiliados consolidada), el ingreso por operación es más bajo: ~150-250€. La cifra de 490€ es la meta del año 3.

### CAC — Coste de Adquisición de Cliente

| Canal | CAC estimado | Justificación |
|---|---|---|
| SEO orgánico (contenido + blog) | 20–60 € | Coste de producción de contenido amortizado entre conversiones |
| Referidos orgánicos (NPS > 50) | 0–15 € | Coste del programa de referidos, no de adquisición pagada |
| Social media orgánico | 30–80 € | Equipo + herramientas |
| Google Ads (SEM) | 80–200 € | CPC de palabras clave inmobiliarias (~1,5–4 €/clic, ~3–5% conversión) |
| Colaboración con notarías/abogados | 40–100 € | Acuerdos de referral inverso |
| **CAC medio objetivo año 1–2** | **~50–80 €** | Mayoría de tráfico via SEO |
| **CAC medio objetivo año 3+** | **~30–50 €** | SEO consolidado, efecto referido |

🟢 **La viabilidad financiera del modelo depende de mantener el CAC por debajo de 100€.** Esto solo es posible con una estrategia de SEO de contenidos como canal primario. Si el canal primario es SEM (200€ CAC) con un ingreso medio de 490€ por operación, el ratio LTV/CAC apenas alcanza 2,4x, que es insuficiente.

### LTV — Lifetime Value

| Componente | Valor | Nota |
|---|---|---|
| Ingreso primera operación (año 2-3) | ~490 € | Tarifa + servicios adyacentes |
| Referidos generados (NPS alto → 0,3 referidos/cliente) | ~147 € | 0,3 × 490€ |
| Segunda operación (recompra en 7-10 años) | ~50 € valor presente | Baja porque el ciclo es largo |
| **LTV total** | **~600–650 €** | Escenario base año 3 |

🔴 **El LTV bajo es el riesgo estructural del modelo.** Una transacción cada 7-10 años significa que no hay recurrencia. El LTV en un modelo pure-play de publicación (~490€) es bajo comparado con otros marketplaces. Por eso los servicios adyacentes y el referido hipotecario son críticos: cada referral de hipoteca añade 800-2.000€ al LTV de esa operación, multiplicando el valor por 2-3x.

### Ratio LTV/CAC

| Escenario | LTV | CAC | LTV/CAC | Estado |
|---|---|---|---|---|
| Año 1 (SEO incipiente) | ~250 € | ~70 € | ~3,6x | 🟢 Saludable |
| Año 1 (SEM intensivo) | ~250 € | ~180 € | ~1,4x | 🔴 Insostenible |
| Año 2-3 (mix SEO + servicios) | ~490 € | ~55 € | ~8,9x | 🟢 Excelente |
| Año 3 (hipotecas activadas) | ~900 € | ~45 € | ~20x | 🟢 Escala |

**El modelo es financieramente viable si y solo si el SEO es el canal de adquisición principal en los primeros 2 años.** Un modelo dependiente de paid acquisition en fase early-stage destruye el ratio LTV/CAC.

### Payback period

| Escenario | CAC | LTV/mes | Payback |
|---|---|---|---|
| Base (SEO) | 60 € | 490 € (una vez) | Inmediato |
| Adverso (SEM) | 180 € | 250 € (año 1) | Nunca si no hay retención |

En un modelo de pago único (no suscripción), el payback es técnicamente inmediato si el ingreso por operación supera el CAC. **La clave es que el primer ingreso cubra el CAC con margen positivo.** Si CAC = 60€ e ingreso = 250€, el margen por cliente en año 1 es 190€. No es suficiente para ser rentable como empresa (hay costes fijos), pero la unidad económica es positiva desde el día 1.

---

## 2.4 Proyección de ingresos a 3 años

| Métrica | Año 1 | Año 2 | Año 3 |
|---|---|---|---|
| Operaciones/mes (base) | 20 | 70 | 180 |
| Operaciones totales/año | 240 | 840 | 2.160 |
| Ingreso medio/operación | 200 € | 350 € | 490 € |
| **Ingresos totales** | **48.000 €** | **294.000 €** | **1.058.400 €** |
| Ingresos servicios adyacentes adicionales | 10.000 € | 60.000 € | 250.000 € |
| **Ingresos totales combinados** | **~58.000 €** | **~354.000 €** | **~1.308.000 €** |

| Escenario | Año 1 | Año 2 | Año 3 |
|---|---|---|---|
| Conservador | ~30.000 € | ~180.000 € | ~700.000 € |
| Base | ~58.000 € | ~354.000 € | ~1.300.000 € |
| Optimista | ~100.000 € | ~600.000 € | ~2.000.000 € |

🔴 **Ningún escenario alcanza la rentabilidad en los primeros 3 años.** Los costes operativos anuales (equipo, infraestructura, marketing) se sitúan en 300.000–500.000€/año (Módulo 3). El break-even requiere ~250-350 operaciones/mes con ingreso medio de 490€, que en el escenario base se alcanza en año 4-5.

---

## Veredicto parcial — Módulo 2

🟢 El modelo de ingresos híbrido (freemium + success fee + adyacentes) es el más sostenible para este mercado. Alinea los incentivos del portal con los del vendedor y evita el error de Purplebricks.

🔴 El LTV estructuralmente bajo (una transacción por cliente cada 7-10 años) hace que el modelo solo sea rentable si: (1) el CAC se mantiene bajo vía SEO orgánico y (2) los servicios adyacentes — especialmente hipotecas — aportan ingresos adicionales por operación. Sin estos dos pilares, el modelo no escala a rentabilidad.

🟡 **Decisión crítica pendiente (Q-002):** La elección entre cobro upfront (plan Profesional/Completo) vs. success fee puro tiene implicaciones directas en el flujo de caja. Se recomienda lanzar con plan Profesional (upfront) para generar caja en año 1, y añadir el plan Éxito cuando la marca tenga suficiente credibilidad para soportar el riesgo de cobro diferido.

---

*→ Guardado en: `docs/business/model/income-model.md`*
*✅ Módulo 2 completado. Input directo para Módulo 3 (Estructura de costes).*
