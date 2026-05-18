> 📌 **Scope:** Tier 3 — portal completo. Ejecutar solo cuando Tier 1–2 tenga tracción validada (ver `docs/memory/decisions.md` D-004).
> ✅ **Versión Tier 1 ya ejecutada:** `docs/tech/architecture/architecture-scalable.md` (route groups, DB evolutiva, auth progresiva) + `docs/tech/architecture/tier1-stack.md` (stack detallado) + `docs/tech/adr/ADR-001-framework-nextjs-app-router.md`.

Fase 6 · Arquitectura técnica

Actúa como arquitecto de software senior con experiencia en plataformas proptech y marketplaces de alto tráfico. Define la arquitectura técnica del portal.

Cubre los siguientes bloques:

1. STACK TECNOLÓGICO RECOMENDADO
   — Frontend: framework recomendado y justificación
   — Backend: arquitectura (monolito modular vs. microservicios) y lenguaje
   — Base de datos: relacional + geoespacial (búsquedas por zona, radio, distrito)
   — Almacenamiento de imágenes y documentos
   — CDN y optimización de carga
   Justifica cada elección en términos de coste, velocidad de desarrollo y escalabilidad.

2. INTEGRACIONES EXTERNAS NECESARIAS
   — API del Catastro (datos de referencia catastral)
   — Registro de la Propiedad (nota simple online)
   — Firma digital (DocuSign, Signaturit u equivalente)
   — Pasarela de pago (Stripe, Redsys)
   — Servicios de geolocalización y mapas
   — Comparadores hipotecarios
   — Proveedores de IA (OpenAI, Anthropic, modelos propios)
   — SMS / Email transaccional
   Para cada integración: complejidad, coste estimado y alternativas.

3. SEGURIDAD Y GESTIÓN DE DATOS
   — Autenticación y autorización (OAuth2, roles)
   — Cifrado de documentos sensibles
   — Estrategia de backup y recuperación
   — Auditoría de accesos a datos personales

4. INFRAESTRUCTURA Y DESPLIEGUE
   — Cloud provider recomendado y justificación
   — Estrategia de entornos (dev, staging, producción)
   — CI/CD pipeline básico
   — Monitorización y alertas

5. ESTIMACIÓN DE EQUIPO TÉCNICO PARA MVP
   — Perfiles necesarios, dedicación y duración estimada
   — Decisión build vs. buy vs. open source para cada componente crítico

Cierra con una tabla de riesgos técnicos ordenados por probabilidad e impacto, con su mitigación propuesta.