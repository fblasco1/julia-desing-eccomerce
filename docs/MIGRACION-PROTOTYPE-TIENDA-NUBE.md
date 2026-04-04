# Migración del prototipo (`prototype/`) a plantillas Tienda Nube (Twig `.tpl`)

Este documento describe cómo llevar el HTML/CSS/JS estático del prototipo Julia a la estructura del **Theme Base** de Tienda Nube: `layouts/`, `templates/`, `snipplets/` y `static/`. Los productos en producción se identifican por **SKU** (y variantes) cargados en el admin de Tienda Nube; en las plantillas se consumen los objetos que expone el motor (producto, categoría, carrito, etc.), no HTML fijo por artículo.

---

## 1. Inventario del repositorio y páginas enlazadas

### 1.1 Archivos HTML en `prototype/` (inventario completo)

Hay **cinco** vistas estáticas; otras URLs solo aparecen como enlaces (no hay `.html` en la carpeta).

| Archivo | `<title>` / rol | Plantilla TN típica |
|--------|------------------|---------------------|
| `home.html` | Julia – Muebles; hero + info + carrusel exhibidor | `templates/home.tpl` + `snipplets/home/*` (o módulos equivalentes) |
| `productos.html` | Muebles; catálogo con tabs, filtros y grid | `templates/category.tpl` + `snipplets/grid/*` |
| `producto-detalle.html` | Sofá Aura (ejemplo); PDP 3 columnas | `templates/product.tpl` + `snipplets/product/*` |
| `quienes-somos.html` | Quienes Somos; imagen + copy institucional | `templates/page.tpl` (página TN) o `page` + snippet dedicado |
| `como-trabajamos.html` | Cómo Trabajamos; imagen + FAQ acordeón | Igual; contenido editable desde admin o bloques |

**Activos en la misma carpeta (no HTML):** `about-us.jpg`, `how-it-works.jpg`, `foto-muebles.png`, logos (`julia-logo-*.png`, `min-logo-blanco.png`).

**Assets migrados:** Los logos se gestionan vía `component('logos/logo')` del theme (configurables en el panel). Las imágenes institucionales (about-us.jpg, how-it-works.jpg) pueden subirse a `static/images/` y referenciarse con `{{ 'images/archivo.jpg' | static_url }}` en `snipplets/pages/about.tpl` y `how-it-works.tpl` si se añaden settings para ello.

### 1.2 Enlaces del prototipo sin archivo local

Rutas usadas en nav/footer pero **sin** prototipo en `prototype/`:

| Destino en enlaces | Plantilla TN típica |
|--------------------|---------------------|
| `/contacto` | `templates/contact.tpl`. **Nota:** Usar el formulario nativo del theme base (usualmente en `snipplets/contact-form.tpl`), manteniendo las clases CSS del framework de TN pero inyectando la estética de Julia (fuentes, bordes sutiles, botones). |
| `/terminos`, `/privacidad`, `/cookies` | Páginas legales en TN → `templates/page.tpl` |
| Búsqueda (botón nav) | `templates/search.tpl` si aplica |
| Carrito / checkout | `templates/cart.tpl` + flujo checkout del theme |

---

## 2. Principios de migración (obligatorios en Julia Design)

1. **No inventar variables Twig:** cada dato dinámico debe mapearse a la variable real del Theme Base o del objeto documentado por Tienda Nube. Donde no haya certeza, dejar `TODO: confirmar variable TN` en el `.tpl`.
2. **Separación:** maquetado y loops en `.tpl`; estilos en `static/css/*` (o `.scss.tpl` según el theme); interacción en JS vanilla bajo `static/js/*`.
3. **SKU y variantes:** el detalle de producto no es “una página por SKU”: es **una plantilla** que renderiza `product` (o el nombre que use tu theme) con `product.variants`, precio según variante seleccionada, stock, etc. El prototipo con swatches y precio simula lo que en TN suele enlazarse a opciones de variante.
4. **Categorías:** el listado del prototipo filtra por `data-category` y `?cat=`; en TN el filtro suele ser la **URL de categoría** o parámetros de colección. Los tabs “Sillas / Mesas / …” deben convertirse en enlaces a categorías reales o en la misma vista de categoría con contexto activo.

