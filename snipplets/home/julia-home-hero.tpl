{# Hero split 50/50 — prioridad: imagen custom del theme; si no, primer slide del slider configurado en el admin #}
{% set hero_image_url = null %}
{% if 'julia-spruce-hero.jpg' | has_custom_image %}
    {% set hero_image_url = 'images/julia-spruce-hero.jpg' | static_url %}
{% elseif settings.slider is defined and settings.slider is not empty %}
    {% set hero_image_url = settings.slider[0].image | static_url | settings_image_url('large') %}
{% endif %}

<section class="julia-home__hero" aria-label="{{ 'Inicio' | translate }}">
    <div class="julia-home__hero-media">
        {% if hero_image_url %}
            <img src="{{ hero_image_url }}" alt="" loading="eager" fetchpriority="high" width="1200" height="800" />
        {% else %}
            <div class="w-100 h-100" style="background: var(--julia-gray, #D2D0D0); min-height: 50vh;" role="img" aria-label="{{ store.name }}"></div>
        {% endif %}
    </div>
    <div class="julia-home__hero-content">
        {% if 'julia-spruce-hero-logo.png' | has_custom_image %}
            <div class="julia-home__hero-logo-bg" aria-hidden="true">
                <img src="{{ 'images/julia-spruce-hero-logo.png' | static_url }}" alt="" />
            </div>
        {% endif %}
        <h1 class="julia-home__title">
            {{ 'Diseño que resiste' | translate }}<br />{{ 'el paso del tiempo.' | translate }}
        </h1>
        <p class="julia-home__lead">
            {{ 'Fabricamos muebles de diseño en caño de hierro y chapa. Calidad y comodidad en cada etapa, desde nuestro taller hasta tu hogar.' | translate }}
        </p>
        <div class="julia-home__actions">
            <a class="julia-btn-outline" href="{{ store.url }}#julia-catalogo">{{ 'Ver Catálogo' | translate }}</a>
            <a class="julia-link-underline" href="{{ store.contact_url }}">{{ 'Conocé más' | translate }}</a>
        </div>
    </div>
</section>
