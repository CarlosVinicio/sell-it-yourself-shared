# F9 · Métricas y KPIs — Tier 1 (herramientas gratuitas)

> Fase 9 ejecutada y adaptada al enfoque tools-first.
> No hay MRR, no hay marketplace, no hay LTV en Tier 1. Las métricas son de tráfico, uso y captación.
> → Configurar Google Search Console, Vercel Analytics y Supabase desde el día 1.

---

## Principio de medición en Tier 1

**Medir poco, medir bien.** En Tier 1 con 0 € de ingresos, el riesgo no es medir mal — es medir demasiado y confundirse con datos sin contexto. Las métricas del Tier 1 responden a una sola pregunta: **¿está llegando el tráfico correcto y está convirtiendo a email?**

Todo lo demás (LTV, CAC, ARPU, marketplace liquidity) es Tier 3.

---

## Dashboard Tier 1 — Las 8 métricas que importan

| # | Métrica | Fórmula | Frecuencia | Herramienta | Umbral verde | Umbral rojo |
|---|---|---|---|---|---|---|
| **M1** | Sesiones orgánicas/mes | Sesiones desde búsqueda orgánica | Semanal | Google Search Console | >2.000 | <500 |
| **M2** | Tasa de completación de herramienta | Usuarios que ven resultado / visitantes de la herramienta | Semanal | Vercel Analytics / PostHog | >60% | <30% |
| **M3** | Tasa de captura de email | Emails capturados / sesiones orgánicas | Semanal | Supabase + GSC | >8% | <3% |
| **M4** | Emails capturados/mes | Count en tabla `subscribers` | Semanal | Supabase | >200 | <50 |
| **M5** | Posición media keyword primaria | Posición media en GSC por herramienta | Mensual | Google Search Console | Top 10 | >30 |
| **M6** | CTR orgánico por herramienta | Clics / impresiones en GSC | Mensual | Google Search Console | >4% | <1,5% |
| **M7** | Herramienta más usada | Sesiones por URL de herramienta | Mensual | Vercel Analytics | — | — |
| **M8** | Open rate newsletter | Aperturas / emails enviados | Por envío | Resend / Brevo | >35% | <20% |

---

## Métricas detalladas

### M1 — Sesiones orgánicas/mes

**Por qué es la métrica más importante:** todo el modelo depende del SEO. Sin tráfico orgánico, no hay nada.

**Cómo medirla:**
- Google Search Console → Rendimiento → Filtro: tipo de búsqueda "Web"
- Desglosar por URL para saber qué herramienta trae más tráfico

**Lectura por herramienta:** la plusvalía municipal (T2) debería ser la primera en posicionar por volumen de keyword (~3.000–6.000 búsq/mes). Si al mes 3 T2 no supera las 200 sesiones orgánicas, revisar el SEO técnico (indexación, structured data, Core Web Vitals).

**Progresión esperada:**
```
Mes 1: 100–500 sesiones (indexación inicial)
Mes 3: 500–2.000 sesiones (primeras posiciones top 20)
Mes 6: 2.000–8.000 sesiones (posiciones top 10 en keywords secundarias)
Mes 12: 5.000–20.000 sesiones (objetivos de Tier 3 alcanzables)
```

---

### M2 — Tasa de completación de herramienta

**Por qué importa:** mide si la herramienta es usable. Un usuario que llega y no completa el formulario no obtuvo valor — y no va a dejar su email.

**Cómo medirla:**
- Evento personalizado en PostHog/Vercel Analytics: `tool_completed` cuando el resultado es visible
- Dividir entre `pageview` de la herramienta

**Señal de alerta:** si la tasa de completación de una herramienta es <30%, el formulario tiene demasiados campos o la UX es confusa. Investigar con grabaciones de sesión (Microsoft Clarity — gratuito).

---

### M3 — Tasa de captura de email

**Por qué es la métrica de negocio más importante en Tier 1:** el email es el único activo que se lleva cuando el usuario se va. El tráfico es de Google; el email es propio.

**Benchmarks de referencia:**
- Tasa media de lead magnet con email: 2–5%
- Con herramienta de alta utilidad (calculadora fiscal): 8–15% alcanzable
- El checklist de documentación tiene potencial de captura >15% (el usuario necesita guardar su progreso)

**Cómo mejorarla si es baja:**
- Cambiar el CTA: "Guarda tu resultado" convierte mejor que "Suscríbete"
- Añadir el beneficio inmediato: "Te enviamos el PDF con el desglose completo"
- Reducir fricción: solo pedir email, nunca nombre ni teléfono en Tier 1

---

### M4 — Emails capturados/mes

**Umbral para avanzar a Tier 3:** >1.000 emails totales capturados.