---

## 3. Mapa por página del prototipo

### 3.1 `productos.html` → categoría / listado

**Body / contexto**

- Clases de página: `page-light`, `catalog-page`.
- Comportamiento: `is-compact-catalog` (toolbar sticky), `nav.solid` al hacer scroll, mega menú, menú móvil.

**Bloques a extraer a snipplets (sugerido)**

| Bloque en HTML | Snipplet sugerido | Contenido dinámico en TN |
|----------------|-------------------|---------------------------|
| `<nav class="nav" id="navbar">` | `snipplets/header/header.tpl` (o el que use el theme) | Logo, enlaces, carrito, búsqueda: helpers del theme |
| Mega menú “Muebles” | Parcial dentro del header o `snipplets/navigation/*` | **TODO:** iterar categorías reales (`categories`, menú configurado, etc.) |
| `<main class="catalog">` | Cuerpo de `templates/category.tpl` + includes | Nombre de categoría / título de colección |
| `.catalog-toolbar` (tabs + ordenar + filtros) | `snipplets/grid/filters.tpl` o equivalente | Orden nativo TN, facetas, precio. |
| `.products-grid` + `.product-card` | `snipplets/grid/item.tpl` o `product-list.tpl` | Loop sobre productos de la categoría |
| `<footer>` | `snipplets/footer/footer.tpl` | Enlaces configurables o fijos según política |

**Tarjeta de producto (prototipo)**

- Estructura: `.product-card` con `data-category`, `data-price`, `data-colors`, `data-featured`, imagen, nombre, categoría textual, precio.
- En TN: un único bloque iterado, por ejemplo (nombres ilustrativos — **confirmar en theme**):
  - Imagen principal: imagen del producto / primera de galería.
  - Título: nombre del producto.
  - Categoría: categoría principal o breadcrumb.
  - Precio: precio con formato de moneda; si hay “desde”, lógica de variante mínima.
  - Enlace: URL canónica del producto (identidad interna por ID; el **SKU** se usa en variantes y en backoffice).

**JavaScript a migrar**

| Script actual | En Tienda Nube |
|---------------|----------------|
| `refreshCatalogSubnav`, `is-compact-catalog` | Mantener como JS del theme si el diseño lo requiere; enganchar a la misma estructura DOM conservando clases o `data-*`. |
| Tabs + filtros + orden + `applyFilters()` | **REEMPLAZAR TOTALMENTE.** Tienda Nube maneja los filtros por URL de forma nativa (ej. `/sillas/color-beige/`). Sustituir el filtrado por JS actual por la navegación a las URLs canónicas que genera Tienda Nube para las facetas (filtros de categoría y variantes). |
| `readCategoryFromUrl()` / `?cat=` | Alinear con slugs o IDs de categoría reales en URLs TN. |

**CSS**

- Mover reglas bajo un prefijo estable (p. ej. `.catalog`, `.product-card`, `.catalog-subnav`) a un archivo del theme (`static/css/...`) sin duplicar reset global si ya existe en el theme.

---

### 3.2 `producto-detalle.html` → ficha de producto

**Body / contexto**

- Clases: `page-light`, `pdp-page`.
- Variables CSS propias: `--pdp-edge`, `--pdp-col-gap`, `--pdp-sticky-top`, `--pdp-align-top`, `--pdp-back-stack-h`, etc.

**Estructura de tres columnas (desktop)**

| Columna | Clases prototipo | Snipplets / plantilla |
|---------|------------------|------------------------|
| Izquierda | `.pdp-col--left` > `.pdp-sidebar-sticky` | Descripción larga / texto editorial: campo de producto o metadato **TODO: confirmar** |
| Centro | `.pdp-col--center` > `.pdp-gallery-viewport` > `#pdpGallery` | Galería: imágenes del producto (y opcional video) — alinear con `snipplets/product/product-image.tpl` / thumbs |
| Derecha | `.pdp-col--right` > `.pdp-sidebar-sticky` > `.pdp-rail-right-inner` | Precio, variantes, CTA, acordeones (envío, pago, garantía). |

**Elementos concretos y Formulario de Compra**

