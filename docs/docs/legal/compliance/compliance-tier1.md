# F7 · Marco legal y compliance — Tier 1 (herramientas gratuitas)

> Fase 7 ejecutada y adaptada al Tier 1.
> El marco legal completo del portal (contratos, arras, custodia documental) es Tier 3.
> Lo que aplica desde el día 1: RGPD para email capture y cookies para analytics.
>
> 🔴 Este documento es orientativo. Validar con asesor jurídico antes del lanzamiento público.

---

## Qué activa la obligación legal en Tier 1

Dos acciones concretas del Tier 1 activan obligaciones legales que no pueden ignorarse:

1. **Email capture** → tratamiento de datos personales → RGPD (Reglamento UE 2016/679) + LOPDGDD (LO 3/2018)
2. **Analytics (Vercel Analytics, PostHog, GA4)** → uso de cookies o tecnologías de seguimiento → LSSI (Ley 34/2002) + directiva ePrivacy

Sin resolver estos dos puntos, el portal no puede capturar emails ni activar analytics de forma legal.

---

## 1. RGPD y email capture

### Base jurídica del tratamiento

Para la lista de email de newsletter/waitlist, la base jurídica es el **consentimiento explícito** (Art. 6.1.a RGPD). Esto implica:

- El checkbox de suscripción debe estar **desmarcado por defecto**. Nunca pre-marcado.
- El texto junto al checkbox debe ser claro: *"Acepto recibir la guía y la newsletter de sinagencias.es. Puedo cancelar en cualquier momento."*
- El consentimiento debe ser **granular**: el usuario acepta la newsletter, no "comunicaciones comerciales de terceros".

### Información mínima al recoger el email (Art. 13 RGPD)

En el formulario de email capture o en un enlace visible desde él, indicar:
- Quién es el responsable del tratamiento (nombre del titular / SL)
- Para qué se usa el email (newsletter sobre venta de inmuebles, guías)
- Que puede darse de baja en cualquier momento (enlace de baja en cada email)
- Enlace a la política de privacidad completa

### Contenido mínimo de la política de privacidad

Crear `/privacidad` con al menos:

```
1. Responsable del tratamiento
   Nombre: [Razón social SL o nombre autónomo]
   NIF: [...]
   Email de contacto: [email de contacto]

2. Datos que recogemos
   - Email (para newsletter y comunicaciones)
   - IP y datos de navegación (para analytics, ver apartado cookies)
   - Herramienta utilizada (campo 'source' en la BD)

3. Base jurídica
   - Newsletter: consentimiento (Art. 6.1.a RGPD)
   - Analytics: interés legítimo o consentimiento según tecnología usada

4. Plazo de conservación
   - Email: hasta que el usuario se dé de baja
   - Logs de analytics: máximo 26 meses (estándar GA4)

5. Derechos del usuario
   Acceso, Rectificación, Supresión, Oposición, Portabilidad, Limitación.
   Ejercicio: [email de contacto]
   Reclamación ante la AEPD: www.aepd.es

6. Transferencias internacionales
   - Supabase: servidores en EU (Frankfurt). Sin transferencia internacional.
   - Resend: servidores en EU. Sin transferencia internacional.
   - Vercel: servidores en EU disponibles (seleccionar región EU en el proyecto).
   - PostHog Cloud EU: opción EU disponible. Usar la EU instance.
   ⚠️ Si se usa GA4: Google LLC es receptor de datos en EE.UU. Requiere cláusulas
      contractuales tipo (SCCs) con Google. Alternativa: usar PostHog EU o Plausible.
```

### Derecho de baja (unsubscribe)

Cada email enviado con Resend debe incluir un enlace de baja funcional. Resend lo incluye automáticamente si se activa la opción en el dashboard. **Verificar que está activado antes del primer envío.**

---

## 2. Cookies y analytics

### ¿Qué tecnologías usan cookies o almacenamiento local?

| Tecnología | ¿Usa cookies? | Tipo | Requiere consentimiento |
|---|---|---|---|
| Vercel Analytics | No (privacy-first, sin cookies) | Análisis agregado | ❌ No requiere banner |
| PostHog (EU instance) | Sí (session cookie) | Analytics | ✅ Requiere consentimiento |
| Google Analytics 4 | Sí (`_ga`, `_gid`) | Analytics + perfilado | ✅ Requiere consentimiento |
| Supabase Auth | Sí (session token) | Funcional | ❌ Exento (necesario para el servicio) |
| Google Search Console | No (solo verifica propiedad) | — | ❌ No aplica |

**Recomendación para Tier 1:** usar **Vercel Analytics como analytics principal** (no requiere banner de cookies) y diferir GA4 o PostHog para cuando el volumen justifique la complejidad de implementar un CMP (Consent Management Platform).

Si se usa PostHog: activar la EU instance (`eu.posthog.com`) e implementar el banner antes de cargar el script.

### Banner de cookies mínimo (si se usan cookies de analytics)

