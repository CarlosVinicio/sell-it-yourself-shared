# Módulo 3 · Estructura de costes e inversión necesaria

> Output del Asesor Financiero Inmobiliario · Fase 4 (Modelo de negocio).
> Desglosa los costes de desarrollo del MVP, la operación post-lanzamiento y la inversión total hasta break-even.
> → Input directo para Módulo 4 (Análisis de riesgos) y Módulo 5 (Veredicto).

---

## 3.1 Costes de desarrollo del MVP

### Definición de alcance del MVP

El MVP mínimo viable para lanzar SINAGENCIAS.ES requiere las siguientes funcionalidades (extraído de `docs/product/features/inventario-funcionalidades.md`, prioridad Esencial):

1. Flujo de publicación guiado (A1)
2. Valorador de Mercado (B1)
3. Checklist de Documentación por CCAA (C1)
4. Galería fotográfica con guía (A3)
5. Sala de Visitas — agenda + confirmaciones (D1)
6. Mensajería Estructurada comprador-vendedor (D2)
7. Panel de Rendimiento básico (F1)
8. Calculadora Fiscal (C2)
9. Registro / autenticación de usuarios
10. Página de anuncio pública visible para compradores

Este es el conjunto mínimo para que un vendedor pueda publicar, gestionar visitas y cerrar un trato. Todo lo demás es post-MVP.

### Escenario A — Fundador full-stack + UX (perfil del fundador actual) ⭐ Aplicable

El fundador es programador senior con experiencia en **React, Node y UX**. Esto elimina los tres costes de equipo más grandes del MVP: frontend, backend y diseño de flujos.

**Lo que cubre el fundador sin coste de caja:**

| Competencia cubierta | Relevancia para el MVP | Ahorro equivalente |
|---|---|---|
| React (frontend) | Toda la UI del portal, flujos de publicación, panel de vendedor | ~20.000–30.000 € |
| Node.js (backend) | API REST, autenticación, lógica de negocio, integraciones externas | ~20.000–30.000 € |
| UX (diseño de flujos) | Arquitectura de información, wireframes, flujos de usuario | ~8.000–12.000 € |
| **Total coste evitado** | | **~48.000–72.000 €** |

**Lo que sigue requiriendo gasto externo:**

El fundador asume diseño visual, redacción SEO y customer success además del stack técnico. El coste de equipo externo en MVP es prácticamente cero.

| Recurso | Dedicación | Coste estimado | Notas |
|---|---|---|---|
| QA externo (pruebas pre-lanzamiento) | 1–2 semanas | 0–1.500 € | Opcional. El fundador puede cubrirlo con beta testers reales (vendedores conocidos). |
| **Subtotal equipo externo** | | **0–1.500 €** | |

⚠️ **Advertencia de viabilidad operativa (solo fundador):** Hacer todo solo es posible en MVP pero tiene un coste oculto real: el tiempo. El riesgo no es financiero sino de ancho de banda. Producir 2 artículos SEO/semana + desarrollar features + atender a vendedores + iterar el diseño es ~60-70h/semana sostenidas. Funciona en sprint de 4-6 meses para el MVP. En operación continuada post-lanzamiento, habrá que priorizar brutalmente o el producto se estanca. Este riesgo debe aparecer en el Módulo 4 como riesgo operativo RO-04.

| Partida técnica | Coste estimado | Notas |
|---|---|---|
| Infraestructura cloud (Vercel + Supabase + Cloudflare) | 500–1.500 €/año | Tier gratuito cubre el desarrollo. Coste real empieza con primeros usuarios. |
| APIs externas (AVM valoración, emails transaccionales, SMS) | 1.000–2.500 €/año | Catastro/INSPIRE gratuito. AVM: ~0,30–0,80 €/consulta. Resend o Postmark para emails. |
| Herramientas SaaS (analytics, CI/CD, monitoring) | 800–1.800 €/año | Vercel Pro, PostHog, Linear, Sentry. El fundador configura, no necesita soporte externo. |
| Dominio + SSL + registro marca OEPM | 1.400–2.500 € | Dominio: ~15 €/año. OEPM: ~900–1.500 € con gestor (una sola vez). |
| **Subtotal infraestructura** | **3.700–8.300 €** | |

