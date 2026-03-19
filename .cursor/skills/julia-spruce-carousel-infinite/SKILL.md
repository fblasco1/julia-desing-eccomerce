---
name: julia-spruce-carousel-infinite
description: Implementa el carrusel/infinite-scroll con apariencia continua (Spruce Simple) usando JS vanilla y CSS. Usar cuando el usuario pida carrusel infinito, scroll continuo, o alineación/animación tipo editorial para listados de productos.
---

# Julia Spruce: Carrusel infinito (apariencia continua)

## Qué debe lograr
- El usuario percibe un flujo continuo (sin “saltos” visibles) al desplazarse.
- Diseño responsive: móvil primero, scroll horizontal o carrusel fluido según el prototipo.
- Ocultar scrollbar cuando aplique y mantener accesibilidad básica (tab focus en botones).

## Pasos sugeridos
1. Elegir estrategia
   - Opción A (recomendada): duplicar items (clonar N veces) y ajustar el offset al final para “loop”.
   - Opción B: render incremental (más complejo, evita saltos perceptibles).

2. Integrar JS vanilla
   - Cargar script al final o en `static/` según el Theme Base.
   - Usar `requestAnimationFrame`/event listeners pasivos cuando aplique.

3. Ajustar CSS a “Spruce Simple”
   - Tipografías grandes/espaciado editorial.
   - Imágenes sin fondo integradas (contain, drop-shadow sutil).

4. Verificación rápida
   - Probar en móvil y desktop.
   - Validar que el loop no rompe con items cortos/largos.

## Checklist
- [ ] Seam imperceptible al final del carrusel
- [ ] Mobile-first (sin overflow feo)
- [ ] JS sin dependencias extra

