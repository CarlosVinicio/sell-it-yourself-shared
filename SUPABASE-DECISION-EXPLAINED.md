# ¿Por qué Supabase? Decisión documentada

Justificación completa de por qué Supabase es la opción para Tier 1, y cómo migrar en el futuro.

---

## TL;DR

```
Tier 1 (Ahora):        Supabase free tier      (0 €/mes)
Tier 2 (En 6 meses):   DigitalOcean Postgres   (80 €/mes)
Tier 3 (En 18 meses):  AWS RDS + Redis         (500+ €/mes)
```

**Razón:** Cero coste + PostgreSQL real + fácil de migrar = Supabase ganador para Tier 1.

---

## Decisión Tier 1: Supabase

### ✅ Por qué elegimos Supabase

| Criterio | Supabase | Firebase | MongoDB | SQLite |
|----------|----------|----------|---------|--------|
| **Coste Tier 1** | 0 € ✅ | 0 € | 0 € | 0 € |
| **PostgreSQL real** | ✅ | ❌ | ❌ | ✅ (pero no escalable) |
| **Escalable a Tier 2+** | ✅ | ❌ | ❌ | ❌ |
| **Auth nativa** | ✅ | ✅ | ❌ | ❌ |
| **Relaciones SQL (inmuebles)** | ✅ | ❌ (NoSQL) | ❌ (NoSQL) | ✅ (pero no escalable) |
| **DX (Developer Experience)** | Excelente ✅ | Buena | Buena | Básica |

**Ganador:** Supabase ✅

### ❌ Por qué NO elegimos las alternativas

**Firebase Firestore:**
```
Real estate data es RELACIONAL:
  Inmueble ←→ Usuario ←→ Visitas ←→ Documentos ←→ Mensajes

Firestore (NoSQL) requeriría:
- Desnormalizar datos (duplicación)
- Queries complejas en código (lento)
- Schema migrations manualmente

Descartado. ❌
```

**MongoDB:**
```
Free tier: 512MB
Tier 2 necestaría ~10GB (resultados guardados + users)

MongoDB Atlas gratuito no scale.
Self-hosted = Ops from day 1.

Descartado. ❌
```

**SQLite:**
```
Tier 1: Una tabla = SQLite podría funcionar
Tier 2: Varias tablas + índices + usuarios concurrentes
  SQLite no es multi-user friendly
  Migración SQLite → Postgres = dolorosa

Descartado. ❌
```

---

## Tier 2: Plan de migración (Si crece)

**Trigger:** Si en Tier 2 el coste de Supabase > 150 €/mes

### Opción A: DigitalOcean Managed PostgreSQL (Recomendada)

```
Coste:   80–150 €/mes  (vs. Supabase Pro 150+)
Downtime: 5 minutos
Esfuerzo: 15 horas de migration
Riesgo:  Bajo (mismo Postgres)
```

**Pasos:**
1. Crear cluster PostgreSQL en DigitalOcean (30 min)
2. Exportar schema + data de Supabase (`pg_dump`)
3. Importar en DigitalOcean (`psql < backup.sql`)
4. Cambiar `SUPABASE_URL` → `DATABASE_URL` en .env
5. Actualizar código: cliente de Supabase → pg driver
6. Testing intenso (4 horas)
7. Cutover en 5 minutos (scale API to 0 → update DB → scale back)

**Por qué DigitalOcean:** 
- Mismo Postgres (sin lock-in)
- Precio justo
- Tooling excelente
- Sin sorpresas

---

## Tier 3: AWS RDS (Marketplace transaccional)

**Si en Tier 3 el volumen es grande (500K+ users, 1M+ listings):**

```
Coste:   500–2000 €/mes
Setup:   2–3 días (requiere DevOps)
Esfuerzo: Alto
Riesgo:  Bajo si se hace bien
```

**Ventajas:**
- Auto-scaling
- Connection pooling nativo (RDS Proxy)
- Multi-AZ failover automático
- Aurora PostgreSQL (mejor performance)
- Soporte 24/7 si lo necesitas

---

## Vendor Lock-in Risk

### Tier 1: 🟢 BAJO
```
Schema simple: 1 tabla
Fácil exportar/importar
No depended de features específicas Supabase
Riesgo: Mínimo ✅
```

### Tier 2: 🟡 MEDIO
```
Supabase Auth es native (JWT exportable)
Supabase Storage para documentos (migratable)
Riesgo: Moderado — necesita planning en migration
```

### Tier 3: 🔴 ALTO
```
RLS (Row-Level Security) es Supabase-specific
Storage distribuido
Riesgo: Alto — por eso migramos ANTES de Tier 3
```

**Estrategia:** Migrar de Supabase a DigitalOcean en Tier 2, antes de que Tier 3 lo complique.

---

## Documentación generada

| Documento | Propósito |
|-----------|-----------|
| **ADR-006** | Justificación de decisión + alternativas |
| **database-migration-strategy.md** | Pasos concretos para migrar |
| **SUPABASE-SETUP.md** | Setup Supabase hoy |
| **Este archivo** | Resumen ejecutivo |

---

## Timeline de revisión

```
2026-05-01: Decidido → Supabase free
2026-11-01: Revisar coste Tier 2 (target)
  - Si usuarios < 50K: Mantener Supabase
  - Si usuarios > 50K + coste > 150€: Evaluar DigitalOcean
  
2027-01-01: Revisar Tier 3
  - Si marketplace necesario: AWS RDS
  - Si seguimos siendo herramientas: Supabase funciona
```

---

## Resumen: Por qué esta decisión es buena

✅ **Ahora:**
- Cero coste
- PostgreSQL real (no vendor lock-in inmediato)
- Fácil de usar
- Escala para Tier 1 sin problemas

✅ **Futuro:**
- Camino claro a migrar (DigitalOcean, AWS)
- No hay sorpresas técnicas
- Documentado cómo hacerlo

✅ **Riesgo manejado:**
- Tier 1: Lock-in bajo
- Tier 2: Lock-in medio (mitigable)
- Tier 3: Migramos ANTES para evitar lock-in alto

---

**Documentación completa:**
- Decisión: `api/docs/tech/adr/ADR-006-database-supabase.md`
- Migración: `api/docs/tech/api/database-migration-strategy.md`
