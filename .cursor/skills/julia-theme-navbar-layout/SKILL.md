---
name: julia-theme-navbar-layout
description: Adapta `navbar/layout` del Theme Base a la estética “Spruce Simple” en Home/Producto/Categorías/Checkout. Usar cuando el usuario pida que el header/nav mantenga el clon exacto del sitio de referencia.
---

# Julia Theme: Navbar/Layout “Spruce Simple”

## Objetivo
- Mantener el diseño minimalista/editorial: logo gigante translúcido de fondo (opacity baja), navegación limpia (desktop) y menú hamburguesa (mobile).

## Workflow
1. Revisar `layouts/` y dónde se inyecta el header desde el Theme Base.
2. Definir estructura visual compartida:
   - contenedor del header
   - zona del logo gigante (fondo)
   - nav/CTA/cart (sin bordes duros)
3. Integrar estilo:
   - colores/paleta del manual
   - tipografías correctas
   - spacing consistente con split screen y secciones.
4. Evitar conflictos con widgets nativos:
   - Si el theme base mete estilos que rompen el layout, encapsular en contenedores y ajustar con CSS desde `.tpl`/CSS.
5. Validar responsive:
   - móvil primero
   - accesibilidad básica (botones, foco).