El banner debe:
- Aparecer antes de que se carguen las cookies de analytics
- Ofrecer al menos dos opciones: "Aceptar" y "Rechazar" o "Solo esenciales"
- No tener botón de aceptar más prominente que el de rechazar (directriz AEPD 2023)
- Recordar la preferencia (no volver a mostrar si ya eligió)

**Librerías gratuitas para Next.js:** `@consent-manager/core`, `vanilla-cookieconsent`, o implementación propia con localStorage.

🟡 El banner de cookies es técnicamente obligatorio si hay cualquier cookie no esencial. Implementarlo mal (oscuro dark pattern) puede resultar en sanción de la AEPD (hasta 10M € o 2% del volumen de negocio global).

---

## 3. Aviso legal y términos de uso (herramientas)

Para las calculadoras del Tier 1, el aviso legal debe cubrir:

### Limitación de responsabilidad de las calculadoras

Las calculadoras proporcionan **estimaciones orientativas**, no asesoramiento fiscal ni jurídico profesional. Incluir en cada herramienta, visible cerca del resultado:

> *"Los resultados de esta calculadora son estimaciones orientativas basadas en la normativa vigente en la fecha de publicación. No constituyen asesoramiento fiscal ni jurídico. Consulta con un profesional antes de tomar decisiones. Los tipos impositivos pueden variar por legislación autonómica o cambios normativos."*

Esto es especialmente importante para:
- **Calculadora IRPF**: los tramos pueden cambiar en cada Ley de Presupuestos
- **Calculadora plusvalía**: dos métodos de cálculo vigentes desde STC 182/2021; la normativa municipal varía por ayuntamiento
- **Checklist documentación**: los requisitos varían por CCAA y cambian con frecuencia

### Página `/aviso-legal` — contenido mínimo (LSSI Art. 10)

```
1. Datos del titular del sitio web
   Denominación social / nombre y apellidos
   NIF
   Domicilio social
   Email de contacto
   (Si está inscrita en el Registro Mercantil: datos de inscripción)

2. Actividad del sitio
   Descripción del servicio (herramientas informativas gratuitas)

3. Propiedad intelectual
   El contenido es propiedad del titular. Prohibida reproducción sin autorización.

4. Limitación de responsabilidad
   Las calculadoras son orientativas. No sustituyen asesoramiento profesional.

5. Legislación aplicable y jurisdicción
   Ley española. Juzgados y Tribunales de [ciudad del domicilio social].
```

---

## 4. Checklist de compliance antes del lanzamiento

| Ítem | Obligatorio | Estado |
|---|---|---|
| Política de privacidad en `/privacidad` | 🔴 Sí | ⬜ Pendiente |
| Aviso legal en `/aviso-legal` | 🔴 Sí (LSSI) | ⬜ Pendiente |
| Disclaimer en cada calculadora (resultado orientativo) | 🔴 Sí | ⬜ Pendiente |
| Checkbox de consentimiento en email capture (desmarcado por defecto) | 🔴 Sí | ⬜ Pendiente |
| Enlace de baja en emails (unsubscribe) | 🔴 Sí | ⬜ Pendiente |
| Analytics sin cookies (Vercel Analytics) o banner de cookies | 🔴 Sí | ⬜ Pendiente |
| Servidores de datos en EU (Supabase EU, Vercel EU, PostHog EU) | 🟡 Recomendado | ⬜ Pendiente |
| Registro de actividades de tratamiento (interno, no público) | 🟡 Sí si >250 empleados o datos sensibles — en este caso no aplica aún | ✅ No aplica Tier 1 |
| DPO designado | ❌ No obligatorio para este volumen | ✅ No aplica Tier 1 |
| Constitución SL antes de capturar emails | 🟡 Recomendado | ⬜ Pendiente |

---

## 5. Lo que espera al Tier 3 (no hacer ahora)

Para no bloquear el lanzamiento del Tier 1 con análisis prematuros:

- **Términos de uso para vendedores y compradores** (con cláusulas de responsabilidad en transacciones) → Tier 3
- **Política de custodia de documentos** (escrituras, DNIs en el Expediente Digital) → Tier 3
- **Revisión legal de plantillas de arras** → Tier 3
- **Protocolo ante anuncios fraudulentos** → Tier 3
- **AI Act compliance** (para el Asistente de Anuncio con IA) → Tier 3
- **Ley de Vivienda 2023**: impacto en funcionalidades del portal → analizar en F7 completa (Tier 3)

---

## Nota final

🔴 **Los textos legales (política de privacidad, aviso legal, términos de uso) deben ser revisados por un abogado antes del lanzamiento público**, especialmente la limitación de responsabilidad de las calculadoras y las cláusulas de tratamiento de datos. El coste de una revisión jurídica básica (1.500–3.000 €) es notablemente inferior al coste de una sanción de la AEPD.

---

*→ Guardado en: `docs/legal/compliance/compliance-tier1.md`*
*✅ F7 completada (versión Tier 1). Resolver checklist de compliance antes del primer deploy público con email capture activo.*