| Partida legal y compliance | Coste estimado | Notas |
|---|---|---|
| Asesoría RGPD / DPO externo | 1.500–3.000 € | Políticas de privacidad, cookies, DPA con proveedores. 🔴 |
| Revisión legal de T&C y limitación de responsabilidad | 2.000–4.000 € | Imprescindible dado el carácter jurídico de las transacciones intermediadas. 🔴 |
| Constitución SL | 500–1.500 € | Si no está constituida. |
| **Subtotal legal** | **4.000–8.500 €** | |

| Partida marketing pre-lanzamiento | Coste estimado | Notas |
|---|---|---|
| Contenidos SEO (30–40 artículos, redactor freelance) | 3.000–5.000 € | Incluido arriba en equipo externo. No duplicar. |
| Landing page pre-lanzamiento | 0 € | El fundador la construye. |
| Herramientas de email / newsletter (Resend, ConvertKit) | 200–500 € | Para capturar leads antes del lanzamiento. |
| **Subtotal marketing pre-launch** | **200–500 €** | |

### **Total inversión MVP — Escenario A (fundador solo, cubre todo):**

| Partida | Rango | Notas |
|---|---|---|
| Equipo externo | 0–1.500 € | Solo QA opcional |
| Infraestructura y herramientas | 3.700–8.300 € | Cloud + APIs + SaaS |
| Legal y compliance | 4.000–8.500 € | OEPM + RGPD + T&C — no omitir |
| Marketing pre-lanzamiento | 0–500 € | Fundador escribe y construye la landing |
| Contingencia (15%) | 1.155–2.745 € | |
| **TOTAL CASH** | **~9.000–21.500 €** | ↓ Frente a 65–115K€ genérico |

🟢 **El MVP requiere menos de 22.000€ en efectivo.** El coste real del proyecto es el tiempo del fundador, no el dinero. Con 25.000€ de colchón personal se cubre el MVP + 12 meses de operaciones con margen holgado.

**Coste de oportunidad (no es gasto de caja, pero es real):** Si el fundador cobra actualmente 50–80K€/año como empleado y dedica 6 meses full-time al MVP, el coste implícito es 25–40K€. Este número no sale del banco, pero debe tenerse en cuenta en la decisión de cuándo arrancar (¿compagina con trabajo actual? ¿renuncia? ¿trabaja en paralelo?).

**Tiempo estimado de desarrollo MVP:** 4–7 meses en dedicación full-time. 8–14 meses si se compagina con trabajo a jornada completa.

### Escenario B — Sin perfil técnico (referencia)

| Partida | Rango |
|---|---|
| Equipo de desarrollo externo | 91.000–176.000 € |
| Infraestructura y herramientas | 3.700–8.300 € |
| Legal y compliance | 4.000–8.500 € |
| Marketing pre-lanzamiento | 5.000–13.500 € |
| Contingencia (15%) | 15.555–31.245 € |
| **TOTAL** | **~119.000–237.000 €** |

Este escenario queda como referencia. **No es el caso del fundador actual.**

**Tiempo estimado de desarrollo MVP:** 9–14 meses.

---

## 3.2 Costes operativos anuales (post-lanzamiento)

### Año 1 — Equipo mínimo viable de operación (perfil fundador React + Node + UX)

El fundador cubre todo el stack técnico. El equipo año 1 es mínimo: el fundador más apoyo puntual externo.

| Rol | Tipo | Coste anual | Notas |
|---|---|---|---|
| Fundador (todo) | Autónomo / SL | 0–24.000 € | Salario mínimo si tiene colchón. Puede ser 0 en año 1 si la situación personal lo permite. |
| **Subtotal equipo año 1** | | **0–24.000 €** | |

