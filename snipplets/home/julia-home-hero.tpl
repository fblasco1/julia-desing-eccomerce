{# Hero — textos e imágenes desde el panel (Julia Design) o valores por defecto #}
{% set hero_image_url = null %}
{% if 'julia_home_hero.jpg' | has_custom_image %}
    {% set hero_image_url = 'images/julia_home_hero.jpg' | static_url %}
{% elseif 'julia-spruce-hero.jpg' | has_custom_image %}
    {% set hero_image_url = 'images/julia-spruce-hero.jpg' | static_url %}
{% elseif settings.slider is defined and settings.slider is not empty %}
    {% set hero_image_url = settings.slider[0].image | static_url | settings_image_url('large') %}
{% endif %}

{% set hero_catalog_href = store.url ~ '#julia-catalogo' %}
{% if settings.julia_hero_btn_catalog_url | default('') | trim != '' %}
    {% set hero_catalog_href = settings.julia_hero_btn_catalog_url | setting_url %}
{% endif %}

{% set hero_secondary_href = store.contact_url %}
{% if settings.julia_hero_link_secondary_url | default('') | trim != '' %}
    {% set hero_secondary_href = settings.julia_hero_link_secondary_url | setting_url %}
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
        {% if 'julia_home_hero_logo.png' | has_custom_image %}
            <div class="julia-home__hero-logo-bg" aria-hidden="true">
                <img src="{{ 'images/julia_home_hero_logo.png' | static_url }}" alt="" />
            </div>
        {% elseif 'julia-spruce-hero-logo.png' | has_custom_image %}
            <div class="julia-home__hero-logo-bg" aria-hidden="true">
                <img src="{{ 'images/julia-spruce-hero-logo.png' | static_url }}" alt="" />
            </div>
        {% endif %}
        <h1 class="julia-home__title">
            {% if settings.julia_hero_title_line1 | default('') | trim != '' %}
                {{ settings.julia_hero_title_line1 }}
            {% else %}
                {{ 'Diseño que resiste' | translate }}
            {% endif %}
            <br />
            {% if settings.julia_hero_title_line2 | default('') | trim != '' %}
                {{ settings.julia_hero_title_line2 }}
            {% else %}
                {{ 'el paso del tiempo.' | translate }}
            {% endif %}
        </h1>
        <p class="julia-home__lead">
            {% if settings.julia_hero_lead | default('') | trim != '' %}
                {{ settings.julia_hero_lead }}
            {% else %}
                {{ 'Fabricamos muebles de diseño en caño de hierro y chapa. Calidad y comodidad en cada etapa, desde nuestro taller hasta tu hogar.' | translate }}
            {% endif %}
        </p>
        <div class="julia-home__actions">
            <a class="julia-btn-outline" href="{{ hero_catalog_href }}">
                {% if settings.julia_hero_btn_catalog | default('') | trim != '' %}
                    {{ settings.julia_hero_btn_catalog }}
                {% else %}
                    {{ 'Ver Catálogo' | translate }}
                {% endif %}
            </a>
            <a class="julia-link-underline" href="{{ hero_secondary_href }}">
                {% if settings.julia_hero_link_secondary | default('') | trim != '' %}
                    {{ settings.julia_hero_link_secondary }}
                {% else %}
                    {{ 'Conocé más' | translate }}
                {% endif %}
            </a>
        </div>
    </div>
</section>
