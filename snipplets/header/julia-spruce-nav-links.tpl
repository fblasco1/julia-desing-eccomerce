{# Navegación desktop estilo editorial (Spruce Simple) — primeros ítems del menú principal #}
{# Ítems con submenú: si TN expone item.url, enlaza; si no, “#” (el detalle megamenu sigue en panel hamburguesa). #}
<nav class="julia-spruce-header__nav-desktop" aria-label="{{ 'Menú principal' | translate }}">
    {% for item in navigation | slice(0, 6) %}
        <a
            class="julia-spruce-header__link {% if item.current %}julia-spruce-header__link--current{% endif %}"
            href="{% if item.url %}{{ item.url | setting_url }}{% else %}#{% endif %}"
        >
            {{ item.name }}
        </a>
    {% endfor %}
</nav>
