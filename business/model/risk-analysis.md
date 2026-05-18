# Módulo 4 · Análisis de riesgos financieros

> Output del Asesor Financiero Inmobiliario · Fase 4 (Modelo de negocio).
> Identifica y clasifica los riesgos financieros críticos del proyecto SINAGENCIAS.ES.
> → Input directo para Módulo 5 (Veredicto de viabilidad).

---

## Metodología

Cada riesgo se evalúa en dos dimensiones:
- **Probabilidad:** Alta (>60%) / Media (30–60%) / Baja (<30%)
- **Impacto:** Crítico (puede matar el proyecto) / Alto (retrasa la hoja de ruta 6+ meses) / Medio (afecta la rentabilidad pero no la supervivencia) / Bajo (manejable)

La combinación de ambas dimensiones da la **prioridad de mitigación**.

---

## 4.1 Riesgos de mercado

### RM-01 · Adopción más lenta de lo esperado
| Dimensión | Valor |
|---|---|
| Probabilidad | Alta |
| Impacto | Crítico |
| **Prioridad** | **🔴 CRÍTICA** |

**Descripción:** El mercado inmobiliario español es conservador. El vendedor particular tiene décadas de cultura de agencia como referencia. El tiempo medio de adopción de nuevos productos en el sector (referencia: tiempo hasta penetración de Idealista, Fotocasa) fue de 5-8 años. La hipótesis de 20-70 ops/mes en año 1-2 puede ser optimista.

**Indicador de alerta:** Menos de 10 operaciones/mes a los 6 meses del lanzamiento.

**Plan de mitigación:**
- Lanzar con un programa de "casos de éxito verificados" (5-10 vendedores beta que venden en condiciones favorables y documentan el proceso públicamente).
- Añadir garantía de reembolso (si el vendedor no consigue visitas en 60 días con el plan Profesional, se devuelve el pago). Reduce la barrera psicológica.
- Ajustar quemadura de caja mensual si los KPIs de año 1 no se cumplen. Tener un "plan B de supervivencia" a 12 meses con el equipo mínimo (2 personas).

---

### RM-02 · Entrada de Idealista o Fotocasa en el segmento de particulares
| Dimensión | Valor |
|---|---|
| Probabilidad | Media |
| Impacto | Crítico |
| **Prioridad** | **🔴 CRÍTICA** |

**Descripción:** Idealista y Fotocasa tienen la audiencia, la marca, el capital y la distribución para lanzar un producto de particulares en cualquier momento. Si lo hacen con los recursos necesarios, SINAGENCIAS.ES pierde su principal ventaja competitiva (ser el único portal centrado en el particular).

**Análisis del riesgo:** Los portales tienen un conflicto de interés estructural — sus clientes principales son las agencias, que pagarían menos si el portal favorece a los particulares. Esto es una protección real, pero no eterna. Si el mercado de particulares crece suficientemente, pueden crear una marca separada (spin-off) para atacarlo sin canibalizar su negocio principal.

**Plan de mitigación:**
- La velocidad es la defensa principal. Cuanto antes se construya la base de datos de vendedores satisfechos y el contenido SEO rankeado, más caro es para Idealista atacar ese territorio.
- Construir moat en datos: los datos de velocidad de venta, precios de cierre y comportamiento de compradores son un activo que no puede comprarse. Hay que acumularlo desde el primer día.
- Diversificar hacia servicios adyacentes (hipotecas, profesionales) que no son el core de Idealista/Fotocasa.

---

### RM-03 · Contracción del mercado inmobiliario
| Dimensión | Valor |
|---|---|
| Probabilidad | Media |
| Impacto | Alto |
| **Prioridad** | **🟡 ALTA** |

