# T-112 Quick Reference — Supabase Setup

**Cuando estés listo para configurar Supabase, sigue estos pasos.**

---

## ⚡ Versión rápida (5 pasos)

### 1️⃣ Sign up en Supabase
```
https://supabase.com → Sign up → GitHub (recomendado)
```

### 2️⃣ Crear proyecto
```
Dashboard → New Project
  Name: sinagencias-tier1
  Password: [generar fuerte]
  Region: Europe (Ireland o Madrid)
```
⏳ Esperar 3-5 minutos

### 3️⃣ Crear tabla (copiar y ejecutar en SQL Editor)
```sql
CREATE TABLE subscribers (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  email text NOT NULL UNIQUE,
  rgpd_consent boolean NOT NULL,
  created_at timestamp with time zone DEFAULT now() NOT NULL,
  updated_at timestamp with time zone DEFAULT now() NOT NULL
);
CREATE INDEX idx_subscribers_email ON subscribers(email);
CREATE INDEX idx_subscribers_created_at ON subscribers(created_at);
```

### 4️⃣ Copiar API keys
```
Settings → API → Copiar:
  • Project URL → SUPABASE_URL
  • anon key → SUPABASE_ANON_KEY
  • service_role key → SUPABASE_SERVICE_KEY
```

### 5️⃣ Actualizar `.env`
```bash
# Opción A: Interactiva (recomendada)
./setup-env.sh
# Te pedirá los valores, los copia automáticamente

# Opción B: Manual
# Edita api/.env y reemplaza los placeholders
nano api/.env
```

---

## 🧪 Verificar que funciona

```bash
# Terminal 1: Iniciar API
cd api
npm run start:dev

# Terminal 2: Test endpoint
curl -X POST http://localhost:3001/subscribers \
  -H "Content-Type: application/json" \
  -d '{"email":"test@example.com","rgpdConsent":true}'

# Debería devolver: 201 Created
```

---

## 📚 Documentación completa

Para más detalles → `api/SUPABASE-SETUP.md`

---

## 🚀 Después de T-112

- **T-122:** Deploy infrastructure (Vercel + dominio)
- **Testing:** Probar endpoint con curl/Postman
- **T-114:** Construir T3 (IRPF) en frontend