⚠️ El fundador asume desarrollo, diseño, SEO, CS y operaciones. Viable en año 1 por el volumen bajo de operaciones. A partir de las 20-30 ops/mes, la atención al vendedor y la producción de contenidos compiten con el tiempo de desarrollo. Señal de alerta: si el tiempo de respuesta a vendedores supera las 4 horas, es momento de contratar CS externo.

### Estructura de costes operativos anuales (fundador técnico)

| Partida | Año 1 | Año 2 | Año 3 | Notas |
|---|---|---|---|---|
| **Equipo (fundador)** | 0–24.000 € | 0–24.000 € | 24.000–80.000 € | Año 3: primer empleado cuando el volumen lo exige |
| **Infraestructura cloud** | 2.000–5.000 € | 5.000–15.000 € | 15.000–40.000 € | Vercel + Supabase + CDN |
| **Marketing** | 500–2.000 € | 2.000–8.000 € | 8.000–30.000 € | Principalmente herramientas (no agencia). Fundador produce el contenido. |
| **APIs y datos externos** | 2.000–5.000 € | 5.000–15.000 € | 15.000–40.000 € | AVM, firma digital, email/SMS, Idealista API |
| **Legal y compliance** | 2.000–4.000 € | 1.500–3.000 € | 2.000–5.000 € | Mantenimiento anual del RGPD, actualizaciones normativas |
| **Herramientas SaaS** | 1.500–3.000 € | 2.000–5.000 € | 4.000–10.000 € | |
| **G&A (gestoría, seguros SL)** | 2.500–4.000 € | 2.500–4.000 € | 3.000–5.000 € | |
| **Contingencia (10%)** | 1.050–4.700 € | 1.800–7.400 € | 7.100–21.000 € | |
| **TOTAL OPEX ANUAL** | **~11.500–51.700 €** | **~19.800–81.400 €** | **~78.100–231.000 €** | |

**Escenario base (valores medios) — fundador solo:**

| | Año 1 | Año 2 | Año 3 |
|---|---|---|---|
| OPEX (genérico original) | ~120.000 € | ~320.000 € | ~580.000 € |
| OPEX (fundador + equipo externo) | ~75.000 € | ~210.000 € | ~420.000 € |
| OPEX (fundador solo) | **~25.000 €** | **~45.000 €** | **~130.000 €** |
| **Ahorro acumulado vs. genérico** | **~95.000 €** | **~370.000 €** | **~920.000 €** |

---

## 3.3 Inversión total necesaria hasta break-even

### Definición de break-even operativo

Break-even = momento en que los ingresos mensuales cubren los costes operativos mensuales (EBITDA = 0).

Del Módulo 2, el escenario base proyecta:
- **Ingresos año 3:** ~1.300.000 €
- **OPEX año 3:** ~580.000 €
- **EBITDA año 3 (escenario base):** ~720.000 € ← positivo

Sin embargo, los años 1 y 2 son de quema de caja:
- **EBITDA año 1:** 58.000 - 120.000 = **-62.000 €**
- **EBITDA año 2:** 354.000 - 320.000 = **+34.000 €** ← potencialmente positivo

🟡 **El escenario base muestra break-even operativo en año 2.** Sin embargo, este escenario requiere alcanzar 70 operaciones/mes en año 2, lo que depende de una estrategia de SEO que funcione bien y no de paid acquisition. Si el crecimiento es más lento (escenario conservador), el break-even se desplaza a año 3-4.

### Cálculo de caja necesaria — Análisis de escenarios (fundador técnico)

Usando los ingresos del Módulo 2 y el OPEX ajustado al perfil del fundador:

| Escenario | Ingresos año 1 | OPEX año 1 | EBITDA año 1 | EBITDA año 2 | **Cash total necesario** |
|---|---|---|---|---|---|
| **Conservador** | ~30.000 € | ~52.000 € | **-22.000 €** | ~-5.000 € | **~50.000 €** |
| **Base** | ~58.000 € | ~25.000 € | **+33.000 €** | ~+309.000 € | **~0 € adicional** |
| **Optimista** | ~100.000 € | ~15.000 € | **+85.000 €** | ~+450.000 € | **~0 € adicional** |