**Descripción:** Una corrección del mercado inmobiliario (caída de transacciones del 20-30%) reduce directamente el número de vendedores potenciales. En la crisis de 2008-2013, las transacciones cayeron de ~900.000 a ~300.000 anuales (-67%). Aunque una corrección de esa magnitud es improbable en 2026-2028, una corrección moderada (-15-20%) es un escenario plausible si suben tipos de interés o se reduce la demanda de compradores extranjeros.

**Plan de mitigación:**
- El modelo funciona mejor en mercados con alta demanda de compradores (que es cuando más valor tiene el portal para el vendedor). En mercado bajista, los vendedores tienen más dificultad de vender solos y pueden preferir agencias. Esto afecta el argumento central del producto.
- Mantener costes fijos bajos para sobrevivir a una contracción de 12-18 meses sin necesidad de capital adicional.

---

### RM-04 · Precio de adquisición de tráfico más alto de lo esperado
| Dimensión | Valor |
|---|---|
| Probabilidad | Alta |
| Impacto | Alto |
| **Prioridad** | **🟡 ALTA** |

**Descripción:** El modelo financiero asume que el CAC via SEO orgánico se mantiene por debajo de 80€. Si el SEO tarda más de lo esperado en posicionar (12-18 meses para ver resultados significativos en keywords competitivas), la alternativa de paid acquisition (SEM) tiene CAC de 150-300€ que destruye la rentabilidad por unidad.

**Plan de mitigación:**
- Iniciar la producción de contenidos SEO antes del lanzamiento del portal (6 meses de antelación). El contenido tiene que estar posicionando mientras el MVP se desarrolla.
- Validar el CAC real con un presupuesto de SEM piloto (500-1.000€) antes de escalar. No asumir los números del modelo sin datos reales.
- Señal de alerta: si el CAC orgánico supera los 120€ a los 12 meses del lanzamiento, revisar el modelo de contenidos.

---

## 4.2 Riesgos de negocio

### RN-01 · El vendedor no paga — problema de conversión a ingresos
| Dimensión | Valor |
|---|---|
| Probabilidad | Alta |
| Impacto | Crítico |
| **Prioridad** | **🔴 CRÍTICA** |

**Descripción:** El modelo freemium asume que el 25-35% de los vendedores convierte a un plan de pago (Profesional o Completo). Si la tasa de conversión real es del 10-15% (más cerca de lo que ocurre en marketplaces freemium generalistas), los ingresos del año 2-3 caen a la mitad del escenario base.

**Datos de referencia:** Los marketplaces freemium tienen tasas de conversión a pago del 2-5% en general. El argumento de que el sector inmobiliario tiene mayor motivación económica justifica una tasa más alta, pero la validación con datos reales es imprescindible.

**Plan de mitigación:**
- Validar la tasa de conversión en beta cerrada antes del lanzamiento público.
- Si la tasa es baja, ajustar el valor percibido de los planes de pago (más herramientas incluidas) o reducir el precio de entrada.
- Señal de alerta: si la tasa de conversión de gratuito a pago es inferior al 15% a los 6 meses, el modelo de precios debe revisarse antes de escalar.

---

### RN-02 · Problema del huevo y la gallina (cold start)
| Dimensión | Valor |
|---|---|
| Probabilidad | Alta |
| Impacto | Crítico |
| **Prioridad** | **🔴 CRÍTICA** |

**Descripción:** Sin compradores activos en el portal, los vendedores no conseguirán visitas ni ofertas. Sin resultados para los vendedores, no habrá casos de éxito ni recomendaciones. Sin recomendaciones, el portal no crece. Es el problema estructural de todos los marketplaces y el que más tiempo y capital consume resolver.

**SINAGENCIAS.ES no puede resolver el problema del cold start publicando solo en su propio portal.** Si los anuncios solo están visibles en la web propia, sin tráfico de compradores, el valor para el vendedor es cero.

