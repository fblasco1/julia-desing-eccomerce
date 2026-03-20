# Julia Design — qué se edita desde el panel de Tienda Nube

## Dónde está el home Julia

En el administrador: **Diseño → Editar diseño** (o **Personalizar diseño**).

En el **menú lateral** del editor aparece una sección propia llamada **«Julia Design»** (no está dentro de «Página de inicio»). Ahí están todos los campos del hero, carrusel, beneficios y editorial.

> **Importante:** la lista de la **«Página de inicio»** con íconos de ojo es el **orden de módulos del theme base** (slider clásico, bienvenida, productos destacados del listado, etc.). El **inicio que ves en la tienda Julia** se arma con los bloques de **«Julia Design»**; es normal que esa lista no controle esos bloques.

### Visibilidad de bloques

Al inicio de **«Julia Design»** podés activar o desactivar cada bloque del inicio (hero, beneficios, carrusel de destacados, editorial) sin tocar código.

### Productos del carrusel

El carrusel horizontal usa los **productos destacados** que configurás en el administrador de la tienda (sección **Destacados** / `sections.primary` del theme), no el orden de «Productos destacados» del listado clásico del home.

---

| Grupo | Qué configurás |
|--------|-----------------|
| **Hero** | Foto principal, logo/gráfico sobre el texto, título (2 líneas), párrafo, textos y URLs de los dos botones/enlaces. |
| **Carrusel** | Imagen de fondo de la sección, watermark grande, imagen decorativa extra, hasta 4 textos grandes de fondo, texto del botón «Ver todo el catálogo». |
| **Beneficios** | Títulos, intro y los 5 ítems de la lista. |
| **Editorial** | Dos columnas: título, texto, enlace (texto + URL), imagen cada una. |

Si un **texto** queda vacío, el theme usa el valor por defecto (los textos que ya venían en el diseño).

### Imágenes: nombres nuevos vs. respaldo

El panel genera archivos con estos nombres en los archivos estáticos del theme:

- `julia_home_hero.jpg`, `julia_home_hero_logo.png`
- `julia_catalog_section_bg.jpg`, `julia_catalog_watermark.png`, `julia_catalog_deco_extra.png`
- `julia_editorial_01.jpg`, `julia_editorial_02.jpg`

Si no subís la versión nueva, siguen valiendo los archivos antiguos por FTP, por ejemplo `julia-spruce-hero.jpg` y `julia-spruce-bg-logo.png` (ver `docs/LOGOS-JULIA-DESIGN.md`).

---

## Pie de página (mapa y columnas)

En **Pie de página** → bloque **«Julia Design — Pie de página»**:

- Títulos opcionales de las columnas (menú, contacto, showroom).
- **Código HTML del mapa:** en Google Maps: **Compartir → Insertar un mapa** y pegá el `<iframe>...</iframe>` completo.

Para el **índice de páginas**, activá **Mostrar menú** y elegí el menú inferior (como siempre en Tienda Nube: **Menúes** en la misma sección del pie).

Para **contacto**, activá **Mostrar datos de contacto** y completá teléfono, mail, dirección, etc. en los datos de la tienda.

**Logo en el pie:** por defecto no se muestra aunque hayas subido imagen; activá **Mostrar en el pie la imagen de «Logo»** en **Pie de página** si lo querés.

El **newsletter ya no se muestra** en el pie de este theme (`footer.tpl`), aunque la opción «Newsletter» siga existiendo en la configuración del theme por compatibilidad. El valor por defecto de `news_show` en `config/defaults.txt` está en **0** para tiendas nuevas.