🟢 **El escenario base genera caja positiva desde el año 1.** Con un OPEX de ~25.000€/año (solo costes fijos de infraestructura, legal y herramientas), el punto de equilibrio mensual se alcanza con ~5-8 operaciones/mes al precio del plan Profesional. Eso es un objetivo realista para el mes 3-4 post-lanzamiento.

🟡 El escenario conservador sigue requiriendo colchón personal de ~50.000€ para aguantar 18 meses sin ingresos suficientes. Recomendado tenerlo antes de lanzar.

### Inversión total desglosada por fase (fundador solo)

| Fase | Periodo | Cash necesario | Hito de entrada a siguiente fase |
|---|---|---|---|
| **Fase 0 — MVP** | Hoy → lanzamiento (~4–7 meses) | **~9.000–22.000 €** | Portal funcionando con ≥5 anuncios reales |
| **Fase 1 — Validación** | Lanzamiento → mes 12 | **~13.000–30.000 €** (OPEX año 1) | 10-20 ops/mes, LTV/CAC > 2 con datos reales |
| **Fase 2 — Early growth** | Mes 12 → mes 30 | **Autofinanciado con ingresos** | 50-100 ops/mes, primer empleado CS |
| **Break-even (escenario base)** | ~Mes 4–6 post-lanzamiento | — | ~5-8 ops/mes cubren OPEX mensual |
| **TOTAL hasta break-even** | ~8–13 meses | **~22.000–52.000 €** | ↓ Frente a 350–700K€ del escenario genérico |

---

## 3.4 Vías de financiación — Análisis y recomendación

### Opción 1 — Bootstrapping puro

| Variable | Dato |
|---|---|
| Capital propio necesario | **~20.000–35.000 € (MVP)** con el perfil actual del fundador |
| Factibilidad | **Alta** — el fundador cubre todo el stack técnico |
| Dilución | 0% |
| Riesgo | Medio — manejable con el colchón de seguridad correcto |
| Tiempo hasta lanzamiento | 4–7 meses (full-time) / 8–14 meses (compaginando) |

🟢 **Con el perfil técnico del fundador, el bootstrapping es la vía más recomendada.** El capital necesario para el MVP es ~20-35K€, no 65-150K€. Un colchón personal de 50-80K€ cubre el MVP + 12 meses de operaciones con margen de seguridad. No tiene sentido ceder equity en seed cuando el capital necesario es tan bajo.

### Opción 2 — Financiación pública no dilutiva

| Instrumento | Importe típico | Condiciones | Tiempo de resolución |
|---|---|---|---|
| **ENISA (BEI)** — Préstamo participativo | 75.000–1.500.000 € | Sin garantías, tipo fijo + variable ligado a beneficios. Requiere constitución SL + plan negocio | 3–6 meses |
| **ICO Emprendedores** | Hasta 1.500.000 € | Aval SGR necesario. Más lento y exige garantías personales | 4–8 meses |
| **CDTI (Innoglobal / Neotec)** | 175.000–250.000 € | Solo si hay componente de I+D demostrable. El algoritmo de valoración o la IA de anuncios pueden calificar | 6–12 meses |
| **Ayudas CCAA** (Madrid Emprende, ACCIÓ Cataluña, etc.) | 10.000–50.000 € | Variables por comunidad. Generalmente para gastos de constitución y primeros empleos | 2–6 meses |

🟢 **ENISA es la mejor opción de financiación no dilutiva para este proyecto.** Con 100.000–200.000 € vía ENISA, es posible financiar el MVP completo sin ceder equity. El hándicap es el tiempo de resolución (3-6 meses) y que requiere la empresa ya constituida.

### Opción 3 — Business Angels y seed VC

| Variable | Dato |
|---|---|
| Importe típico ronda seed | 150.000–500.000 € |
| Dilución esperada | 15–25% |
| Valoración pre-money típica | 500.000–2.000.000 € |
| Plataformas clave en España | Lanzadera (Valencia), Seedrocket, Ship2B, Conector, South Summit |
| Perfil inversor proptech España | Pocos fondos especializados en proptech seed. Los generalistas (Kfund, Nauta Capital) invierten en proptech en fase más avanzada |
| Requisito mínimo para levantar seed | MVP funcionando con primeras operaciones reales (3-6 meses de datos) |