**Plan de mitigación:**
- **Crítico desde el MVP:** incluir en el plan Completo la publicación del anuncio en Idealista y Fotocasa via API (portales que sí tienen base de compradores). El vendedor tiene el portal de gestión en SINAGENCIAS.ES pero su anuncio tiene visibilidad en los grandes portales. Esto resuelve el cold start.
- Esto requiere acuerdos comerciales con Idealista/Fotocasa para publicación via API (planes de publicación para empresas). Coste estimado: 50-150€/anuncio publicado en portales externos. Debe incluirse en el coste del plan Completo.
- La publicación en portales externos es la ventaja transitoria hasta que el propio portal tenga tráfico de compradores suficiente.

---

### RN-03 · Impago del success fee — riesgo de cobro diferido
| Dimensión | Valor |
|---|---|
| Probabilidad | Media |
| Impacto | Medio |
| **Prioridad** | **🟡 MEDIA** |

**Descripción:** En el plan Éxito (0€ upfront + 990€ al cierre), el vendedor puede no informar al portal de la venta para evitar el pago. Al tratarse de una transacción entre particulares que se escritura ante notario, el portal no tiene acceso automático a esa información.

**Plan de mitigación:**
- Incluir en los términos de uso una cláusula que obliga al vendedor a notificar el cierre. Si no lo hace, el portal puede auditar el Catastro para detectar cambio de titularidad (la consulta es pública vía INSPIRE/Catastro digital).
- Añadir un sistema de verificación de cierre: el vendedor sube la escritura (o nota simple post-venta) al Expediente Digital para desbloquear una funcionalidad post-venta (calculadora fiscal de IRPF / plusvalía).
- En fase temprana, el volumen de plan Éxito debe ser bajo. Solo escalar cuando haya mecanismos de verificación automatizados.

---

### RN-04 · Responsabilidad legal por fallos en el proceso de venta
| Dimensión | Valor |
|---|---|
| Probabilidad | Baja |
| Impacto | Crítico |
| **Prioridad** | **🟡 ALTA** |

**Descripción:** Si un vendedor sigue las guías del portal, usa las plantillas de arras, y luego la operación falla por una cuestión legal no advertida (cargas ocultas, deuda con comunidad de propietarios, ITE no realizada), el portal puede ser demandado por responsabilidad en el asesoramiento.

🔴 **Implicación legal crítica.** El portal debe estar diseñado como herramienta de asistencia, no como asesor jurídico. Los T&C deben incluir:
- Cláusula de exención de responsabilidad en asesoramiento legal.
- Recomendación explícita de contratar abogado para operaciones complejas.
- Las plantillas de arras son orientativas, no sustituyen el asesoramiento profesional.

**Plan de mitigación:**
- Contratar seguro de responsabilidad civil de empresa (RC profesional) antes del lanzamiento.
- Revisión legal de todos los textos del portal que puedan interpretarse como asesoramiento jurídico.
- Incluir en el flujo de publicación un paso explícito de validación ("He leído y entiendo que este portal no sustituye al asesoramiento de un abogado").

---

## 4.3 Riesgos operativos

### RO-01 · Dependencia de un co-fundador técnico clave
| Dimensión | Valor |
|---|---|
| Probabilidad | Media |
| Impacto | Crítico |
| **Prioridad** | **🔴 CRÍTICA** |

**Descripción:** Si el CTO o co-fundador técnico sale del proyecto en los primeros 12-18 meses, el desarrollo del producto se paraliza. En startups early-stage, la ruptura del equipo fundador es la causa de fracaso más frecuente (junto al cold start).

**Plan de mitigación:**
- Acuerdo de vesting de equity del co-fundador técnico: cliff de 12 meses + vesting a 3-4 años. Protege al proyecto si el co-fundador sale pronto.
- Documentar la arquitectura técnica y las decisiones de producto desde el día 1 (ADRs). Reduce el bus factor.
- Mantener el código en repositorios propios del proyecto, no en cuentas personales.

---

### RO-02 · Brecha de seguridad o pérdida de datos
| Dimensión | Valor |
|---|---|
| Probabilidad | Baja |
| Impacto | Crítico |
| **Prioridad** | **🟡 ALTA** |

