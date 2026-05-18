# Módulo 5 · Veredicto de viabilidad y recomendaciones estratégicas

> Output del Asesor Financiero Inmobiliario · Fase 4 (Modelo de negocio).
> Síntesis de los Módulos 1–4. Veredicto definitivo y hoja de ruta financiera recomendada.
> Este documento debe leerse junto a los módulos anteriores. No sustituye al due diligence profesional.

---

> 📌 **Contexto de uso:** Este documento analiza la viabilidad del portal completo (Tier 3 / MVP tradicional). La estrategia de entrada activa es **tools-first** — ver `cost-free-structure.md`. Este veredicto aplica cuando se decida escalar al portal completo, no para la fase actual.

> ⚠️ **Aviso de limitación:** Este análisis es orientativo y se basa en datos públicos disponibles del mercado inmobiliario español, benchmarks de proptech europeos y estimaciones justificadas. No sustituye a un due diligence financiero profesional ni a la validación con datos reales del mercado. Todas las proyecciones deben considerarse como rangos de trabajo, no como previsiones definitivas.

---

## 5.1 Scorecard de viabilidad

| Dimensión | Criterio evaluado | Puntuación | Señal |
|---|---|---|---|
| **1. Oportunidad de mercado** | TAM suficiente + tendencia favorable + validación por benchmarks | **8 / 10** | 🟢 |
| **2. Modelo de ingresos** | Claridad de monetización + unit economics positivos (LTV/CAC>3 vía SEO) | **7 / 10** | 🟢 |
| **3. Viabilidad del MVP** | Capital necesario accesible + tiempo de desarrollo razonable | **7 / 10** | 🟢 |
| **4. Ventaja competitiva** | Diferenciación vs. portales generalistas + moat defendible | **6 / 10** | 🟡 |
| **5. Riesgos mitigables** | Top 5 riesgos críticos con plan de acción definido | **6 / 10** | 🟡 |
| **6. Dependencia de capital externo** | Break-even posible con ≤500K€ en escenario base | **6 / 10** | 🟡 |
| **7. Sostenibilidad a largo plazo** | LTV estructuralmente bajo; depende de servicios adyacentes | **5 / 10** | 🟡 |
| **8. Equipo y capacidad de ejecución** | No evaluable sin información del equipo fundador | **— / 10** | ⬜ |
| **PUNTUACIÓN MEDIA (sin equipo)** | | **6,4 / 10** | 🟡 |

**Interpretación:** Una puntuación de 6,4/10 indica un proyecto con fundamentos sólidos pero con riesgos de ejecución significativos. No es ni un "sí fácil" ni un "no claro". Es un proyecto que puede funcionar bien o muy bien si se ejecuta disciplinadamente, y que puede fracasar si se subestiman los plazos, el capital necesario o la dificultad del cold start.

---

## 5.2 Recomendación de Go / No-Go

### Veredicto: **GO CONDICIONAL** ✅

El proyecto tiene fundamentos suficientes para avanzar. El mercado es real, la necesidad es validada y el modelo de ingresos es coherente. No hay ningún "deal-breaker" que recomiende abandonar la idea en este punto.

**Sin embargo, el Go está condicionado a tres prerequisitos no negociables:**

---

**Condición 1 — El cold start debe resolverse antes del lanzamiento público**

El portal no puede lanzarse como destino cerrado de compradores. Sin compradores reales, el vendedor no consigue resultados y el producto no tiene valor. La solución es la integración con Idealista/Fotocasa vía API desde el plan Completo. Esto debe estar resuelto técnica y comercialmente antes de la apertura pública.

🔴 **Si esta condición no se cumple, el proyecto no debe lanzarse.**

---

**Condición 2 — El SEO de contenidos debe iniciarse 6 meses antes del lanzamiento**

La viabilidad financiera del modelo depende de un CAC bajo vía SEO orgánico. El SEO tarda 6-12 meses en producir resultados. Si se empieza a publicar contenido el día del lanzamiento del portal, el primer año no habrá tráfico orgánico significativo y el CAC real sera 3-5 veces superior al del modelo financiero.

🔴 **La producción de contenidos debe comenzar en la fase de desarrollo del MVP, no después.**

---

**Condición 3 — Asegurar 18 meses de runway antes de lanzar**

El análisis de costes muestra que el escenario conservador requiere ~430.000€ hasta break-even. Sin garantizar ese capital antes de lanzar (entre capital propio, ENISA y/o ronda pre-seed), el riesgo de quedarse sin caja antes de alcanzar tracción es alto.

🟡 **El runway mínimo recomendado antes de lanzar MVP: 18 meses × coste mensual estimado.**

---

## 5.3 Las 5 decisiones financieras más importantes antes de arrancar

Estas son las decisiones que el fundador debe tomar antes de escribir una línea de código o gastar el primer euro. Cada una tiene implicaciones directas en el modelo financiero.

---

### Decisión 1 — Modelo de monetización: ¿upfront, success fee o híbrido?

