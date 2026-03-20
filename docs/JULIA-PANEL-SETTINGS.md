# Julia Design — qué se edita desde el panel de Tienda Nube

En el administrador: **Diseño → Editar diseño** (o **Personalizar diseño**) → sección **Página de inicio** → colapsable **«Julia Design — Inicio (hero, carrusel y bloques)»**.

Ahí podés cambiar:

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

El **newsletter ya no se muestra** en el pie de este theme (`footer.tpl`), aunque la opción «Newsletter» siga existiendo en la configuración del theme por compatibilidad. El valor por defecto de `news_show` en `config/defaults.txt` está en **0** para tiendas nuevas.
