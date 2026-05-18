# Quick Start — Documentation Sync

Automatización de sincronización en 2 minutos.

---

## 🚀 Opción 1: Setup automático (Recomendado)

```bash
cd /Documents/Personal/Proyectos/SinAgencias

# Instalar git hooks (una sola vez)
./install-sync-hooks.sh

# ✓ Listo. A partir de ahora, cada commit sincroniza automáticamente
```

**Qué hace:** Después de cada `git commit` en web/ o api/, el hook sincroniza automáticamente la documentación compartida al otro repo.

---

## 📋 Opción 2: Sincronización manual

```bash
# Desde raíz del proyecto
./sync-docs.sh web-to-api     # web → api (defecto)
./sync-docs.sh api-to-web     # api → web
./sync-docs.sh both           # ambas direcciones

# Con auto-commit incluido
./sync-docs.sh web-to-api --commit

# Ver detalles
./sync-docs.sh web-to-api --verbose
```

---

## 📁 Ubicación de scripts

```
/Documents/Personal/Proyectos/SinAgencias/
├── sync-docs.sh               ← Script principal (ubicación preferida)
├── install-sync-hooks.sh      ← Installer de hooks
├── SYNC-DOCS-README.md        ← Documentación completa
└── SYNC-QUICK-START.md        ← Este archivo
```

**Copias en repos:**
```
web/sync-docs.sh              ← Backup en web repo
api/docs/sync-docs.sh         ← Backup en api repo
```

---

## ✅ Verificar que funciona

### Opción 1: Con hooks instalados
```bash
cd web
# Edita cualquier archivo en docs/memory/
git add docs/memory/
git commit -m "test: update memory"
# ✓ Hook se ejecuta automáticamente
# ✓ Api repo se sincroniza automáticamente
git log --oneline   # verás un commit de "auto-sync" si hubo cambios
```

### Opción 2: Manual
```bash
# Edita en web/
git add docs/memory/
git commit -m "docs: update"

# Sincroniza manualmente
./sync-docs.sh web-to-api --commit --verbose
```

---

## 📊 Qué se sincroniza automáticamente

| Archivo | Dirección |
|---------|-----------|
| `docs/memory/context.md` | ⟷ Bidireccional |
| `docs/memory/decisions.md` | ⟷ Bidireccional |
| `docs/memory/pending.md` | ⟷ Bidireccional |
| `docs/ROADMAP-TIERS.md` | ⟷ Bidireccional |
| `docs/tech/adr/` | web → api (solo lectura en API) |
| `docs/legal/compliance/` | web → api (solo lectura en API) |

---

## 🛑 Si algo sale mal

```bash
# Ver qué está sin sincronizar
git diff api/docs/memory/web/docs/memory/

# Sincronizar manualmente sin auto-commit
./sync-docs.sh both --verbose

# Ver cambios antes de commitear
git status
```

---

## 🎯 Workflow recomendado

1. **Edita documentación** donde estés trabajando
2. **Commit con normalidad** (`git commit`)
3. **Hook se encarga** de sincronizar (si está instalado)
4. **Verifica sincronización** con `git log` (busca commits de "auto-sync")

---

## 🔧 Mantenimiento

| Tarea | Comando |
|-------|---------|
| Ver si hooks están instalados | `ls -la web/.git/hooks/post-commit api/.git/hooks/post-commit` |
| Desinstalar hooks | `rm web/.git/hooks/post-commit api/.git/hooks/post-commit` |
| Reinstalar hooks | `./install-sync-hooks.sh` |
| Sincronizar manualmente | `./sync-docs.sh both --commit` |

---

**Más detalles:** Lee `SYNC-DOCS-README.md`
