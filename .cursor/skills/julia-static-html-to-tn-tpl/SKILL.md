---
name: julia-pro-html-to-tpl
description: Refactor profesional de prototipos HTML/CSS/JS estáticos a arquitectura modular de Tienda Nube (.tpl), aplicando la identidad de Julia Design.
---

# Skill: Julia HTML-to-TPL Professional Refactor

## 1. Deconstrucción y Limpieza de Assets
- [cite_start]**Extracción de CSS**: Identificar bloques `<style>` y moverlos a `static/custom-style.css.tpl`[cite: 8, 10].
    - [cite_start]Sustituir valores fijos por variables de Julia Design: `--mink: #81756C;`, `--brown: #54463D;`, `--gray-light: #D2D0D0;`, `--white: #FFFFFF;`, `--cream: #ece8e4;`, `--dark-text: #1c1a16;`[cite: 3].
    - [cite_start]Convertir tamaños de fuente y gaps a funciones `clamp()` para garantizar un diseño mobile-first y responsivo[cite: 9, 10].
- [cite_start]**Extracción de JS**: Mover bloques `<script>` a `static/custom-scripts.js`[cite: 17].
    - [cite_start]**Refactor Vanilla**: Eliminar cualquier uso de jQuery y convertir a Vanilla JS puro[cite: 16].
    - [cite_start]Optimizar eventos de scroll y visibilidad usando `IntersectionObserver` o `requestAnimationFrame` para animaciones y logos flotantes[cite: 17].
- [cite_start]**Rutas de Archivos**: Cambiar rutas locales de imágenes por el filtro nativo `{{ "nombre.jpg" | static_url }}`[cite: 16].

## 2. Abstracción de Componentes (Snipplets)
- [cite_start]**Identificación de Patrones**: Localizar bloques HTML repetidos como tarjetas de producto, banners o acordeones[cite: 19].
- [cite_start]**Creación de Snipplets**: Mover el código repetido a la carpeta `snipplets/` con nombres descriptivos (ej: `snipplets/grid/julia-product-card.tpl`)[cite: 8, 19].
- [cite_start]**Parametrización Twig**: Utilizar `{% include '...' with {...} %}` para inyectar datos dinámicos en los componentes sin duplicar código[cite: 20].

## 3. Dinamización de Datos (Mapeo Tienda Nube)
- [cite_start]**Variables de Tienda**: Sustituir textos e imágenes dummy por objetos reales: `product`, `category`, `cart`, `store`[cite: 20].
- **Filtros Obligatorios**:
    - [cite_start]**Precios**: Aplicar `| money` a valores numéricos[cite: 21].
    - [cite_start]**Traducciones**: Usar `{{ "Texto" | translate }}` para todo texto estático[cite: 21].
    - [cite_start]**Imágenes**: Usar `{{ product.featured_image | product_image_url('huge') }}` con `object-fit: cover`[cite: 15].
- [cite_start]**Lógica de Bucles**: Reemplazar bloques manuales por loops `{% for product in products %}` manteniendo las clases CSS del prototipo[cite: 20].

## 4. Alineación de Marca y UX
- [cite_start]**Tipografía**: Aplicar **'Hanken Grotesk'** para títulos y botones, y **'Montserrat'** para el cuerpo de texto[cite: 4].
- [cite_start]**UI Nativa**: Priorizar el uso de etiquetas `<details>` y `<summary>` para acordeones y dropdowns para minimizar el JS[cite: 7].
- [cite_start]**Configuración**: Identificar elementos editables y proponer su estructura en `config.xml` y `settings.txt` para el administrador[cite: 20].

## 5. Integración del Flujo de Compra
- [cite_start]**Product Form**: El formulario de compra DEBE tener el atributo `data-store="product-form"`[cite: 23].
- [cite_start]**Variantes**: Asegurar que los selectores de variantes usen los inputs `name` nativos requeridos por Tienda Nube[cite: 23, 24].
- [cite_start]**Layouts**: Respetar la jerarquía de `layouts/`, `templates/` y `snipplets/` del Theme Base[cite: 19].

## Comandos de Activación en Cursor
- *"@julia-pro-html-to-tpl: Limpia este HTML y separa los componentes repetidos en snipplets."*
- *"Dinamiza esta sección de productos usando variables de Tienda Nube y aplica la escala clamp() de Julia Design."*
- *"Extrae el JS de este prototipo a un archivo vanilla optimizado siguiendo las reglas de Julia Design."*