# ADR-005 — Adopción de shadcn/ui como sistema de componentes UI

| Campo | Valor |
|---|---|
| **ID** | ADR-005 |
| **Fecha** | 2026-04-27 |
| **Estado** | ✅ Aceptado |
| **Supersede** | D-012 (primitivos propios) |
| **Área** | Frontend — sistema de componentes |

---

## Contexto

Al iniciar el proyecto se planteó en D-012 usar primitivos UI escritos a mano con la misma API que shadcn (CVA + Tailwind), evitando ejecutar `shadcn add` por la preocupación de que reescribiera `globals.css` rompiendo el tema de D-011 (Tailwind v4 CSS-first).

Durante la sesión 3 se verificó en la documentación oficial de shadcn (`ui.shadcn.com/docs/react-19`) que shadcn v2+ soporta oficialmente Tailwind v4 y React 19. El sistema de variables CSS de shadcn es compatible con el esquema de dos niveles de Tailwind v4:

```css
/* Nivel 1 — variables semánticas (shadcn naming) */
@layer base {
  :root {
    --primary: oklch(58% 0.15 245);
    --muted-foreground: oklch(55% 0.02 250);
    /* … */
  }
}

/* Nivel 2 — utilidades Tailwind */
@theme inline {
  --color-primary: var(--primary);
  --color-muted-foreground: var(--muted-foreground);
  /* … */
}
```

Este esquema permite que `bg-primary`, `text-muted-foreground` etc. funcionen en componentes shadcn Y que `var(--color-primary)` siga funcionando en los componentes existentes del proyecto — sin romper nada.

---

## Decisión

**Adoptar shadcn/ui v2 como sistema de componentes base del proyecto.**

### Componentes instalados en Tier 1

```bash
npx shadcn@latest add button input label card badge accordion separator
```

> **Nota de entorno:** Usar `npx` en lugar de `pnpm dlx` — existe un bug de verificación de keyid en corepack que bloquea `pnpm dlx shadcn@latest` en el entorno local. No afecta al proyecto ni al CI.

### Cambios realizados en `globals.css`

- Migrado al sistema de dos niveles (ver contexto arriba).
- Añadidos `@keyframes accordion-down/up` + registro en `@theme inline` para animaciones Radix.
- Añadidos alias de compatibilidad (`--color-bg`, `--color-fg`, `--color-danger`, `--color-success`) para no romper los 20+ componentes existentes que usaban el sistema anterior.
- Renombradas 37 referencias `var(--color-muted)` → `var(--color-muted-foreground)` (mismatch semántico: en el sistema antiguo `--color-muted` era texto; en shadcn `--color-muted` es fondo de superficie).

### Posición en la arquitectura

```
src/components/ui/          ← generado por shadcn add (NO editar manualmente)
src/components/tool/        ← componentes de tool propios, consumen ui/
src/components/marketing/   ← componentes de landing, consumen ui/
src/features/*/components/  ← componentes de feature, consumen ui/ y tool/
```

---

## Alternativas consideradas

| Alternativa | Razón de descarte |
|---|---|
| Primitivos propios (D-012) | Mayor mantenimiento. Sin accesibilidad Radix (keyboard nav, focus trapping, aria). Deuda cuando el proyecto escale a modales, selects, tooltips en Tier 2–3. |
| Radix UI directo sin shadcn | Más boilerplate. shadcn ya proporciona el wrapper de Tailwind sobre Radix, no tiene sentido duplicar ese trabajo. |
| Headless UI (Tailwind Labs) | Ligado a React 18, ecosistema más pequeño, menos componentes. |
| MUI / Chakra | Demasiado opinionado visualmente. Conflictos con Tailwind. Bundle mayor. |

---

## Consecuencias

### Positivas
- Accesibilidad completa (keyboard nav, aria roles, focus management) en todos los componentes de Radix sin trabajo adicional.
- Animaciones del accordion y futuros dialogs/popovers funcionan out-of-the-box.
- Base escalable: para Tier 2–3 se añaden componentes con `npx shadcn@latest add dialog select combobox` sin reescribir nada.
- Los componentes son copy-paste en `src/components/ui/` — sin dependencia en tiempo de ejecución de shadcn (solo Radix + CVA).

### A tener en cuenta
- Los componentes en `src/components/ui/` son owned por el proyecto. Cuando shadcn publique actualizaciones, hay que re-ejecutar `npx shadcn@latest add <component>` manualmente o aplicar el diff a mano.
- No mezclar ediciones manuales en `src/components/ui/` con regeneraciones de shadcn — documentar cualquier customización en el propio archivo.
- El `components.json` en la raíz del proyecto configura shadcn (aliases, ruta de CSS, base color). No borrar.

---

## Referencias

- [shadcn/ui docs — React 19 + Tailwind v4](https://ui.shadcn.com/docs/react-19)
- `docs/memory/decisions.md` — D-011 (Tailwind v4), D-014 (adopción shadcn)
- `src/app/globals.css` — implementación del sistema de dos niveles
