# Dónde se cargan los logos e imágenes (Julia Design + Tienda Nube)

## 1. Logo del header (el que ves arriba al centro)

- **Desde el administrador de Tienda Nube** (no es un archivo suelto en el código del theme).
- Ruta típica: **Diseño → Personalizar diseño** → **Logo**.
- El theme lo renderiza con el componente nativo: `component('logos/logo')` en `snipplets/header/header.tpl`.

## 2. Home Julia — preferentemente desde el panel (recomendado)

En **Diseño → Editar diseño → Página de inicio → Julia Design — Inicio (hero, carrusel y bloques)** subís las imágenes con nombres fijos que genera el theme. Detalle en **`docs/JULIA-PANEL-SETTINGS.md`**.

## 3. Archivos por FTP (respaldo / migración)

Si ya tenías imágenes subidas solo por FTP en **`static/images/`**, el theme las sigue usando si no cargás la versión nueva desde el panel:

| Archivo (FTP) | Uso |
|----------------|-----|
| `julia_home_hero.jpg` | Hero (prioridad si existe; si no, ver abajo). |
| `julia-spruce-hero.jpg` | Hero alternativo si no hay `julia_home_hero.jpg`. |
| `julia_home_hero_logo.png` | Logo/gráfico sobre el texto del hero. |
| `julia-spruce-hero-logo.png` | Mismo rol, nombre anterior. |
| `julia_catalog_section_bg.jpg` | Fondo de la sección del carrusel (desde panel). |
| `julia_catalog_watermark.png` | Watermark grande detrás del carrusel (desde panel). |
| `julia-spruce-bg-logo.png` | Watermark si no subiste `julia_catalog_watermark.png`. |
| `julia_catalog_deco_extra.png` | Segunda decoración de fondo (opcional). |

En las plantillas se detectan con el filtro **`has_custom_image`** (convención de Tienda Nube).

## 4. Logo transparente para header claro / oscuro (Base Theme)

Si en el futuro usás cabecera transparente del Base, TN suele ofrecer también **logo alternativo** (p. ej. `logo-transparent.jpg`) desde la misma personalización. Julia hoy usa un solo logo vía `component('logos/logo')`.

---

**Resumen:** logo del **navbar** = **admin de la tienda**. Contenido visual del **home Julia** = **panel del theme** (sección Julia Design) y, en su defecto, archivos en **`static/images/`** con los nombres de la tabla.
