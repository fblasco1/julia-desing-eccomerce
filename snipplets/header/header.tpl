{# Julia Design — Header estilo Spruce Simple (navbar editorial + utilidades nativas TN) #}
{# Mantiene clases js-head-main / js-head-logo-row / js-logo-container para store.js #}

<div class="js-overlay site-overlay" style="display: none;"></div>

{% set has_languages = languages | length > 1 and settings.languages_header %}

<header class="js-head-main head-main julia-spruce-header position-sticky top-0 transition-soft" data-store="head">
    {% if settings.ad_bar %}
        {% snipplet "header/header-advertising.tpl" %}
    {% endif %}

    <div class="js-head-logo-row head-logo-row position-relative container transition-soft">
        <div class="julia-spruce-header__grid position-relative w-100 d-flex align-items-center">
            {# Izquierda: menú desktop (Spruce Simple) — flex-fill para centrar logo real en desktop #}
            <div class="julia-spruce-header__col-left flex-fill d-none d-md-flex align-items-center">
                {% snipplet "header/julia-spruce-nav-links.tpl" %}
            </div>

            {# Logo (móvil: centrado absoluto; desktop: columna central) #}
            <div class="js-logo-container logo-container-col julia-spruce-header__logo-wrap flex-shrink-0">
                {% set logo_img_size = 'large' %}
                {{ component('logos/logo', {
                    logo_size: logo_img_size,
                    logo_img_classes: 'transition-soft',
                    logo_text_classes: 'h3 m-0'
                }) }}
            </div>

            {# Derecha: utilidades nativas Tienda Nube #}
            <div class="julia-spruce-header__utils flex-fill d-flex align-items-center justify-content-end">
                {% if has_languages %}
                    <div class="d-none d-md-flex align-items-center">
                        {% include "snipplets/header/header-utilities.tpl" with { use_languages: true } %}
                    </div>
                {% endif %}

                <div class="d-none d-md-flex align-items-center">
                    {% include "snipplets/header/header-utilities.tpl" with { use_search: true } %}
                </div>
                {# Sin login / cuenta (Julia Design) #}

                <div class="d-flex align-items-center">
                    {% include "snipplets/header/header-utilities.tpl" %}
                </div>

                <div class="d-flex d-md-none align-items-center">
                    {% include "snipplets/header/header-utilities.tpl" with { use_menu: true } %}
                </div>
            </div>
        </div>

        {% if settings.ajax_cart %}
            <div class="w-100 mt-2 mt-md-0">
                {% include "snipplets/notification.tpl" with { add_to_cart: true } %}
            </div>
        {% endif %}
    </div>

    {% include "snipplets/notification.tpl" with { order_notification: true } %}
</header>

{% include "snipplets/notification.tpl" with { show_cookie_banner: true } %}

{% if settings.ajax_cart and not settings.head_fix_desktop %}
    <div class="d-block d-md-none">
        {% include "snipplets/notification.tpl" with { add_to_cart: true, add_to_cart_fixed: true } %}
    </div>
{% endif %}

{% embed "snipplets/modal.tpl" with {
    modal_id: 'js-cross-selling-modal',
    modal_class: 'bottom modal-bottom-sheet h-auto overflow-none modal-body-scrollable-auto',
    modal_header: true,
    modal_header_class: 'p-2 m-2 w-100',
    modal_position: 'bottom',
    modal_transition: 'slide',
    modal_footer: true,
    modal_width: 'centered-md m-0 p-0 modal-full-width modal-md-width-400px',
    modal_close_class: 'mr-4'
} %}
    {% block modal_head %}
        {{ '¡Descuento exclusivo!' | translate }}
    {% endblock %}
    {% block modal_body %}
        <div class="js-cross-selling-modal-body" style="display: none"></div>
    {% endblock %}
{% endembed %}

{% include "snipplets/header/header-modals.tpl" %}
