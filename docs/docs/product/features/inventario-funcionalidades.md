# Inventario de Funcionalidades — SINAGENCIAS.ES

> Output de Fase 2 · Ideas y herramientas.
> Basado en el glosario fundacional de Fase 1.
> → Referencia directa para Fase 5 (UX) y Fase 10 (Roadmap MVP).

**Leyenda de prioridad:** `Esencial` = MVP obligatorio · `Importante` = MVP deseable · `Deseable` = v2+
**Leyenda de complejidad:** `Baja` = días · `Media` = semanas · `Alta` = mes+

---

## [A] Captación y Publicación

### A1 · Flujo de Publicación Guiado
**Qué hace:** Proceso step-by-step para dar de alta un inmueble: tipo → datos básicos → fotos → descripción → precio → documentación → vista previa → publicar. Cada paso valida el anterior antes de avanzar.

**Valor diferencial:** Los portales actuales tienen formularios planos sin guía. Nuestro flow actúa como un asistente, no como un formulario. Reduce la tasa de abandono y garantiza la calidad mínima del anuncio.

| Prioridad | Complejidad | Bloquea |
|---|---|---|
| **Esencial** | Media | Todo lo demás. Sin esto no hay producto. |

---

### A2 · Asistente de Descripción IA
**Qué hace:** Genera automáticamente una descripción comercial del inmueble a partir de los datos introducidos y las fotos subidas. El vendedor puede editarla libremente. Incluye variantes de tono (formal / cercano / premium).

**Valor diferencial:** El particular no tiene experiencia en copywriting inmobiliario. La descripción impacta directamente en el CTR del anuncio. Ningún portal lo ofrece al particular de forma automática.

| Prioridad | Complejidad | Notas |
|---|---|---|
| Importante | Alta | Depende de API de modelo de lenguaje (OpenAI / Claude). Puede lanzarse en v1 con plantillas y IA en v2. |

---

### A3 · Subida y Guía de Fotografía
**Qué hace:** Upload múltiple con reordenación drag-and-drop. Guía de fotos mínimas por estancia (fachada, salón, cocina, dormitorios, baños, terraza). Alerta si faltan estancias clave. Mejora automática básica (exposición, contraste). Enlace a fotógrafo afiliado para sesión profesional.

**Valor diferencial:** Las fotos son el factor #1 de conversión en inmobiliario. Los particulares publican fotos de baja calidad que reducen el interés y alargan el tiempo en mercado.

| Prioridad | Complejidad |
|---|---|
| **Esencial** | Media |

---

### A4 · Autocompletado con Datos Catastrales
**Qué hace:** Al introducir la dirección, consulta la API del Catastro y precompleta: referencia catastral, superficie registrada, año de construcción, uso del suelo y valor catastral. El vendedor confirma o corrige.

**Valor diferencial:** Elimina errores de datos, reduce el tiempo de publicación y da al comprador información verificada desde el origen, no autodeclarada.

| Prioridad | Complejidad |
|---|---|
| Importante | Media |

---

### A5 · Vista Previa del Anuncio
**Qué hace:** Antes de publicar, muestra al vendedor exactamente cómo verá su anuncio el comprador en desktop y móvil. Alerta visual sobre campos incompletos, fotos insuficientes o precio fuera de rango.

**Valor diferencial:** Los portales publican sin preview. Esta feature reduce los anuncios de baja calidad y da al vendedor seguridad antes de lanzar.

| Prioridad | Complejidad |
|---|---|
| Importante | Baja |

---

### A6 · Publicación Multiportal
**Qué hace:** Distribuye el anuncio simultáneamente en otros portales (Idealista, Fotocasa, Pisos.com) mediante integración de API. El vendedor gestiona todo desde SINAGENCIAS.ES.

**Valor diferencial:** Maximiza el alcance sin esfuerzo adicional del vendedor. Fuente de ingresos por servicio premium.

| Prioridad | Complejidad | Notas |
|---|---|---|
| Deseable | Alta | Requiere acuerdos comerciales. Complejidad técnica y legal significativa. v2+. |

---

## [B] Valoración y Precio

### B1 · Valorador de Mercado
**Qué hace:** Estima el valor del inmueble mediante datos del Catastro + comparables activos y cerrados en la zona + tendencias de precio. Genera tres rangos: conservador / recomendado / optimista con justificación de cada uno. Accesible sin registro como anzuelo de captación.

