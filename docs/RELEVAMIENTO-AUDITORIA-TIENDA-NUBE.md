# Relevamiento — Auditoría tema Julia Design (Tienda Nube)

**Fecha:** 2026-03-20  
**Alcance:** carpetas `config/`, `layouts/`, `snipplets/`, `static/`, `templates/` (copia local alineada con descarga FTP / repo).  
**Objetivo:** identificar causas típicas de fallo del tema en el admin y en el front (“inconvenientes con el servidor”, sección Julia Design inaccesible, home rota).

---

## 1. Resumen ejecutivo

| Área | Estado en copia auditada | Riesgo |
|------|-------------------------|--------|
| `config/settings.txt` | **~1355 líneas**, secciones de nivel superior completas | **Alto si el archivo en el servidor está truncado** (~590 líneas); Tienda Nube suele fallar al parsear `settings.txt` incompleto. |
| `layouts/layout.tpl` | Presente, carga crítica de CSS/JS y snipplets coherentes | Bajo |
| `templates/home.tpl` | Solo Julia + popup opcional | Bajo (depende de snipplets Julia) |
| Snipplets Julia (`julia-home*.tpl`) | Presentes | Bajo |
| `static/` | SCSS + `julia-spruce-theme.tpl` + JS carrusel | Bajo |
| `config/data.json` | Válido JSON, preview con `style-tokens.tpl` | Bajo |

**Conclusión:** La causa raíz del incidente reportado en el historial del proyecto fue casi seguro un **`config/settings.txt` truncado** (se eliminaron cientos de líneas en un commit local). Eso invalida el esquema del personalizador y puede provocar error genérico de servidor y bloqueo de secciones avanzadas. **En la copia actual del proyecto el `settings.txt` está completo**; si el FTP del servidor aún tiene la versión corta, el fallo persistirá hasta **resubir el archivo completo**.

---

## 2. Inventario rápido

### 2.1 `config/`

| Archivo | Rol |
|---------|-----|
| `settings.txt` | Define el panel de personalización (secciones, tipos de campo, paletas, Julia Design, home base, listado, producto, carrito, footer, CSS). **Es el archivo más crítico para que el admin no rompa.** |
| `defaults.txt` | Valores por defecto al instalar / resetear opciones. |
| `variants.txt` | Presets por vertical; colores y fuentes iniciales por variante. |
| `sections.txt` | Etiquetas de secciones de producto (Destacados, Novedades, etc.). |
| `translations.txt` | Textos multiidioma del theme (no afecta parseo de `settings` salvo errores de formato). |
| `data.json` | Metadatos (p. ej. assets compilados en preview). |

**Verificación `settings.txt` (copia auditada):**

- **Líneas:** 1355 (indicador de archivo completo para este tema).
- **Secciones de nivel superior detectadas** (línea que empieza sin tabulación al inicio de línea):

  1. Colores de tu marca  
  2. Tipo de letra  
  3. Opciones de diseño  
  4. Encabezado  
  5. **Julia Design**  
  6. Página de inicio  
  7. Listado de productos  
  8. Detalle de producto  
  9. Carrito de compras  
  10. Pie de página  
  11. Edición avanzada de CSS  

- **Nota de diseño:** coexisten **Julia Design** (contenido custom Spruce) y **Página de inicio** (módulos del theme base). Es intencional: el admin puede orientar al merchant con `default` / `backto` hacia el orden de la home.

- **`palette_6`:** existe en combinaciones predeterminadas. Si en algún entorno la plataforma solo aceptara `palette_1`…`palette_5`, habría que probar quitar `palette_6`; **no hay evidencia en esta auditoría de que sea la causa del fallo principal** (el truncado es mucho más grave).

### 2.2 `layouts/`

| Archivo | Rol |
|---------|-----|
| `layout.tpl` | Documento HTML, `<head>` (fuentes Google Hanken Grotesk + Montserrat, tokens, critical/async CSS, `julia-spruce-theme.tpl`), cuerpo con `header/header.tpl`, `template_content`, quickshop, WhatsApp, `footer/footer.tpl`, scripts (`external-no-dependencies`, `external`, `store`), carrusel home. |

**Cadena crítica de dependencias:**

- `{% snipplet 'preload-images.tpl' %}`
- `{% include "static/css/style-tokens.tpl" %}`
- `{% include "static/css/julia-spruce-theme.tpl" %}`
- `{% include "static/js/external-no-dependencies.js.tpl" %}` (y resto en `LS.ready`)

Si falta alguno de estos archivos en el servidor, el error sería en **runtime** al renderizar, no necesariamente el mismo mensaje que con `settings.txt` roto.

### 2.3 `templates/`

| Plantilla | Observación |
|-----------|-------------|
| `home.tpl` | Incluye solo `snipplets/home/julia-home.tpl` + popup condicional `home-popup.tpl`. No usa `home-section-switch.tpl` en la home actual. |

### 2.4 `snipplets/` (Julia + header)