**Descripción:** El portal almacenará documentos sensibles (escrituras, DNIs, notas simples, información fiscal). Una brecha de seguridad o pérdida de datos puede generar responsabilidad bajo el RGPD (multas hasta el 4% del volumen de negocio global o 20M€) y destruir la confianza del mercado.

🔴 **Implicación legal y regulatoria crítica.**

**Plan de mitigación:**
- Implementar cifrado en reposo y en tránsito para todos los documentos.
- Minimización de datos: solo almacenar lo estrictamente necesario. El NIF/DNI del vendedor puede validarse sin guardarlo.
- Auditoría de seguridad externa antes del lanzamiento y anualmente.
- Política de retención de datos: eliminar automáticamente documentos 6 meses tras el cierre de la operación (si el usuario no renueva).

---

### RO-03 · Escalabilidad técnica en picos de demanda
| Dimensión | Valor |
|---|---|
| Probabilidad | Baja (año 1-2) / Media (año 3+) | 
| Impacto | Medio |
| **Prioridad** | **🟢 BAJA (a gestionar en año 3)** |

**Descripción:** El mercado inmobiliario tiene estacionalidad marcada (picos en primavera y otoño). Si el portal no está diseñado para escalar horizontalmente, puede caerse en momentos de alta demanda, justo cuando más visibilidad tiene.

**Plan de mitigación:**
- Usar arquitectura cloud serverless o auto-escalable desde el MVP (AWS Lambda, Vercel Edge Functions, Supabase).
- En fases iniciales, el volumen es bajo y no representa riesgo real. Revisitar en año 2 cuando el tráfico crezca.

---

## 4.4 Riesgos de financiación

### RF-01 · Runway insuficiente antes de alcanzar tracción
| Dimensión | Valor |
|---|---|
| Probabilidad | Alta |
| Impacto | Crítico |
| **Prioridad** | **🔴 CRÍTICA** |

**Descripción:** El mayor riesgo de los startups early-stage no es el producto sino quedarse sin dinero antes de alcanzar tracción. Si el MVP tarda 12 meses, y el SEO tarda otros 12 meses en producir tráfico significativo, el fundador necesita 24 meses de runway sin ingresos. Con un quema de ~10.000€/mes (lean team), eso es 240.000€ antes de ver ingresos relevantes.

**Plan de mitigación:**
- No lanzar el MVP hasta tener seguridad de al menos 18 meses de runway calculado de forma conservadora.
- Presupuesto de contingencia: siempre mantener 3 meses de gastos fijos en caja como mínimo.
- Palanca de ajuste: la quemadura de caja se puede reducir drásticamente si los fundadores reducen salarios temporalmente. Modelizar este escenario de emergencia y tener el plan escrito antes de necesitarlo.

---

### RF-02 · No conseguir ronda seed en el momento previsto
| Dimensión | Valor |
|---|---|
| Probabilidad | Media |
| Impacto | Alto |
| **Prioridad** | **🟡 ALTA** |

**Descripción:** El ecosistema VC español para proptech seed es limitado. Una ronda puede tardar 6-12 meses más de lo previsto. Si el capital propio se agota esperando la ronda, el proyecto se interrumpe.

**Plan de mitigación:**
- Preparar el fundraising con 9-12 meses de antelación respecto al momento en que se necesita el dinero.
- ENISA como alternativa no dilutiva mientras se prepara la ronda.
- Tener un plan de "operación supervivencia" que permita al portal funcionar en modo mínimo (2 fundadores, sin empleados) si la ronda no se cierra en el plazo previsto.

---

### RF-03 · Dilución excesiva en fases tempranas
| Dimensión | Valor |
|---|---|
| Probabilidad | Media |
| Impacto | Medio |
| **Prioridad** | **🟡 MEDIA** |