**La pregunta:** ¿Cobra el portal al publicar (upfront) o solo si se produce la venta (success fee)?

**Por qué es crítica:** Afecta directamente al flujo de caja, a la tasa de conversión y al posicionamiento. El upfront genera caja inmediata pero tiene barrera de adopción. El success fee es el argumento más potente pero tiene riesgo de impago y retrasa la caja.

**Recomendación:** Lanzar con un plan Profesional de pago upfront (199-490€) como principal fuente de ingresos en año 1, para generar caja real. Añadir el plan Éxito (success fee) una vez que la marca tenga suficiente credibilidad y se hayan resuelto los mecanismos de verificación de cierre. No lanzar con success fee exclusivo — es demasiado arriesgado para la caja en fase early.

🟡 Corresponde a la pregunta abierta Q-002 en `docs/memory/decisions.md`.

---

### Decisión 2 — Lanzamiento local vs. nacional desde el día 1

**La pregunta:** ¿Se lanza en Madrid y Barcelona únicamente, o en toda España desde el primer día?

**Por qué es crítica:** Lanzar nacional requiere más capital (más contenido SEO por mercados locales, más acuerdos con profesionales afiliados por CCAA, más complejidad de soporte), pero limitar a 2 ciudades reduce el TAM potencial de año 1-2.

**Recomendación:** Lanzar nacional en distribución de anuncios (el vendedor de Sevilla puede publicar desde el día 1), pero focalizar los esfuerzos de SEO local y afiliados en Madrid y Barcelona inicialmente. Esto maximiza la eficiencia del gasto de marketing sin impedir el crecimiento orgánico en otras geografías.

**Argumento cuantitativo:** Madrid y Barcelona concentran ~35-40% de las transacciones nacionales. Conquistar esas dos ciudades con profundidad (posición top-3 en SEO local) aporta más valor que una presencia superficial en 50 provincias.

🟡 Corresponde a la pregunta abierta Q-001 en `docs/memory/decisions.md`.

---

### Decisión 3 — Ruta de financiación: ¿bootstrapped o inversor desde el inicio?

**La pregunta:** ¿Se arranca con capital propio (+ ENISA) o se busca un inversor seed antes de tener MVP?

**Por qué es crítica:** Buscar inversión antes de tener datos reales obliga a aceptar valoraciones bajas y condiciones menos favorables. Pero bootstrappear sin suficiente capital propio puede llevar a cortar el proyecto en el peor momento.

**Recomendación:** Bootstrapping hasta MVP + primeras 10-15 operaciones reales (~6-9 meses después del lanzamiento). Con esos datos, buscar ronda seed. El único argumento para buscar inversión antes del MVP es si el equipo no tiene el capital propio suficiente para llegar a ese hito (en cuyo caso, ENISA es la primera alternativa, no un inversor).

**Regla práctica:** Si tienes menos de 50.000€ disponibles y no tienes co-founder técnico, no puedes arrancar. Resolver eso antes de continuar.

---

### Decisión 4 — ¿Co-founder técnico o desarrollo externalizado?

**La pregunta:** ¿El CTO es co-fundador con equity o se contrata un equipo de desarrollo externo?

**Por qué es crítica:** El coste del MVP varía de 65K€ (con co-founder técnico) a 240K€ (con desarrollo completamente externalizado). La diferencia de 175K€ puede ser la diferencia entre poder arrancar o no. Además, un equipo externo tiene menos compromiso con el producto a largo plazo.

**Recomendación:** Buscar activamente un co-fundador técnico antes de arrancar. Un CTO comprometido con equity equivale a 80.000-120.000€ de capital en el primer año. El tiempo invertido en encontrarlo (2-4 meses) es el mejor retorno sobre la inversión posible en esta fase.

**Si no existe co-fundador técnico:** Desarrollar el MVP con una agencia de desarrollo local de confianza (con buenas referencias en proptech o marketplace) y presupuesto acotado de 100-150K€. Nunca externalizar a offshore sin supervisión técnica propia — el riesgo de retrasos y calidad es demasiado alto para un MVP.

---

### Decisión 5 — ¿Cuándo pivotar si los KPIs no se cumplen?

**La pregunta:** ¿Cuáles son los KPIs que, si no se alcanzan, indican que el modelo necesita revisión antes de seguir quemando caja?

**Por qué es crítica:** No tener criterios de pivote definidos con antelación lleva a continuar invirtiendo en algo que no está funcionando por inercia o ego, no por datos.

**KPIs de alerta — semáforo de decisión:**

| KPI | Señal verde | Señal amarilla | Señal roja |
|---|---|---|---|
| Operaciones/mes a los 6 meses del lanzamiento | >20 | 10–20 | <10 |
| Tasa de conversión gratuito→pago | >25% | 15–25% | <15% |
| CAC real (todos los canales) | <80 € | 80–150 € | >150 € |
| LTV/CAC | >3x | 2–3x | <2x |
| DOM promedio de inmuebles publicados | <90 días | 90–150 días | >150 días |
| NPS de vendedores | >50 | 30–50 | <30 |