🟡 La ronda seed en España para un proptech es más difícil que en UK o Alemania. El ecosistema de BAs proptech es reducido. **La estrategia recomendada es llegar a una ronda seed con 3-6 meses de datos reales de operaciones**, no con un PowerPoint.

### Opción 4 — Ingresos anticipados / pre-ventas

Posibilidad de monetizar antes del lanzamiento: vendedores que pagan por acceso anticipado (lista de espera de pago) o acuerdos con profesionales afiliados que pagan por exclusividad de zona.

| Mecanismo | Importe posible | Factibilidad |
|---|---|---|
| Pre-registro de pago (acceso beta) | 49–99 € × 200 usuarios = 10.000–20.000 € | Media — requiere campaña de captación |
| Acuerdo exclusividad con gestoría/abogado | 500–2.000 € por provincia exclusiva | Alta — pocas cosas que dar a cambio en pre-MVP |

🟡 Interesante para validar demanda y generar caja mínima, pero insuficiente como estrategia de financiación principal.

### Recomendación de vía de financiación

**Estrategia escalonada recomendada (fundador React + Node + UX):**

```
ETAPA 0 — Preparación (paralela al trabajo actual, si aplica)
──────────────────────────────────────────────────────────────
Capital propio: 5.000–10.000 €
Acciones:
  - Constituir SL y solicitar ENISA
  - Iniciar producción de contenidos SEO (redactor freelance)
  - Definir arquitectura técnica y ADRs
  - Negociar acceso API con Idealista/Fotocasa

ETAPA 1 — MVP (4–7 meses full-time)
──────────────────────────────────────
Capital propio: 15.000–25.000 €
El fundador desarrolla el MVP completo.
Gasto principal: diseñador visual + redactor SEO + legal.
Objetivo al finalizar: portal funcionando con ≥5 anuncios reales.

ETAPA 2 — Validación (meses 1–12 post-lanzamiento)
────────────────────────────────────────────────────
Capital propio + ENISA + primeros ingresos del portal.
Objetivo: 20-30 operaciones/mes y LTV/CAC validado con datos reales.
Solo contratar CS y redactor SEO. El fundador mantiene el producto.

ETAPA 3 — Decisión de escala (mes 12–18)
─────────────────────────────────────────
Con datos reales: decidir si crecer bootstrapped o levantar seed.
Si LTV/CAC > 3 y crecimiento orgánico sólido: continuar bootstrapped.
Si se quiere escalar más rápido que el flujo de caja permite: ronda seed
de 150.000–300.000 € (dilución 12-18%) con ventaja negociadora real.
```

🟢 **Con este perfil, el bootstrapping hasta validación es la estrategia óptima.** El fundador no necesita ceder equity para construir el MVP ni para operar el primer año. La ronda seed, si se hace, es para escalar — no para sobrevivir. Eso cambia radicalmente las condiciones negociables.

---

## Veredicto parcial — Módulo 3

🟢 El modelo puede construirse con 65.000–150.000€ en escenario con co-founder técnico. Es un proyecto con capital inicial accesible comparado con otros sectores.

🔴 El break-even a 24-36 meses es optimista y depende de que el SEO funcione como canal primario. En el escenario conservador, la inversión total necesaria hasta rentabilidad es ~430.000€ — lo que requiere una ronda seed de al menos 200.000-300.000€ además del capital propio.

🟡 **La decisión más urgente es la constitución de la SL para solicitar ENISA.** Cada mes de retraso es un mes de retraso en la aprobación del préstamo no dilutivo.

---

*→ Guardado en: `docs/business/model/cost-structure.md`*
*✅ Módulo 3 completado. Input directo para Módulo 4 (Análisis de riesgos) y Módulo 5 (Veredicto).*