| Elemento | Dato en TN (revisar nombre exacto en theme) |
|----------|---------------------------------------------|
| “Volver al catálogo” | Enlace a categoría padre o `history.back` / URL de colección |
| `h1` título | Nombre del producto |
| `.pdp-desc` | Descripción HTML o campo personalizado |
| Imágenes en `.pdp-slide` | Loop de imágenes del producto |
| Tabla `.pdp-specs` | Dimensiones/atributos: propiedades del producto o tabla custom |
| Swatches + `#pdpPrice` + `#pdpBuy` | **CRÍTICO:** El bloque de swatches y el botón de compra deben envolverse obligatoriamente en el `<form action="" method="post" data-store="product-form" ...>` requerido por Tienda Nube, usando los `name` attributes nativos para las variantes. |
| Acordeones | Textos estáticos en `.tpl` o desde configuración / snippets editables |

**Comportamiento y Fix del Sticky**

- **El Layout Sticky:** Las columnas laterales (izq/der) utilizan `position: sticky`. Para que se frenen en el margen inferior de la última imagen (columna central) y se oculten bajo el navbar al seguir bajando, **es vital que el contenedor padre (`.pdp-shell`) mantenga su estructura Grid/Flex con `align-items: stretch` o `start` y NUNCA se le aplique `overflow: hidden` ni `overflow-x: hidden`**. 
- El navbar debe tener siempre un `z-index` superior al contenido sticky.
- Scroll snap en `html:has(body.pdp-page)` (desktop): replicar solo si no entra en conflicto con el JS global de la tienda.
- Galería móvil: scroll horizontal en `.pdp-gallery`; en desktop, imágenes apiladas con scroll de página.

**JavaScript a migrar**

- Cambio de color/precio en prototipo: sustituir por eventos de variante del theme o implementar leyendo valores que Twig deje en `data-*` por variante.
- Eliminar cualquier lógica obsoleta de “rieles fijos” si ya migraste a sticky puro en flujo.

---

### 3.3 `home.html` → inicio

**Estructura principal**

| Sección (clase) | Contenido | Migración sugerida |
|-----------------|-----------|-------------------|
| `#navbar` + mega menú | Mismo patrón que resto del sitio | `snipplets/header/header.tpl` |
| `#logoEl` (`.logo-el`) | Logo flotante animado entre hero y nav | JS (`posLogo`, scroll, exhibidor): **unificar** con theme o mover a `static/js`; cuidado con CLS y con logo configurable TN |
| `.hero` | Split imagen / copy; CTA a catálogo | Snippet home “hero” o módulo TN |
| `.info` | Headline + acordeón (`#accordion`, `.acc-item`) | Textos: settings / página / campos personalizados (**TODO**); JS acordeón → `static/js` |
| `.exhibitor` | Logo gigante fondo + carrusel infinito (`.carousel-track`, `.card`) | Productos destacados: loop real de productos TN o colección; reutilizar lógica de carrusel del theme |
| `footer` | Igual que otras páginas | `snipplets/footer/footer.tpl` |
| `#scrollHint` | Indicador scroll | Opcional; mismo bundle home |

**Notas**

- Fondo `body` marrón y hero claro: alinear tokens con `--brown`, `--cream` del resto del prototipo.
- En TN, el home suele armarse con **secciones configurables**; cada bloque del HTML puede ser un `snipplet` distinto incluido desde `home.tpl`.

---

### 3.4 `quienes-somos.html` → página institucional

**Estructura**

- Nav con logo **blanco** (fondo oscuro) y enlace activo posible vía `.nav-links a.is-active` en otras vistas similares.
- `<main class="about-hero">`: `.about-hero-media` (`about-us.jpg`) + `.about-hero-copy` (título + párrafos).
- Footer estándar.

**Migración**

- `templates/page.tpl` con condición por slug/handle de la página, o una plantilla dedicada `snipplets/.../about.tpl` incluida solo en esa página.
- Imagen y textos: cuerpo HTML de la página en admin TN o imagen destacada (**TODO: confirmar** cómo expone TN el contenido de páginas).
- JS: solo mega menú + `nav.solid` en scroll (mismo patrón que otras páginas oscuras).

---

### 3.5 `como-trabajamos.html` → página + FAQ

