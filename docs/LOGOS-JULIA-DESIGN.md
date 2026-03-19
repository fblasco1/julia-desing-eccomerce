# Dónde se cargan los logos (Julia Design + Tienda Nube)

## 1. Logo del header (el que ves arriba al centro)

- **Desde el administrador de Tienda Nube** (no es un archivo suelto en el código del theme).
- Ruta típica: **Diseño → Personalizar diseño** (o **Configuración de la tienda / datos de la tienda**, según tu panel) → sección de **Logo**.
- El theme lo renderiza con el componente nativo: `component('logos/logo')` en `snipplets/header/header.tpl`.
- Ahí subís el PNG/JPG/SVG **principal** (ideal: versión clara si el header es oscuro, como en Julia).

## 2. Imágenes extra solo para este theme (FTP / archivos del theme)

Van en la carpeta **`static/images/`** del theme (o las subís por **FTP de archivos del diseño** que ofrece TN, con el nombre exacto).

| Archivo | Uso |
|--------|-----|
| `julia-spruce-hero.jpg` | Imagen grande del **hero** (mitad izquierda). Si no existe, se usa la primera imagen del **slider del home** configurado en el admin, o fondo gris. |
| `julia-spruce-hero-logo.png` | Logo **grande translúcido** detrás del texto del hero (opcional). |
| `julia-spruce-bg-logo.png` | Logo **grande translúcido** detrás del **carrusel** de productos (opcional). |

En las plantillas se detectan con el filtro **`has_custom_image`** (convención de Tienda Nube para imágenes custom del theme).

## 3. Logo transparente para header claro / oscuro (Base Theme)

Si en el futuro usás cabecera transparente del Base, TN suele ofrecer también **logo alternativo** (p. ej. `logo-transparent.jpg`) desde la misma personalización. Julia hoy usa un solo logo vía `component('logos/logo')`.

---

**Resumen:** el logo del **navbar** = **admin de la tienda**. Los fondos editoriales del **home** = archivos en **`static/images/`** con los nombres de la tabla (o slider del admin para el hero si no cargás `julia-spruce-hero.jpg`).