**Valor diferencial:** Los valoradores de la competencia son anzuelos para captar el lead de su agencia. El nuestro es objetivo, sin interés oculto, y orienta al vendedor para fijar un precio de salida competitivo y autónomo.

| Prioridad | Complejidad | Notas |
|---|---|---|
| **Esencial** | Alta | Principal motor de captación top-of-funnel. Prioridad máxima incluso antes del MVP completo. |

---

### B2 · Comparador de Precio en Tiempo Real
**Qué hace:** Durante el step de precio en la publicación, muestra en tiempo real: cuántos inmuebles similares hay en el mercado a ese precio, cuántos se han vendido en los últimos 90 días y el tiempo medio hasta oferta por rango de precio. Recomienda el precio óptimo.

**Valor diferencial:** Transforma información de mercado que solo tenían los agentes en una herramienta accesible para el particular en el momento de toma de decisión.

| Prioridad | Complejidad |
|---|---|
| Importante | Alta |

---

### B3 · Calculadora Fiscal
**Qué hace:** Calcula el IRPF estimado (ganancia patrimonial) y la plusvalía municipal a partir del precio de compra, precio de venta, años de tenencia, mejoras acreditadas y CCAA del inmueble. Muestra el neto real de la operación. Incluye simulador de exención por reinversión en vivienda habitual.

**Valor diferencial:** El vendedor fija el precio de venta sin saber cuánto se llevará Hacienda. Esta calculadora corrige ese error estructural y diferencia el portal de los blogs con datos estáticos.

| Prioridad | Complejidad |
|---|---|
| Importante | Media |

---

### B4 · Alertas de Precio de Mercado
**Qué hace:** Notifica al vendedor cuando su precio queda desviado por nuevos inmuebles publicados o vendidos en su zona. Sugiere revisión si lleva más de 30 días sin contactos a ese precio.

**Valor diferencial:** Proactivo, no reactivo. Reduce el riesgo de que el inmueble caduque por precio incorrecto sin que el vendedor lo detecte.

| Prioridad | Complejidad |
|---|---|
| Importante | Media |

---

## [C] Gestión de Visitas y Demanda

### C1 · Sala de Visitas
**Qué hace:** El comprador solicita visita eligiendo entre los slots de disponibilidad que el vendedor configura (disponibilidad tipo calendario). El vendedor confirma o propone alternativa. Ambas partes reciben recordatorio a 24h y 1h. Post-visita, el vendedor registra el feedback (interesado / dudoso / descartado).

**Valor diferencial:** Estructura y profesionaliza la visita. Elimina los WhatsApp improvisados, las visitas sin confirmar y los no-shows. Sustituye la función coordinadora del agente.

| Prioridad | Complejidad |
|---|---|
| **Esencial** | Media |

---

### C2 · Mensajería Estructurada
**Qué hace:** Chat interno entre vendedor y comprador con historial persistente, plantillas de respuesta rápida (ej: "Gracias por tu interés, te confirmo la visita el..."), posibilidad de adjuntar documentos del Expediente Digital al comprador verificado, y opción de bloquear/reportar usuarios.

**Valor diferencial:** Mantiene toda la comunicación dentro del portal (trazabilidad, protección de datos, RGPD). Evita que la operación migre a WhatsApp donde el portal pierde el control y la información.

| Prioridad | Complejidad |
|---|---|
| **Esencial** | Media |

---

### C3 · Filtro de Compradores Cualificados
**Qué hace:** El vendedor configura criterios mínimos para solicitar visita: verificación de identidad obligatoria, rango de precio máximo declarado, tipo de financiación (al contado / hipoteca / indiferente). Los compradores que no cumplan ven el anuncio pero no pueden solicitar visita.

**Valor diferencial:** Reduce el tiempo perdido en visitas de compradores no cualificados o turistas inmobiliarios. Funcionalidad de valor percibido muy alto para el vendedor.

| Prioridad | Complejidad |
|---|---|
| Importante | Media |

---

### C4 · Gestión de Pipeline de Interesados
**Qué hace:** Vista kanban o lista de todos los compradores en contacto, con su estado: contactado → visita agendada → visita realizada → oferta recibida → negociando → cerrado / descartado. Con notas por comprador.

**Valor diferencial:** El vendedor tiene un CRM básico de su proceso de venta, algo que normalmente solo tiene el agente. Reduce la ansiedad de "¿a cuánta gente le debo responder?".