**Estructura**

- Nav igual a quienes somos; ítem “Cómo Trabajamos” con clase `is-active`.
- `<main class="buy-hero">`: `.buy-hero-media` (`how-it-works.jpg`) + `.buy-hero-copy` con `.faq-list` / `.faq-item` / `.faq-trigger` / `.faq-content`.
- JS FAQ: acordeón exclusivo (un ítem abierto, `max-height` animado + `resize`).

**Migración**

- Misma estrategia que 3.4 (`page.tpl` o snippet dedicado).
- Si el FAQ debe ser editable sin código, valorar repetir estructura en HTML de la página o un **metaobjeto/lista** si TN lo permite; si no, bloque Twig con entradas en `settings` (**TODO**).

---

## 4. Componentes compartidos (nav + footer + mega menú)

Aparecen en **las cinco** páginas HTML (con variaciones: `body` claro vs oscuro, logo negro vs blanco, `page-light`, `catalog-page`, `pdp-page`, `is-active` en nav).

**Recomendación:** una sola fuente en `snipplets/header/header.tpl` y `snipplets/footer/footer.tpl` incluida desde `layouts/layout.tpl`, con modificadores de clase en el `<body>` según `template` o `page_type` si el theme lo permite.

**IDs usados por JS (mantener o actualizar scripts en un solo bundle):**

- `navbar`, `mueblesTrigger`, `mueblesBtn`, `megaMenu`, `megaClose`, `navToggle`
- Catálogo: `catalogSubnav`, `catalogSubnavSpacer`, `catalogTabs`, `productsGrid`, `emptyState`, `sortDropdown`, `filterDropdown`, etc.

---

## 5. Activos estáticos

| Prototipo | Destino en theme |
|-----------|------------------|
| Google Fonts (Hanken Grotesk, Montserrat) | Cargar en `layout` o `static` según política de performance del theme (preferir subset y `preconnect` como en el prototipo) |
| `julia-logo-negro.png`, `julia-logo-blanco.png`, `min-logo-blanco.png`, `foto-muebles.png`, `about-us.jpg`, `how-it-works.jpg` | `static/images/` o medios subidos / CDN TN según política |
| SVG inline en nav/footer | Pueden permanecer en `.tpl` o extraerse a `snipplets/svg/icons.tpl` si el theme ya lo usa |

---

## 6. Orden de trabajo sugerido

1. Restaurar o clonar el **Theme Base** con `layouts/layout.tpl` funcional.
2. Portar **layout + header + footer** compartidos; unificar variantes (nav claro/oscuro, logo) con clases por tipo de página.
3. Implementar **`templates/home.tpl`** y snippets del hero, info, exhibidor/carrusel.
4. Implementar **`templates/page.tpl`** (o equivalentes) para **Quiénes somos** y **Cómo trabajamos** con los assets anteriores.
5. Implementar **`templates/product.tpl`** (PDP tres columnas) y **`templates/category.tpl`** (grid + toolbar).
6. Centralizar CSS en `static/css` y eliminar `<style>` embebidos de los prototipos.
7. Pase de accesibilidad y prueba mobile.

---

## 7. Checklist antes de publicar

- [ ] Ningún texto de producto crítico queda hardcodeado en `product.tpl` (sale de TN).
- [ ] URLs de producto y enlaces de categoría usan helpers del theme, no `.html` del prototipo.
- [ ] Variantes/SKU: al elegir opción, precio y disponibilidad coinciden con el admin.
- [ ] Carrito y checkout no modificados en lógica nativa; todos los inputs están envueltos en sus `<form data-store="...">` correspondientes.
- [ ] Sin `overflow: hidden` o `overflow-x: hidden` innecesario en ancestros del sticky PDP.
- [ ] Navbar con `z-index` por encima del contenido sticky del PDP, fondo sólido donde el diseño lo exija.

---

## 8. Referencias internas del proyecto

- Convenciones theme: `.cursor/rules/julia-design-tiendanuve-theme.mdc`
- Workflow HTML → `.tpl`: `.cursor/skills/julia-static-html-to-tn-tpl/SKILL.md`
- Marca (paleta, tipografías): `.cursor/rules/julia-design-core.mdc`