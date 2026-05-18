# ADR-003 · Arquitectura de backend: repositorios separados + NestJS

| Campo | Valor |
|---|---|
| **Fecha** | 2026-04-26 |
| **Estado** | ✅ Aceptada |
| **Área** | Tech |
| **Afecta a** | Tier 1, Tier 2, Tier 3 |

---

## Contexto

El proyecto necesita un backend para:
- **Tier 1:** un único endpoint `POST /subscribers` (email capture → Supabase + Resend)
- **Tier 2:** proxy de API externa de valoración (AVM), generación de PDFs, auth
- **Tier 3:** gestión de inmuebles, mensajería, firma digital, pagos

Se evaluaron dos opciones de repositorio y tres opciones de framework.

---

## Opciones evaluadas

### Repositorio

| Opción | Pros | Contras |
|---|---|---|
| **Monorepo** (pnpm workspaces) | Tipos compartidos inmediatos, un solo contexto de agente | Más setup inicial, acoplamiento entre proyectos |
| **Dos repos separados** ✅ | Máximo aislamiento, deploys totalmente independientes, complejidad proporcional al tamaño de cada proyecto | Requiere estrategia explícita para tipos compartidos |

### Framework de backend

| Opción | Pros | Contras |
|---|---|---|
| **Express + TypeScript** | Mínimo setup | Sin estructura, se reinventa todo en Tier 2–3 |
| **Fastify + TypeScript** | Más rápido que Express, mejor tipado | Sin estructura impuesta |
| **NestJS + TypeScript** ✅ | Estructura desde el día 1 (módulos, DI, decoradores), Swagger integrado, escala bien a Tier 3, familiar para un equipo de uno | Mayor setup inicial que Express |

---

## Decisión

**Dos repositorios independientes. Backend con Node.js + NestJS.**

- **Repo frontend:** `sinagencias-web` — Next.js 15 App Router (existente)
- **Repo backend:** `sinagencias-api` — Node.js + NestJS

---

## Estructura del repositorio de backend

```
sinagencias-api/
├── src/
│   ├── subscribers/                    ← Tier 1: email capture
│   │   ├── subscribers.module.ts
│   │   ├── subscribers.controller.ts   (POST /subscribers)
│   │   ├── subscribers.service.ts
│   │   └── dto/
│   │       └── create-subscriber.dto.ts
│   │
│   ├── supabase/                       ← Cliente Supabase compartido
│   │   └── supabase.module.ts
│   │
│   ├── email/                          ← Resend (emails transaccionales)
│   │   └── email.module.ts
│   │
│   ├── app.module.ts
│   └── main.ts
│
├── test/
│   └── subscribers.e2e-spec.ts
│
├── .env
├── .env.example
└── package.json
```

**Crecimiento por Tier:**

```
Tier 2 añade:
├── src/
│   ├── auth/          ← Supabase Auth (JWT validation)
│   ├── tools/         ← Guardar resultados de herramientas
│   └── valuation/     ← Proxy AVM (Tinsa/Idealista Data)

Tier 3 añade:
├── src/
│   ├── listings/      ← Gestión de inmuebles
│   ├── visits/        ← Sala de visitas
│   ├── messages/      ← Mensajería
│   ├── documents/     ← Expediente digital (Supabase Storage)
│   └── payments/      ← Stripe
```

---

## Comunicación frontend ↔ backend

El frontend llama al backend vía REST sobre HTTPS. La URL base se configura por entorno:

```
# apps/web/.env.local
NEXT_PUBLIC_API_URL=http://localhost:3001   # desarrollo
NEXT_PUBLIC_API_URL=https://api.sinagencias.es  # producción
```

**CORS:** el backend NestJS configura CORS para aceptar peticiones solo desde los dominios del frontend:
```typescript
// main.ts
app.enableCors({
  origin: [
    'https://sinagencias.es',
    'https://www.sinagencias.es',
    process.env.NODE_ENV === 'development' && 'http://localhost:3000',
  ].filter(Boolean),
  methods: ['GET', 'POST', 'PUT', 'DELETE', 'OPTIONS'],
  credentials: true,
});
```

---

## Tipos compartidos entre repos

Sin monorepo, los tipos deben sincronizarse explícitamente.

| Tier | Estrategia | Razón |
|---|---|---|
| **Tier 1** | Duplicar los DTOs en ambos repos | Superficie mínima (solo `CreateSubscriberDto`). Overhead despreciable. |
| **Tier 2+** | Publicar paquete privado `@vtm/shared` en npm | Cuando la superficie de tipos crezca (auth, herramientas, listings). El paquete exporta DTOs y types. |

**DTO de Tier 1 — duplicado intencionalmente:**

```typescript
// sinagencias-api/src/subscribers/dto/create-subscriber.dto.ts
export class CreateSubscriberDto {
  email: string;
  source: string;   // 'T1' | 'T2' | 'T3' | 'T4' | 'T5' | 'T6'
  ccaa?: string;    // solo cuando viene de T4 (checklist)
}

// sinagencias-web/lib/api/subscribers.ts (mismo contrato)
export type SubscriberPayload = {
  email: string;
  source: string;
  ccaa?: string;
};
```

---

## Hosting

| Componente | Servicio | Plan | Coste Tier 1 |
|---|---|---|---|
| Frontend (Next.js) | **Vercel** | Hobby | 0 €/mes |
| Backend (NestJS) | **Railway** o **Render** | Free tier | 0 €/mes |
| Base de datos | **Supabase** | Free tier | 0 €/mes |
| Email | **Resend** | Free tier | 0 €/mes |

**Railway vs Render para NestJS:**
- Railway: mejor DX, deploy desde git, free tier con créditos mensuales
- Render: free tier siempre activo (con cold start en inactividad), más predecible

🟡 Decidir al hacer el primer deploy. Para Tier 1 ambas son válidas.

---

## Contexto del agente IA en dos repos

El directorio `docs/` (documentación estratégica) vive en el repo del **frontend**. Cuando se trabaje en el repo del backend, el agente no tendrá ese contexto automáticamente.

**Solución:** el repo del backend tiene su propio `CLAUDE.md` que:
1. Define el rol del agente en el contexto del backend (NestJS, patrones, DTOs)
2. Indica explícitamente que el contexto estratégico vive en el repo frontend
3. Incluye las instrucciones de comportamiento y convenciones de código

El `CLAUDE.md` del backend no replica los docs estratégicos — los referencia.

---

## Consecuencias

**Positivas:**
- Cada repo tiene su propio ciclo de deploy — un fallo en el backend no bloquea el frontend
- La complejidad de cada proyecto crece de forma independiente
- En Tier 2–3 se puede escalar el backend horizontalmente sin tocar el frontend

**A gestionar:**
- Los tipos compartidos se duplican en Tier 1 — documentar explícitamente qué DTOs están duplicados
- El agente necesita cambiar de directorio para trabajar en cada repo — tenerlo en cuenta en el flujo de sesiones
- CORS debe estar bien configurado desde el primer deploy

**No aplica:**
- Turborepo, pnpm workspaces, shared packages — no se necesita en Tier 1

---

*→ Guardado en: `docs/tech/adr/ADR-003-backend-architecture.md`*
