{# Site Overlay #}
<div class="js-overlay site-overlay" style="display: none;"></div>


{# Header #}

{# Julia Design home: barra sólida. Logo en #juliaLogoEl (imagen o wordmark); la celda del header queda reservada hasta dock por scroll (store.js). #}
{% set show_transparent_head = false %}

<header class="js-head-main head-main julia-head-bar {% if template == 'home' %}julia-head-nav-home{% endif %} {% if show_transparent_head %}head-transparent {% if settings.head_fix %}head-transparent-fixed{% else %}head-transparent-absolute{% endif %}{% endif %} head-{{ settings.head_background }} {% if settings.head_fix %}head-fix{% endif %} {% if not settings.head_fix and show_transparent_head %}head-absolute{% endif %}"{% if template == 'home' %} id="juliaNavbar"{% endif %} data-store="head" data-julia-transparent-head="{{ show_transparent_head ? '1' : '0' }}">

    {# Advertising #}
    
    {% if settings.ad_bar and settings.ad_text %}
        {% snipplet "header/header-advertising.tpl" %}
    {% endif %}

    <div class="julia-header-wrap position-relative w-100">
        {# Grid: móvil = logo | (espacio) | utilidades · desktop = nav | logo centro | utilidades — ancho completo (sin .container) #}
        <div class="julia-header-grid">
            <div class="julia-header-cell julia-header-nav-desktop">
                {% snipplet "navigation/navigation-desktop.tpl" %}
            </div>
            <div class="julia-header-cell julia-header-logo-cell">
                <div class="js-julia-header-logo julia-header-logo">
                    {% snipplet "header/header-logo.tpl" %}
                </div>
            </div>
            <div class="julia-header-cell julia-header-utilities-cell d-flex align-items-center">
                {% snipplet "header/header-utilities.tpl" %}
                {% if settings.head_fix and settings.ajax_cart %}
                    {% include "snipplets/notification.tpl" with {add_to_cart: true} %}
                {% endif %}
            </div>
        </div>
    </div>    
    {% include "snipplets/notification.tpl" with {order_notification: true} %}
</header>

{# Home: logo flotante. image settings TN: clave = original filename + has_custom_image. #}
{% if template == 'home' %}
	{% set julia_use_logo_negro = settings.head_background == 'light' %}
	{% if julia_use_logo_negro %}
		{% set julia_logo_file = 'logo-negro-placeholder.png' %}
		{% set julia_logo_file_alt = 'logo-blanco-placeholder.png' %}
	{% else %}
		{% set julia_logo_file = 'logo-blanco-placeholder.png' %}
		{% set julia_logo_file_alt = 'logo-negro-placeholder.png' %}
	{% endif %}
	{% if julia_logo_file | has_custom_image %}
		{% set julia_float_file = julia_logo_file %}
	{% elseif julia_logo_file_alt | has_custom_image %}
		{% set julia_float_file = julia_logo_file_alt %}
	{% else %}
		{% set julia_float_file = '' %}
	{% endif %}
	{% if julia_float_file %}
		<a href="{{ store.url }}" class="julia-logo-el js-julia-logo-floating" id="juliaLogoEl" aria-label="{{ store.name }}">
			<img
				id="juliaLogoImg"
				class="julia-logo-el__img"
				src="{{ julia_float_file | static_url | settings_image_url('large') }}"
				srcset="{{ julia_float_file | static_url | settings_image_url('large') }} 1x, {{ julia_float_file | static_url | settings_image_url('huge') }} 2x"
				alt="{{ store.name }}"
				loading="eager"
				decoding="async"
			/>
		</a>
	{% else %}
		{# component('logos/logo') ya incluye enlace al inicio; no envolver en <a> #}
		<div class="julia-logo-el js-julia-logo-floating" id="juliaLogoEl" aria-label="{{ store.name }}">
			<div class="julia-logo-el__tn-component">
				{{ component('logos/logo', { logo_size: 'large', logo_img_classes: 'julia-logo-el__img transition-soft-slow', logo_text_classes: 'julia-logo-el__wordmark h1 m-0' }) }}
			</div>
		</div>
	{% endif %}
{% endif %}

{% snipplet "navigation/navigation-mega-root.tpl" %}

{% if not settings.head_fix %}
    {% include "snipplets/notification.tpl" with {add_to_cart: true, add_to_cart_fixed: true} %}
{% endif %}

{# Show cookie validation message #}
{% include "snipplets/notification.tpl" with {show_cookie_banner: true} %}

{# Hamburger panel #}

{% embed "snipplets/modal.tpl" with{modal_id: 'nav-hamburger',modal_class: 'nav-hamburger modal-docked-small', modal_position: 'left', modal_transition: 'fade', modal_width: 'full', modal_fixed_footer: true, modal_footer: true, modal_footer_class: 'p-0' } %}
    {% block modal_body %}
        {% include "snipplets/navigation/navigation-panel.tpl" with {primary_links: true} %}
    {% endblock %}
    {% block modal_foot %}
        {% include "snipplets/navigation/navigation-panel.tpl" %}
    {% endblock %}
{% endembed %}
{# Notifications #}

{# Modal Search #}

{% embed "snipplets/modal.tpl" with{modal_id: 'nav-search', modal_position: 'right', modal_transition: 'slide', modal_width: 'docked-md' } %}
    {% block modal_body %}
        {% snipplet "header/header-search.tpl" %}
    {% endblock %}
{% endembed %}

{% if not store.is_catalog and settings.ajax_cart and template != 'cart' %}           

    {# Cart Ajax #}

    {% embed "snipplets/modal.tpl" with{
        modal_id: 'modal-cart',
        modal_class: 'julia-cart',
        modal_position: 'right',
        modal_transition: 'slide',
        modal_width: 'docked-md',
        modal_header_class: 'julia-modal-head',
        modal_form_action: store.cart_url,
        modal_form_class: 'js-ajax-cart-panel',
        modal_mobile_full_screen: true,
        modal_url: 'modal-fullscreen-cart',
        modal_form_hook: 'cart-form',
        custom_data_attribute: 'cart-open-type',
		custom_data_attribute_value: settings.cart_open_type
    } %}
        {% block modal_head %}
            {% block page_header_text %}{{ "Carrito de Compras" | translate }}{% endblock page_header_text %}
        {% endblock %}
        {% block modal_body %}
            {% snipplet "cart-panel.tpl" %}
        {% endblock %}
    {% endembed %}

    {% if settings.add_to_cart_recommendations %}

        {# Recommended products on add to cart #}

        {% embed "snipplets/modal.tpl" with{modal_id: 'related-products-notification', modal_class: 'bottom modal-overflow-none modal-bottom-sheet h-auto', modal_header_class: 'px-0 pt-0 mb-2 m-0 w-100', modal_position: 'bottom', modal_transition: 'slide', modal_width: 'centered modal-centered-md-600px p-3'} %}
            {% block modal_head %}
                {% block page_header_text %}{{ '¡Agregado al carrito!' | translate }}{% endblock page_header_text %}
            {% endblock %}
            {% block modal_body %}

                {# Product added info #}

                {% include "snipplets/notification-cart.tpl" with {related_products: true} %}

                {# Product added recommendations #}

                <div class="js-related-products-notification-container" style="display: none"></div>

            {% endblock %}
        {% endembed %}
    {% endif %}
{% endif %}

{# Cross selling promotion notification on add to cart #}

{% embed "snipplets/modal.tpl" with {
    modal_id: 'js-cross-selling-modal',
    modal_class: 'bottom modal-bottom-sheet h-auto overflow-none modal-body-scrollable-auto',
    modal_header: true,
    modal_header_class: 'm-0 w-100',
    modal_position: 'bottom',
    modal_transition: 'slide',
    modal_footer: true,
    modal_width: 'centered-md m-0 p-0 modal-full-width modal-md-width-400px'
} %}
    {% block modal_head %}
        {{ '¡Descuento exclusivo!' | translate }}
    {% endblock %}

    {% block modal_body %}
        {# Promotion info and actions #}

        <div class="js-cross-selling-modal-body" style="display: none"></div>
    {% endblock %}
{% endembed %}