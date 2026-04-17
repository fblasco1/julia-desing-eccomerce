{# Misma lógica que navigation-mega-root: si hay mega, el hamburger móvil abre ese panel en todas las páginas. #}
{% set julia_mega_nav_available = false %}
{% if navigation %}
	{% set julia_mega_scan = -1 %}
	{% for item in navigation %}
		{% if julia_mega_scan < 0 and item.subitems %}
			{% set julia_mega_scan = loop.index0 %}
		{% endif %}
	{% endfor %}
	{% if julia_mega_scan >= 0 %}
		{% set julia_mega_nav_available = true %}
	{% endif %}
{% endif %}
<div class="utilities-container julia-header-utilities d-flex align-items-center justify-content-end flex-nowrap">
	{% if languages | length > 1 and settings.languages_header %}
		<span class="utilities-item nav-dropdown position-relative">
			{% include "snipplets/svg/globe.tpl" with {svg_custom_class: "icon-inline icon-w-16 svg-icon-text"} %}
			<div class="nav-dropdown-content desktop-dropdown-small position-absolute">
				{% include "snipplets/navigation/navigation-lang.tpl" with { header: true } %}
			</div>
		</span>
	{% endif %}
	{% if not store.is_catalog %}
	<div class="utilities-item">
		<div id="ajax-cart" class="cart-summary" data-component='cart-button'>
			<a {% if settings.ajax_cart and template != 'cart' %}href="#" class="js-modal-open js-fullscreen-modal-open js-toggle-cart" data-toggle="#modal-cart" data-modal-url="modal-fullscreen-cart"{% else %}href="{{ store.cart_url }}"{% endif %}>
				{% include "snipplets/svg/shopping-bag.tpl" with {svg_custom_class: "icon-inline icon-w-14 svg-icon-text"} %}
				<span class="js-cart-widget-amount cart-widget-amount">{{ "{1}" | translate(cart.items_count ) }}</span>
			</a>
		</div>
	</div>
	{% endif %}
	{% if julia_mega_nav_available %}
		<div class="utilities-item d-md-none julia-nav-hamburger">
			<a href="#" class="utilities-link js-julia-mega-hamburger" aria-label="{{ 'Menú' | translate }}" aria-expanded="false" data-component="menu-button">
				{% include "snipplets/svg/bars.tpl" with {svg_custom_class: "icon-inline icon-w-14 svg-icon-text"} %}
			</a>
		</div>
	{% else %}
		{% snipplet "navigation/navigation-hamburger.tpl" %}
	{% endif %}
</div>
