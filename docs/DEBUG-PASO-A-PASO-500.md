# Debug paso a paso — error 500 en el theme

## Causa frecuente ya corregida en repo

En `layouts/layout.tpl` el link a `julia-prototype` estaba “comentado” como **`<#link ... #>`**, que **no es comentario Twig**. Las expresiones `{{ ... }}` seguían ejecutándose y el HTML quedaba inválido. Los comentarios Twig son **`{# ... #}`** y deben envolver **toda** la línea si querés ocultar el `link`.

---

## Fase A — Confirmar que la tienda puede renderizar (layout mínimo)

1. En tu máquina, **respaldá** `theme/layouts/layout.tpl` (copia con otro nombre o git).
2. **Copiá** el contenido de `theme/layouts/layout-diagnostico.tpl` **sobre** `theme/layouts/layout.tpl` (o renombrá: `layout.tpl` → `layout-backup.tpl`, `layout-diagnostico.tpl` → `layout.tpl`).
3. **Subí** solo `layouts/layout.tpl` al theme activo (o sync completo si usás CLI).
4. Abrí la tienda en el navegador.

| Resultado | Significado |
|-----------|-------------|
| Ves **“Diagnóstico OK”** | El servidor compila plantillas y `head_content` + `template_content` funcionan. El 500 viene de **algo del layout completo** (CSS, snipplets, JS includes, etc.). Seguir **Fase B**. |
| **Sigue 500** | Problema fuera del layout (config del theme en la tienda, `templates/` rotos, caché, theme equivocado). Revisar en admin qué theme está activo y volver a subir. |

5. **Restaurá** `layout.tpl` desde el respaldo antes de seguir.

---

## Fase B — Mitad del layout (sin tocar la otra mitad)

Trabajá sobre una **copia** de `layout.tpl` o con git por pasos. Idea: **desactivar bloques enteros** con comentarios Twig `{# ... #}`.

### B1 — Solo `<head>` mínimo + cuerpo vacío

Dejá en el `<head>` únicamente:

- meta charset / viewport  
- `<title>{{ page_title }}</title>`  
- `{% head_content %}`  

**Quitá** (comentá todo el bloque):

- `preload-images` snipplet  
- `component('social-meta')`  
- `<style>` con fonts + `style-critical.tpl`  
- `style-colors` static_inline  
- `style-async` link  
- link julia-prototype  
- `load_jquery`  
- `component('structured-data')`  

En el `<body>` dejá solo:

- `{{ back_to_admin }}`  
- `{% template_content %}`  

**Sin** `header/header.tpl`, **sin** scripts al final, **sin** modal overlay.

Subí y probá. Si **200 OK** → el fallo está en algo que sacaste (head pesado o body con header/js).

### B2 — Restaurar solo CSS (sin header ni JS)

Volvé a añadir **en orden**, probando después de cada uno:

1. `{% snipplet 'preload-images.tpl' %}`  
2. `{{ component('social-meta') }}`  
3. Bloque `<style>` + `{% include "static/css/style-critical.tpl" %}`  
4. `{{ 'css/style-colors.scss.tpl' | static_url | static_inline }}`  
5. `<link ... style-async.scss.tpl ...>`  

Si el 500 aparece al sumar **un** paso, ese archivo (`style-colors`, `style-async`, `style-critical`) o el snipplet es el sospechoso.

### B3 — Header

Añadí `{% snipplet "header/header.tpl" %}` y el overlay modal. Si falla → revisar **snipplets** que incluye el header (navegación, modales).

### B4 — Scripts finales

Añadí el bloque `<script>` con:

1. Solo `external-no-dependencies.js.tpl`  
2. Luego el `LS.ready.then` con `external.js.tpl`  
3. Por último `store.js.tpl`  

Si el 500 aparece al incluir **solo** `store.js.tpl` → error de **sintaxis Twig** dentro de ese archivo (no de lógica JS en el cliente).

---

## Fase C — Si el fallo es un `.scss.tpl`

- **style-async**: comentá el link y probá.  
- **julia-prototype**: debe estar en comentario Twig correcto:  
  `{# <link rel="stylesheet" href="{{ 'css/julia-prototype.scss.tpl' | static_url }}" ...> #}`

---

## Fase D — Herramientas

- **Editor de código del theme** en Tienda Nube (Diseño → tema → editar): a veces muestra el mensaje de error al guardar.  
- **Git / diff**: comparar `layout.tpl` y `store.js.tpl` con la última versión que **sí** funcionaba.

---

## Resumen

1. Corregir comentarios Twig (`{# ... #}`), nunca `<# ... #>` en tags HTML.  
2. `layout-diagnostico.tpl` → prueba base.  
3. Ir sumando bloques del layout real hasta reproducir el 500; el último bloque añadido señala el archivo a revisar.