**Home Julia:**

- `home/julia-home.tpl` → condiciona bloques con `settings.julia_home_show_*`
- `julia-home-hero.tpl`, `julia-home-beneficios.tpl`, `julia-home-carousel.tpl`, `julia-home-editorial.tpl`

**Header:**

- `header/header.tpl` → Spruce: `julia-spruce-nav-links.tpl`, utilidades TN, modales.

**Verificación de includes:** los paths referenciados en `home.tpl`, `julia-home.tpl` y `layout.tpl` apuntan a archivos que **existen** en el árbol auditado.

### 2.5 `static/`

- `css/style-critical.scss`, `style-async.scss`, `style-colors.scss`
- `css/style-tokens.tpl` (variables desde `settings`)
- `css/julia-spruce-theme.tpl` (tokens marca Julia)
- `js/spruce-carousel.js` (cargado solo en `template == 'home'`)
- `js/*.js.tpl` (store, external, etc.)
- `checkout.scss.tpl`

---

## 3. Causa raíz del fallo (historial del proyecto)

1. **Commit problemático (referencia git):** `662ca87` — *Pruebas de settings* eliminó **~770 líneas** de `config/settings.txt`.
2. **Efecto:** el archivo dejó de declarar la mayoría de opciones del theme; la sección **Julia Design** quedó **cortada** y faltaban bloques enteros. Tienda Nube valida / parsea este archivo al cargar el personalizador.
3. **Síntomas coherentes:** “Inconvenientes con el servidor”, imposibilidad de abrir bien **Julia Design** en configuración avanzada, comportamiento errático del editor.
4. **Corrección aplicada en repo:** restauración del `settings.txt` completo (commit `0926eaf`, tag sugerido `estable-tiendanube`).

**Imperativo operativo:** el servidor FTP debe contener el **`settings.txt` completo** (orden de magnitud **>1300 líneas** para este tema). Si tras bajar por FTP el archivo tiene **~590 líneas**, el despliegue en servidor **no está alineado** con el repo corregido.

---

## 4. Otros riesgos y notas

### 4.1 Windows vs Linux en rutas

En el workspace local, herramientas pueden listar rutas como `snipplets\home\...` y `snipplets/home/...` (equivalentes en Windows). **En el servidor Tienda Nube (Linux)** las rutas deben ser consistentes; no subir carpetas duplicadas con nombres que solo difieren por mayúsculas.

### 4.2 Fuentes

- `layout.tpl` usa **`google_fonts_url`** con `settings.font_headings` y `settings.font_rest`, y además enlaces explícitos a **Hanken Grotesk** + **Montserrat**.
- Los valores en `settings` deben coincidir con familias cargables (p. ej. **Hanken Grotesk** en Google Fonts, etiqueta “HK Grotesk” en el panel).

### 4.3 `defaults.txt` y `variants.txt`

Deben ser coherentes con las **claves** definidas en `settings.txt`. Inconsistencias graves (nombres de setting inexistentes) suelen ignorarse o generar warnings según plataforma; lo crítico sigue siendo **`settings.txt` íntegro**.

---

## 5. Checklist post-deploy (FTP / editor TN)

- [ ] `config/settings.txt` en el servidor: **tamaño / líneas** similar al del repo (~1355 líneas).
- [ ] Primeras secciones del archivo: “Colores de tu marca”, “Tipo de letra”, …, “Julia Design”, “Página de inicio”, …
- [ ] Abrir en el admin: **Diseño → Personalizar → Julia Design** sin error.
- [ ] Home pública carga sin 500 (revisar plantilla `home.tpl` y snipplets `julia-home*.tpl` subidos).
- [ ] `layouts/layout.tpl` y `static/css/julia-spruce-theme.tpl` presentes y actualizados.

---

## 6. Archivos “mínimos vitales” para no romper el tema

Si solo pudieras verificar un subconjunto tras un deploy:

1. `config/settings.txt` (completo)  
2. `layouts/layout.tpl`  
3. `templates/home.tpl`  
4. `snipplets/home/julia-home.tpl` + los cuatro `julia-home-*.tpl`  
5. `snipplets/header/header.tpl` + `julia-spruce-nav-links.tpl`  
6. `static/css/style-tokens.tpl` + `julia-spruce-theme.tpl` + `style-critical.scss` + `style-async.scss` + `style-colors.scss`  
7. `static/js/spruce-carousel.js`  

---

## 7. Próximos pasos sugeridos

1. Comparar **hash o número de líneas** de `config/settings.txt` local vs el archivo en el FTP del servidor.  
2. Si difieren, **subir** el `settings.txt` completo del repo y vaciar caché / guardar tema en TN si aplica.  
3. Si el error continúa con `settings` correcto, revisar **log de error** en soporte TN o consola de red (respuesta 500) y cruzar con plantilla que falle (p. ej. typo en Twig).  

---

*Documento generado como relevamiento técnico; actualizar si cambia la estructura de `settings.txt` o el flujo de home.*
