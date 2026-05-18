# Documentation Sync — SINAGENCIAS.ES

Automatiza la sincronización de documentación compartida entre repos `web/` y `api/`.

---

## 📋 ¿Qué se sincroniza?

### Documentación compartida (ambos repos)
```
docs/memory/context.md         ← Estado actual del proyecto
docs/memory/decisions.md       ← Decisiones tomadas (D-001 a D-010)
docs/memory/pending.md         ← Tareas pendientes, completadas
docs/ROADMAP-TIERS.md          ← Roadmap del producto
```

### Referencias (API copia del web)
```
docs/tech/adr/                 ← Decisiones de arquitectura
docs/legal/compliance/         ← Requisitos RGPD y compliance
```

---

## 🚀 Uso rápido

### Sincronizar web → api (por defecto)
```bash
./sync-docs.sh
# o explícitamente:
./sync-docs.sh web-to-api
```

### Sincronizar api → web
```bash
./sync-docs.sh api-to-web
```

### Sincronizar bidireccional
```bash
./sync-docs.sh both
```

### Con auto-commit
```bash
./sync-docs.sh web-to-api --commit
```

### Con verbose (ver detalles)
```bash
./sync-docs.sh web-to-api --verbose
```

### Combinar opciones
```bash
./sync-docs.sh both --commit --verbose
```

---

## 🔧 Git Hook (Automatización)

Para sincronizar automáticamente después de cada commit:

### 1. Crear post-commit hook en web repo
```bash
cat > web/.git/hooks/post-commit << 'EOF'
#!/bin/bash
# Auto-sync docs after commit
cd "$(git rev-parse --show-toplevel)/.."
./sync-docs.sh web-to-api --commit --verbose 2>/dev/null || true
EOF

chmod +x web/.git/hooks/post-commit
```

### 2. Crear post-commit hook en api repo
```bash
cat > api/.git/hooks/post-commit << 'EOF'
#!/bin/bash
# Auto-sync docs after commit
cd "$(git rev-parse --show-toplevel)/.."
./sync-docs.sh api-to-web --commit --verbose 2>/dev/null || true
EOF

chmod +x api/.git/hooks/post-commit
```

### 3. Verificar hooks instalados
```bash
ls -la web/.git/hooks/post-commit api/.git/hooks/post-commit
```

---

## 📊 Ejemplos de flujo

### Escenario 1: Actualizas `pending.md` en web
```bash
cd web
# ... editas docs/memory/pending.md
git add docs/memory/pending.md
git commit -m "docs: update pending tasks"
# ✓ Hook detecta cambio
# ✓ Auto-sincroniza a api/
# ✓ Auto-commit en api repo
```

### Escenario 2: Actualizas `context.md` en api
```bash
cd api
# ... editas docs/memory/context.md
git add docs/memory/context.md
git commit -m "docs: update context"
# ✓ Hook detecta cambio
# ✓ Auto-sincroniza a web/
# ✓ Auto-commit en web repo
```

### Escenario 3: Necesitas sincronizar manual
```bash
# Desde la raíz del proyecto
./sync-docs.sh both --commit --verbose
# Sincroniza ambas direcciones y hace commits
```

---

## ⚠️ Notas importantes

### Evita conflictos
- Si editas el mismo archivo en ambos repos casi al mismo tiempo, el hook puede generar conflictos
- **Solución**: Usa `./sync-docs.sh` manualmente antes de hacer cambios importantes

### Hook vs. Manual
- **Hook (automático):** Útil para cambios frecuentes, mantiene sincronía perfecta
- **Manual (script):** Útil cuando haces cambios importantes o quieres revisar antes

### Deshabilitar hook temporalmente
```bash
# En web o api repos:
chmod -x .git/hooks/post-commit  # Deshabilita
chmod +x .git/hooks/post-commit  # Re-habilita
```

### Ver cambios antes de sincronizar
```bash
# Ver qué cambió en memory/
git diff api/docs/memory/
git diff web/docs/memory/

# Luego sincroniza
./sync-docs.sh web-to-api --verbose
```

---

## 🔍 Troubleshooting

### "Error: web/ and api/ directories not found"
- Ejecuta el script desde `/Documents/Personal/Proyectos/SinAgencias`

### El hook no se ejecuta
- Verifica que sea ejecutable: `ls -la .git/hooks/post-commit`
- Verifica que esté bien ubicado en ambos repos

### Conflictos después de sincronización
```bash
# Revisa qué cambió:
git status
git diff

# Resuelve conflictos manualmente si existen
git add -A
git commit -m "fix: resolve sync conflicts"
```

### Quiero desactivar el hook
```bash
rm web/.git/hooks/post-commit
rm api/.git/hooks/post-commit
```

---

## 📅 Mantenimiento

El script es independiente de git hooks. Ambos pueden coexistir:
- **Hooks:** Sincronización automática en cada commit
- **Script manual:** Control explícito cuando lo necesitas

Si el hook genera problemas, puedes desactivarlo y usar el script manualmente.

---

## 📝 Workflow recomendado

1. **Edita documentación** en `web/` o `api/`
2. **Commit localmente** con `git commit`
3. **Hook se ejecuta automáticamente** (si está instalado)
4. **Verifica sincronización:** `git log --oneline` (debería haber dos commits)
5. **Si hay conflictos:** Ejecuta `./sync-docs.sh [direction] --verbose`

---

## Comandos útiles

```bash
# Ver qué se sincroniza
./sync-docs.sh web-to-api --verbose

# Sincronizar sin auto-commit (revisar antes)
./sync-docs.sh web-to-api

# Instalar hooks en ambos repos
chmod +x web/.git/hooks/post-commit api/.git/hooks/post-commit

# Ver cambios antes de sincronizar
cd web && git diff docs/memory/
cd api && git diff docs/memory/
```