**Regla de pivote:** Si 3 o más KPIs están en señal roja a los 12 meses del lanzamiento, el modelo necesita revisión antes de continuar quemando caja. Las revisiones posibles son: cambio en el modelo de precios, cambio en el segmento objetivo (geografía, tipo de inmueble), o pivote del modelo de ingresos hacia puramente adyacentes (sin tarifa de publicación).

---

## 5.4 Hoja de ruta financiera recomendada

```
ETAPA 0 — Preparación (Ahora → Q3 2026)
────────────────────────────────────────
Objetivo: Tener todo listo para arrancar el MVP sin sorpresas.
Hitos:
  ✓ Constitución SL
  ✓ Solicitud ENISA
  ✓ Co-founder técnico confirmado (o plan B de desarrollo)
  ✓ 30-50 artículos SEO publicados en blog pre-lanzamiento
  ✓ Acuerdo comercial con Idealista/Fotocasa para publicación vía API
  ✓ Revisión legal de T&C y política de privacidad
  ✓ Runway asegurado: ≥18 meses
Capital necesario: 30.000–50.000 € (capital propio)
────────────────────────────────────────

ETAPA 1 — MVP y validación (Q3 2026 → Q1 2027, ~6-9 meses)
──────────────────────────────────────────────────────────
Objetivo: Portal funcionando con primeras operaciones reales.
Hitos:
  ✓ MVP lanzado (10 funcionalidades esenciales)
  ✓ 10-30 operaciones/mes al final de la etapa
  ✓ NPS > 40 (vendedores satisfechos que recomiendan)
  ✓ SEO: 10.000+ visitas/mes orgánicas
  ✓ LTV/CAC > 2x en datos reales
  ✓ Modelo de precios validado (tasa de conversión gratuito→pago > 20%)
Capital necesario: 80.000–150.000 € (ENISA + capital propio)
────────────────────────────────────────

ETAPA 2 — Early growth y ronda seed (Q1 2027 → Q4 2027)
─────────────────────────────────────────────────────────
Objetivo: Escalar a 100 operaciones/mes. Activar ingresos adyacentes.
Hitos:
  ✓ Ronda seed cerrada: 200.000–400.000 €
  ✓ 50-100 operaciones/mes
  ✓ Primer acuerdo con broker hipotecario (referral activado)
  ✓ Expansión a las 5 principales ciudades españolas
  ✓ Equipo: 4-5 personas full-time
Capital necesario: 200.000–400.000 € (ronda seed)
────────────────────────────────────────

ETAPA 3 — Escala hacia break-even (2028 → break-even)
───────────────────────────────────────────────────────
Objetivo: 250 operaciones/mes. EBITDA positivo sostenido.
Hitos:
  ✓ 200-300 operaciones/mes
  ✓ Ingresos adyacentes (hipotecas + seguros) >40% del revenue
  ✓ CAC orgánico consolidado < 50 €
  ✓ EBITDA mensual positivo sostenido
  ✓ Inicio de plan de expansión (Portugal, Italia como siguiente mercado)
Break-even estimado: Q2 2028 (optimista) – Q4 2029 (conservador)
```

---

## Resumen ejecutivo del análisis financiero

| Módulo | Conclusión principal |
|---|---|
| **M1 — Mercado** | TAM ~3.160M€/año. Oportunidad grande, validada por Housfy. El riesgo no es el mercado sino la ejecución. |
| **M2 — Ingresos** | Modelo híbrido freemium + success fee + adyacentes. LTV/CAC sano (>3x) solo si el SEO es el canal primario. Los servicios adyacentes (hipotecas) son el motor de rentabilidad a largo plazo. |
| **M3 — Costes** | MVP: 65.000–150.000 € (con co-founder técnico). Total hasta break-even: 350.000–700.000 €. Vía recomendada: capital propio + ENISA → seed de 200-400K€ con datos reales. |
| **M4 — Riesgos** | 5 riesgos críticos identificados. El cold start y el runway son los más urgentes. Todos tienen plan de mitigación definido. |
| **M5 — Veredicto** | **GO CONDICIONAL.** El proyecto es viable con ejecución disciplinada. Las 3 condiciones no negociables son: resolver el cold start, iniciar SEO antes del lanzamiento, y asegurar 18 meses de runway. |

---

> **Este análisis ha sido generado en la fase de conceptualización (pre-MVP) del proyecto SINAGENCIAS.ES.**
> Los números deben revisarse con datos reales tras el lanzamiento. El modelo financiero es una herramienta de toma de decisiones, no una previsión.
> Próxima revisión recomendada: tras los primeros 3 meses de operación real del portal.

---

*→ Guardado en: `docs/business/model/viability-verdict.md`*
*✅ Módulos 2–5 completados. Análisis financiero completo de la Fase 4.*
*Fase 4 · Modelo de negocio — análisis financiero ✅ COMPLETADO.*