| Prioridad | Complejidad |
|---|---|
| Importante | Media |

---

### C5 · Tour Virtual / Vídeo 360°
**Qué hace:** Soporte para subir vídeo tour o integración con Matterport/Kuula para tour 360°. El comprador puede visitar virtualmente antes de solicitar visita presencial.

**Valor diferencial:** Filtra compradores con baja intención antes de la visita presencial. Especialmente útil para compradores de otras ciudades.

| Prioridad | Complejidad |
|---|---|
| Deseable | Alta |

---

## [D] Documentación y Legal

### D1 · Checklist de Documentación Dinámico
**Qué hace:** Lista interactiva de documentos necesarios para vender, adaptada automáticamente a la CCAA del inmueble (cédula de habitabilidad, ITE, etc.) y su tipología (piso, chalet, local). Cada ítem tiene: estado (obtenido / pendiente / no aplica), instrucciones paso a paso para obtenerlo, tiempo estimado, coste orientativo y enlace directo al organismo o afiliado.

**Valor diferencial:** Elimina la principal fuente de ansiedad del vendedor particular: no saber qué necesita. Dinámico por CCAA (vs. listas genéricas de blogs). Es el diferencial más visible del portal para el vendedor.

| Prioridad | Complejidad |
|---|---|
| **Esencial** | Media |

---

### D2 · Expediente Digital
**Qué hace:** Repositorio seguro donde el vendedor almacena todos los documentos del inmueble. Detecta caducidad (CEE cada 10 años, cédula con vigencia variable), valida formatos, alerta de documentos próximos a caducar y permite compartir de forma selectiva con comprador verificado o notario.

**Valor diferencial:** Centraliza toda la documentación. Al compartir con el comprador, genera confianza y acelera la decisión de compra. Sin equivalente en ningún portal actual.

| Prioridad | Complejidad |
|---|---|
| Importante | Media |

---

### D3 · Generador de Contrato de Arras
**Qué hace:** Wizard en 5 pasos que genera una plantilla de contrato de arras penitenciales personalizada: datos de ambas partes, descripción del inmueble, precio y forma de pago, importe de la señal, fecha límite de escrituración, penalizaciones y condiciones suspensivas. Descargable en PDF. Opción de revisión por abogado afiliado (servicio de pago).

**Valor diferencial:** El particular no sabe redactar un contrato de arras ni dónde encontrar una plantilla fiable. El portal lo resuelve en minutos con advertencia legal explícita. 🔴 Siempre con disclaimer: "plantilla orientativa, consulta a un abogado antes de firmar".

| Prioridad | Complejidad |
|---|---|
| Importante | Media |

---

### D4 · Checklist Pre-Notaría
**Qué hace:** Lista de comprobación para el día de la firma notarial: documentos a llevar (escrituras, DNI, último IBI, CEE, certificado comunidad, etc.), gastos a preparar (notaría, plusvalía, cancelación hipoteca), qué firmará cada parte y preguntas habituales al notario. Con buscador de notarías por código postal y enlace de cita online.

**Valor diferencial:** El vendedor llega a la notaría sabiendo exactamente qué esperar. Reduce el estrés del cierre y elimina olvidos que pueden retrasar la escrituración.

| Prioridad | Complejidad |
|---|---|
| Importante | Baja |

---

### D5 · Directorio de Profesionales Afiliados
**Qué hace:** Red de notarios, abogados inmobiliarios, gestores, técnicos CEE, fotógrafos y home stagers con tarifas negociadas para usuarios del portal, valoraciones verificadas de otros vendedores y reserva online directa.

**Valor diferencial:** Ecosistema de servicios sin comisión de agencia. Cada referral es ingresos para el portal. Da al vendedor acceso a profesionales de confianza sin buscarlos por su cuenta.

| Prioridad | Complejidad |
|---|---|
| Deseable | Alta |

---

## [E] Negociación y Cierre

### E1 · Herramienta de Oferta Estructurada
**Qué hace:** El comprador envía una oferta formal desde el portal con: precio propuesto, condiciones (financiación, plazo de escrituración, condiciones suspensivas, inclusión de muebles), y plazo de respuesta. El vendedor puede aceptar, rechazar o contraofertar. El historial queda registrado.