**Desglose por herramienta:** la columna `source` en la tabla `subscribers` de Supabase permite saber qué herramienta convierte mejor. Si el checklist captura 5x más emails que la calculadora de notaría, eso dice qué feature priorizar en Tier 3.

```sql
-- Query útil en Supabase
select source, count(*) as total
from subscribers
group by source
order by total desc;
```

---

### M5 — Posición media keyword primaria

**Cómo medirla:** Google Search Console → Rendimiento → Consultas → filtrar por URL de la herramienta

**Progresión típica para un site nuevo con buen SEO técnico:**
```
Semana 1–4:    Indexado pero sin posición significativa (>50)
Mes 2–3:       Posición 20–40 para keywords secundarias
Mes 4–6:       Posición 10–20 para keyword primaria
Mes 6–12:      Top 10 para keywords long-tail
Mes 12+:       Top 5 posible en keywords primarias si hay backlinks
```

**Señal de problema:** si a los 3 meses ninguna herramienta aparece en ninguna posición, hay un problema de indexación. Verificar: robots.txt, sitemap.xml enviado a GSC, structured data válido (usar Google Rich Results Test).

---

### M6 — CTR orgánico por herramienta

**Por qué importa:** la posición en Google no lo es todo. Un CTR bajo en posición 5 indica que el title tag o la meta description no conectan con la intención de búsqueda.

**Acción si CTR <2%:** reescribir el title tag con más especificidad ("2026", "Gratis", cifra concreta) y la meta description con beneficio más claro.

---

### M7 — Herramienta más usada

**No hay un "umbral" — es una métrica de priorización.** La herramienta con más sesiones dice qué necesidad del usuario es más urgente. Esa herramienta es la que debe tener la mejor UX, el mejor SEO y el CTA más trabajado. También es la candidata a ser la primera feature del Tier 3 (si es el valorador → priorizar la integración AVM en Tier 2; si es el checklist → priorizar el expediente digital en Tier 3).

---

### M8 — Open rate newsletter

**Por qué importa:** un open rate alto indica que la marca tiene valor percibido y que los suscriptores recuerdan por qué se apuntaron. Un open rate bajo (<20%) indica que el email de bienvenida no fue memorable o que el cadencia es demasiado alta.

**Benchmark del sector:** newsletters de finanzas personales España → 30–45% open rate en primeros 6 meses.

---

## Umbrales de avance a Tier 3

Los umbrales definidos en `decisions.md` (D-004). Se recuerdan aquí con el instrumento de medición:

| Umbral | Valor objetivo | Dónde medirlo |
|---|---|---|
| Sesiones orgánicas/mes | >5.000 | Google Search Console |
| Emails capturados totales | >1.000 | Supabase `subscribers` |
| Herramientas con >500 sesiones/mes | ≥3 | Vercel Analytics por URL |
| Tasa de captura email | >8% | M4/M1 |
| NPS herramientas (encuesta) | >50 | Typeform/Tally gratuito |
| Usuarios preguntando si pueden publicar | Cualquiera | Email replies, comentarios |

**Revisar estos umbrales cada mes, primer día.** No avanzar a Tier 3 antes de cumplir al menos 3 de los 6.

---

## Configuración mínima de analytics desde el día 1

```
1. Google Search Console
   → Verificar dominio
   → Enviar sitemap.xml (/sitemap.xml generado por next-sitemap)
   → Activar alertas de errores de cobertura

2. Vercel Analytics
   → Activar en el dashboard de Vercel (1 click)
   → Revisar Web Vitals por ruta semanalmente

3. PostHog (free tier)
   → Instalar el snippet en layout.tsx
   → Crear evento: tool_completed (cuando el resultado es visible)
   → Crear evento: email_captured (cuando se envía el form de email)
   → Embudo: pageview → tool_completed → email_captured

4. Supabase
   → Query mensual: emails capturados por source
   → Alerta si la tabla no crece en 7 días consecutivos

5. Google Analytics 4 (opcional)
   → Si se quiere más detalle que Vercel Analytics
   → Requiere configurar banner de cookies antes de activar 🔴
```

---

## Lo que NO se mide en Tier 1

Para no confundirse con métricas que no tienen contexto todavía:

- ❌ MRR / ARR — no hay ingresos
- ❌ CAC — no hay captación de pago
- ❌ LTV / LTV/CAC — no hay transacciones
- ❌ Tiempo medio de venta — no hay inmuebles
- ❌ Ratio compradores/vendedores — no hay marketplace
- ❌ Tasa de cierre — no hay operaciones

---

*→ Guardado en: `docs/data/kpis/kpis-tier1.md`*
*✅ F9 completada (versión Tier 1). Configurar analytics antes del primer deploy público.*