**Descripción:** Si se cede demasiado equity en la ronda seed (>25-30%), las rondas posteriores pueden dejar a los fundadores con un porcentaje tan bajo que desincentiva la continuidad o dificulta atraer talento con opciones.

**Plan de mitigación:**
- Regla general: no ceder más del 20% en seed si la valoración pre-money es inferior a 1M€.
- Considerar convertible notes o SAFE en lugar de equity directo en ronda seed para diferir la valoración hasta tener más tracción.

---

## Matriz de riesgos (probabilidad × impacto)

|  | **Impacto Bajo** | **Impacto Medio** | **Impacto Alto** | **Impacto Crítico** |
|---|---|---|---|---|
| **Alta probabilidad** | — | RO-03 | RM-04 | RM-01 · RN-01 · RN-02 · RF-01 |
| **Media probabilidad** | — | RF-03 | RM-03 · RN-03 · RF-02 | RM-02 · RO-01 |
| **Baja probabilidad** | — | — | RN-04 · RO-02 | — |

---

## Top 5 riesgos críticos con plan de mitigación ejecutivo

| # | Riesgo | Probabilidad | Impacto | Acción prioritaria |
|---|---|---|---|---|
| 1 | **Cold start / problema huevo-gallina** (RN-02) | Alta | Crítico | Integrar publicación en Idealista/Fotocasa desde MVP. Sin esto, el producto no funciona. |
| 2 | **Adopción más lenta de lo esperado** (RM-01) | Alta | Crítico | Iniciar SEO de contenidos 6 meses antes del lanzamiento. Programa beta con 10 casos de éxito verificados. |
| 3 | **El vendedor no convierte a pago** (RN-01) | Alta | Crítico | Validar tasa de conversión en beta cerrada antes de escalar. Tener precio de contingencia más bajo. |
| 4 | **Runway insuficiente** (RF-01) | Alta | Crítico | Tener 18 meses de runway asegurado antes de lanzar MVP. Solicitar ENISA inmediatamente. |
| 5 | **Entrada de Idealista en el segmento** (RM-02) | Media | Crítico | Acumular datos de operaciones y contenido SEO posicionado como moat defensivo. Velocidad es la estrategia. |

---

## Veredicto de bancabilidad

**¿Es el proyecto bancable para un inversor seed?**

| Criterio | Valoración | Señal |
|---|---|---|
| Mercado suficientemente grande | TAM ~3B€, validado por Housfy | 🟢 Sí |
| Modelo de ingresos claro | Freemium + success fee + adyacentes | 🟢 Sí |
| Equipo (a evaluar) | Desconocido sin información del fundador | 🟡 Condicional |
| Riesgos mitigables | Los 5 riesgos críticos tienen plan de acción | 🟢 Sí |
| Competencia con actores capitalizados | Idealista/Fotocasa pueden atacar en cualquier momento | 🔴 Riesgo alto |
| Break-even alcanzable | Sí, en escenario base en 24-36 meses | 🟢 Sí (con condiciones) |
| Requiere capital externo | 200.000-400.000€ para escenario conservador | 🟡 Riesgo de dependencia |

**Veredicto:** El proyecto es **bancable condicionalmente**. Tiene los fundamentos de mercado para justificar una inversión seed. Los riesgos críticos son reales pero mitigables con las acciones descritas. El principal factor de incertidumbre no es el mercado ni el modelo — es la ejecución y el equipo. Un inversor racional pediría ver al menos 3 meses de datos reales de operaciones antes de comprometer capital significativo.

**Recomendación para el fundraising:** No buscar inversión externa antes de tener MVP lanzado y primeras 10-15 operaciones reales. Con esos datos, la valoración y las condiciones de la ronda seed son sustancialmente mejores.

---

*→ Guardado en: `docs/business/model/risk-analysis.md`*
*✅ Módulo 4 completado. Input directo para Módulo 5 (Veredicto final de viabilidad).*