**Valor diferencial:** Estructura la negociación. Da al vendedor tiempo para responder con criterio. Registra evidencia del acuerdo. Ningún portal actual gestiona esto.

| Prioridad | Complejidad |
|---|---|
| Importante | Media |

---

### E2 · Comparador de Oferta vs. Mercado
**Qué hace:** Cuando llega una oferta, el sistema muestra automáticamente cómo se compara con el precio medio de cierre de inmuebles similares en la zona en los últimos 90 días y con la desviación histórica en ese código postal.

**Valor diferencial:** El vendedor decide aceptar o negociar con datos reales, no con instinto. Reduce el riesgo de vender por debajo del mercado por presión del comprador.

| Prioridad | Complejidad |
|---|---|
| Deseable | Alta |

---

### E3 · Firma Digital de Arras
**Qué hace:** Firma digital del contrato de arras dentro del portal mediante certificado electrónico (DNIe, Autofirma) o firma biométrica reconocida legalmente. Opción de gestionar el depósito de la señal mediante cuenta escrow integrada.

**Valor diferencial:** Elimina la necesidad de encontrarse físicamente para firmar arras. Especialmente útil en operaciones entre ciudades distintas.

| Prioridad | Complejidad |
|---|---|
| Deseable | Alta |

---

### E4 · Asistente de Cierre
**Qué hace:** Guía post-arras hasta el final de la operación: pasos para cancelar hipoteca, coordinar con notaría, gestionar cambio de titularidad en suministros (luz, gas, agua), notificar a la comunidad de propietarios e Hacienda. Con checklist interactivo y recordatorios.

**Valor diferencial:** Acompaña al vendedor hasta el último paso del proceso, cuando normalmente todos los portales desaparecen.

| Prioridad | Complejidad |
|---|---|
| Deseable | Media |

---

## [F] Analítica y Visibilidad

### F1 · Panel de Rendimiento del Anuncio
**Qué hace:** Métricas en tiempo real del anuncio: impresiones, clics, tasa de contacto (CTR a mensaje), solicitudes de visita, ofertas recibidas. Comparativo con la media de inmuebles similares en la zona. Recomendaciones automáticas de mejora (bajar precio, mejorar fotos, completar descripción).

**Valor diferencial:** El vendedor tiene la información que antes solo tenía el agente. Permite tomar decisiones de mejora del anuncio con datos, no con intuición.

| Prioridad | Complejidad |
|---|---|
| Importante | Media |

---

### F2 · Optimizador de Visibilidad (Destacado)
**Qué hace:** Opciones de mayor visibilidad de pago: posición preferente en resultados de búsqueda, etiquetas especiales (Precio reducido / Nuevo / Vendedor verificado / Urgente), distribución en redes sociales del portal, y notificación push a compradores con alertas activas en esa zona.

**Valor diferencial:** Palancas de visibilidad que el vendedor puede activar sin necesidad de agencia. Fuente de ingresos del portal.

| Prioridad | Complejidad |
|---|---|
| Importante | Media |

---

### F3 · Informe de Mercado por Zona
**Qué hace:** Informe mensual automático con: evolución del precio por m² en la zona, tiempo medio de venta, ratio oferta/demanda, y posicionamiento del anuncio respecto a los competidores más directos en su área.

**Valor diferencial:** Transforma datos de mercado en inteligencia accionable entregada automáticamente. El vendedor no tiene que investigar: el portal lo hace por él.

| Prioridad | Complejidad |
|---|---|
| Deseable | Alta |

---

### F4 · Informe Post-Venta
**Qué hace:** Al cierre, genera un resumen del proceso completo: tiempo en mercado, visitas realizadas, ofertas recibidas, desviación entre precio inicial y precio final, coste fiscal estimado de la operación. Descargable y compartible.

**Valor diferencial:** Cierra el ciclo con un documento memorable. Es una palanca de referido natural ("mira lo que conseguí vendiendo solo").

| Prioridad | Complejidad |
|---|---|
| Deseable | Baja |

---

## [G] Comunidad y Soporte

### G1 · Centro de Conocimiento (Blog + Guías SEO)
**Qué hace:** Biblioteca de guías exhaustivas, tutoriales y artículos educativos: documentación necesaria para vender, cómo fijar el precio, negociación con compradores, fiscalidad de la venta, trámites notariales, home staging, fotografía inmobiliaria. Todos optimizados para SEO sobre las keywords del cluster "vender piso particular sin agencia".

