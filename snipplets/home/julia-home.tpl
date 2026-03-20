{# Julia Design — home Spruce; visibilidad por bloque desde Diseño → Julia Design #}
<div class="julia-home">
    {% if settings.julia_home_show_hero | default(1) %}
        {% include 'snipplets/home/julia-home-hero.tpl' %}
    {% endif %}
    {% if settings.julia_home_show_benefits | default(1) %}
        {% include 'snipplets/home/julia-home-beneficios.tpl' %}
    {% endif %}
    {% if settings.julia_home_show_carousel | default(1) %}
        {% include 'snipplets/home/julia-home-carousel.tpl' %}
    {% endif %}
    {% if settings.julia_home_show_editorial | default(1) %}
        {% include 'snipplets/home/julia-home-editorial.tpl' %}
    {% endif %}
</div>
