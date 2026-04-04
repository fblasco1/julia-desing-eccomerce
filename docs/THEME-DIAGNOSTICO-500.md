# Diagnóstico 500 — cambios Julia sobre el theme base

El error **500** en Tienda Nube suele ser **fallo al compilar plantillas o CSS en el servidor** (Twig/Liquid o SCSS), no un error de JavaScript en el navegador.

## Cambios que introdujimos (para aislar uno a uno)

| Pieza | Ubicación | Efecto |
|--------|-----------|--------|
| **CSS prototipo** | `static/css/julia-prototype.scss.tpl` | Hoja grande (~1900 líneas), antes incluida dentro de `style-async`; **ahora se carga aparte** desde `layouts/layout.tpl` |
| **Link en layout** | `layouts/layout.tpl` | Segundo `<link>` a `css/julia-prototype.scss.tpl` (después de `style-async`) |
| **Modo cabecera** | `layouts/layout.tpl` | Clases `julia-head-mode--*` según `template` y `page.handle` |
| **JS header / home / mega** | `static/js/store.js.tpl` | ~líneas **406–644**: logo flotante, mega menú, exhibidor (`#julia-home-exhibitor`) |
| **JS catálogo compacto** | `static/js/store.js.tpl` | ~líneas **1032–1068**: solo si `template == 'category'` |
| **Snipplets nuevos** | `snipplets/footer/footer-julia.tpl`, `home/home-scroll-hint.tpl`, `home/home-exhibitor-card.tpl` | **No** se incluyen solos en el layout por defecto → no deberían causar 500 salvo que los referencies |
| **JS prototipo sueltos** | `static/js/julia-prototype-*.js.tpl` | No enlazados desde `layout.tpl` → no afectan al render del servidor |

## Prueba 1: aislar el CSS `julia-prototype`

En `layouts/layout.tpl`, **comenta temporalmente** el bloque:

```twig
{# <link rel="stylesheet" href="{{ 'css/julia-prototype.scss.tpl' | static_url }}" media="print" onload="this.media='all'"> #}
```

Sube el tema y recarga. Si el **500 desaparece**, el fallo está en la **compilación SCSS** de `julia-prototype.scss.tpl` (sintaxis, límite del compilador del servidor, etc.).

## Prueba 2: aislar el bloque JS “Julia” del header/home

En `static/js/store.js.tpl`, comenta **todo el bloque** entre el comentario `{# /* // Julia Design: mega menú + home logo flotante` y el cierre `})();` antes de `{# /* // Nav */ #}` (aprox. líneas **406–644**).

Si el 500 **persiste**, el problema no es ese JS (el servidor igual compila el `.tpl` aunque el JS sea comentario en el sentido cliente — aquí solo afecta si hay **error de sintaxis Twig** dentro del archivo).

## Prueba 3: aislar el JS de catálogo

Comenta el IIFE bajo `{# /* // Julia Design: catálogo` (~**1032–1068**).

## Prueba 4: layout — `page.handle`

En `layout.tpl`, el bloque usa `page is defined and page.handle in [...]`. Si algún entorno evaluara `page` de forma estricta, podría fallar; en Twig suele bastar el `page is defined`. Si sospechas de esto, sustituir temporalmente por solo `template == 'page'` o comentar el `elseif` completo.

## Prueba 5: layout mínimo

Seguir **`docs/DEBUG-ERROR-500.md`**: `layout-diagnostico.tpl` para confirmar que el motor de plantillas responde.

## Verificación local del SCSS (referencia)

Tras quitar comentarios `{# #}`, `julia-prototype.scss.tpl` compila con **Dart Sass** en entorno local. Si el servidor TN usa otra versión, podría haber diferencias.

## Estado aplicado en repo (última corrección)

- **`julia-prototype` ya no se incluye dentro de `style-async.scss.tpl`** (evita un único bundle gigante y facilita ver si el fallo es solo esa hoja).
- **Comentario en `footer-julia.tpl`** sin texto `{%` dentro de `{# #}` (evita ambigüedad del parser).