**Valor diferencial:** Principal motor de captación orgánica. "Cómo vender mi piso sin agencia" genera miles de búsquedas al mes. El contenido captura visitantes en fase informacional y los convierte en vendedores registrados. Activo desde el día 1.

| Prioridad | Complejidad |
|---|---|
| **Esencial** | Baja |

---

### G2 · Suite de Calculadoras Gratuitas
**Qué hace:** Conjunto de herramientas de acceso libre sin registro: calculadora de hipoteca, estimador de plusvalía municipal, simulador de IRPF por venta, calculadora de gastos notariales, comparador de coste agencia vs. portal propio. Actúan como lead magnet y como herramientas de SEO.

**Valor diferencial:** Herramientas de valor sin fricción que convierten visitantes en usuarios registrados. Cada calculadora es una landing page SEO independiente.

| Prioridad | Complejidad |
|---|---|
| Importante | Baja |

---

### G3 · Asistente IA de Soporte (Chatbot)
**Qué hace:** Chatbot entrenado sobre el proceso de venta en España, normativa vigente y funcionalidades del portal. Responde dudas frecuentes 24/7. Escala a agente humano en casos complejos. Accesible desde cualquier pantalla del portal.

**Valor diferencial:** Soporte escalable sin equipo grande. El particular tiene dudas a las 22h del domingo. Un chatbot bien entrenado puede resolver el 70% sin intervención humana.

| Prioridad | Complejidad |
|---|---|
| Importante | Alta |

---

### G4 · Foro de Comunidad
**Qué hace:** Espacio de preguntas y respuestas entre vendedores actuales y pasados. Secciones: documentación y trámites / negociación / fiscalidad / experiencias de cierre / home staging. Moderado por el equipo. Los mejores hilos se convierten en artículos del blog.

**Valor diferencial:** Genera contenido UGC que alimenta el SEO y crea comunidad de marca. Un vendedor que resuelve sus dudas en el foro es un vendedor que no abandona el portal.

| Prioridad | Complejidad |
|---|---|
| Deseable | Baja |

---

### G5 · Sistema de Valoraciones
**Qué hace:** Tras el cierre, el comprador valora la experiencia con el vendedor (comunicación, veracidad del anuncio, flexibilidad) y viceversa. Las valoraciones positivas se muestran en el perfil del vendedor como señal de confianza.

**Valor diferencial:** Genera confianza social en un contexto donde el particular no tiene el respaldo de marca de una agencia. Reduce la desconfianza del comprador ante un vendedor desconocido.

| Prioridad | Complejidad |
|---|---|
| Deseable | Baja |

---

## Top 10 — Funcionalidades MVP

| # | Funcionalidad | Bloque | Prioridad | Complejidad | Por qué en el MVP |
|---|---|---|---|---|---|
| 1 | Flujo de Publicación Guiado | A | Esencial | Media | Sin esto no hay producto. |
| 2 | Valorador de Mercado | B | Esencial | Alta | Principal anzuelo de captación. Activo antes del MVP completo. |
| 3 | Centro de Conocimiento SEO | G | Esencial | Baja | Motor de tráfico orgánico desde el día 1. No requiere producto terminado. |
| 4 | Checklist de Documentación Dinámico | D | Esencial | Media | Principal dolor del vendedor. Diferencial único en el mercado. |
| 5 | Sala de Visitas | C | Esencial | Media | Sustituye la función más visible del agente. |
| 6 | Mensajería Estructurada | C | Esencial | Media | Mantiene la operación y los datos dentro del portal. |
| 7 | Subida y Guía de Fotografía | A | Esencial | Media | La calidad de las fotos es el factor #1 de conversión. |
| 8 | Panel de Rendimiento del Anuncio | F | Importante | Media | Da al vendedor el control que antes tenía el agente. |
| 9 | Calculadora Fiscal | B | Importante | Media | Diferencial de transparencia. Captura visitantes en búsqueda de "cuánto pagaré al vender". |
| 10 | Generador de Contrato de Arras | D | Importante | Media | Momento de mayor ansiedad del vendedor. Sin herramientas en el mercado actual. |

---

*→ Guardado en: `docs/product/features/inventario-funcionalidades.md`*
*✅ Fase 2 completada. Input directo para Fase 5 (UX) y Fase 10 (Roadmap).*
