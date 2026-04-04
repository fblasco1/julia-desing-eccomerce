# Debug del error 500 en Tienda Nube

Sin logs en el panel, hay que **aislar** la causa por eliminación.

## Después de “Diagnóstico OK”

Si el layout mínimo funciona, el fallo está en el layout completo o en lo que incluye. En este repo están aplicadas estas defensas (evitan 500 por accesos Twig inválidos):

- **`layouts/layout.tpl`:** el bloque de `cart.free_shipping` solo se evalúa si `cart.free_shipping` y `min_price_free_shipping` existen.
- **`static/js/store.js.tpl`:** el swiper de destacados solo se genera si `sections` y `sections.primary` existen.

**Antes** (theme base): acceder a `sections.primary.products` o a `cart.free_shipping.*` sin comprobar podía disparar **500** al compilar la plantilla en el servidor.

---

## Paso 1: Probar layout mínimo

En el repo existe **`layouts/layout-diagnostico.tpl`**: HTML mínimo, `{% head_content %}`, `{% template_content %}`, mensaje **Diagnóstico OK**.

1. **Respaldar** el layout actual:
   - Renombrar `layouts/layout.tpl` → `layouts/layout.tpl.respaldado`

2. **Usar** el layout de diagnóstico:
   - Renombrar `layouts/layout-diagnostico.tpl` → `layouts/layout.tpl`
   - O copiar su contenido directamente en `layout.tpl`

3. **Subir** solo `layouts/layout.tpl` por FTP (o el archivo renombrado).

4. **Probar** la tienda:
   - **Si ves "Diagnóstico OK"** → El error está en el layout completo (componentes, snipplets, CSS/JS compilados, etc.). Ir al Paso 2.
   - **Si sigue el 500** → El problema puede estar en `config/`, en `templates/` o en la carga del theme. Ir al Paso 3.

---

## Paso 2: Layout funciona → El fallo está en nuestras customizations

Restaurar el layout original y quitar piezas una a una:

1. Restaurar `layout.tpl` desde el respaldo.
2. **Comentar** temporalmente bloques grandes (en orden): `preload-images`, `style-colors` inline, `style-async`, luego `header/footer` snipplets.
3. **Sustituir** header por un `<header></header>` vacío y probar.

Subir, probar. Si va bien, ir devolviendo piezas hasta que vuelva el 500.

---

## Paso 3: Layout mínimo también falla → Config o theme

1. **No subir** la carpeta `config/`:
   - Subir solo: `layouts/`, `snipplets/`, `templates/`, `static/`
   - Dejar el `config/` que ya tenga la tienda (del theme anterior)

2. Si la tienda usa un **theme de la tienda** (no desarrollo local):
   - Comprobar que estás subiendo al theme correcto por FTP
   - En el admin: Diseño → Temas → ver qué theme está activo y a cuál corresponde el FTP

3. **Theme Base original**:
   - Si tienes una copia del Theme Base sin modificar, subirla entera y probar.
   - Si con el base original funciona, el fallo viene de nuestros cambios en config o en la estructura.

---

## Paso 4: Alternativa - Desarrollar en el editor de temas

Tienda Nube tiene un **editor de temas** en el admin (Diseño → Mi tema → Editar código). Ahí puedes:

- Ver y editar plantillas en vivo
- Al guardar, a veces se muestra el error concreto
- Probar cambios sin FTP

Si el 500 ocurre al cargar la tienda (no al editar), esta opción ayuda poco, pero vale la pena intentar abrir el editor para ver si hay mensajes de error.
