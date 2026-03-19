---
name: julia-static-html-to-tn-tpl
description: Convierte HTML/Tailwind/JS estático (Home/Producto/Categorías/Checkout) a plantillas Tienda Nube en `.tpl/.twig`, creando/ajustando `layouts`, `templates` y `snipplets`. Usar cuando el usuario pide “llevar el diseño a .tpl”, “adaptar al Theme Base”, o “refactor de static HTML a Tienda Nube”.
---

# Julia Static HTML -> Tienda Nube `.tpl`

## Instrucciones (workflow)

1. Identificar la vista destino
   - Home, Detalle de Producto, Categorías o Checkout.
   - Listar secciones/componentes del prototipo (hero split, beneficios, carrusel, etc.).

2. Diseñar la estructura Tienda Nube
   - Mapping: secciones -> `snipplets/` y page wrapper -> `templates/` (o `layouts/` si corresponde).
   - Mantener includes/partials consistentes con el Theme Base.

3. Reemplazar contenido por variables nativas (sin alucinaciones)
   - Convertir texto/iteraciones estáticas en datos reales usando variables `.tpl`/fields de Tienda Nube.
   - Si no hay certeza sobre una variable/campo exacto: marcarlo como `TODO: confirmar variable` y/o pedir confirmación antes de “inventar”.

4. CSS/JS vanilla
   - Trasladar CSS al lugar correcto (`static/css/*.tpl` si aplica).
   - Integrar JS vanilla existente (carrusel infinito, eventos, scroll) en `static/` con nombres consistentes.

5. Ajustes visuales “Spruce Simple”
   - Mantener split 50/50, logo gigante translúcido, tipografías y spacing.
   - Validar mobile-first (breakpoints mínimos, sin scrollbar visible en carruseles).

6. Entrega
   - Responder indicando qué archivos se crearon/editaron y cómo se conectan entre sí.
   - Recordar que cambios en TN pueden requerir el paso “publicar/deploy” (según el flujo del proyecto).

