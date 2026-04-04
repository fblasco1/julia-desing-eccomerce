{# Mega menú de navegación (categorías + páginas institucionales). Desktop: rail con cierre + “Ver todo”; mobile: marca + carrito + enlaces. #}
{% if mega_parent and mega_parent.subitems %}
{% if mega_parent.url %}
	{% set mega_view_href = mega_parent.url | setting_url %}
{% else %}
	{% set mega_view_href = store.products_url %}
{% endif %}
<div class="julia-mega-menu mega-menu" id="julia-mega-menu" role="dialog" aria-modal="true" aria-labelledby="julia-mega-btn">
	{# Desktop: cruz + Ver todo apilados a la derecha #}
	<div class="julia-mega-desktop-rail" aria-hidden="false">
		<button type="button" class="mega-close js-julia-mega-close" aria-label="{{ 'Cerrar' | translate }}">
			<svg viewBox="0 0 24 24" aria-hidden="true"><line x1="18" y1="6" x2="6" y2="18"/><line x1="6" y1="6" x2="18" y2="18"/></svg>
		</button>
		<a href="{{ mega_view_href }}" class="mega-view-all mega-view-all--desktop">
			{{ 'Ver todo' | translate }}
			<svg viewBox="0 0 24 24" aria-hidden="true"><line x1="5" y1="12" x2="19" y2="12"/><polyline points="13 6 19 12 13 18"/></svg>
		</a>
	</div>

	<div class="mega-mobile-top">
		<div class="mega-mobile-brand">
			{% if 'logo-blanco-placeholder.png' | has_custom_image %}
				<img src="{{ 'logo-blanco-placeholder.png' | static_url | settings_image_url('large') }}" alt="{{ store.name }}" width="120" height="48" loading="lazy" />
			{% else %}
				<span class="mega-mobile-brand-text">{{ store.name }}</span>
			{% endif %}
		</div>
		{% if not store.is_catalog %}
			<a href="#" class="mega-mobile-cart js-modal-open js-fullscreen-modal-open js-toggle-cart" data-toggle="#modal-cart" data-modal-url="modal-fullscreen-cart" aria-label="{{ 'Carrito de compras' | translate }}">
				{% include "snipplets/svg/shopping-bag.tpl" with {svg_custom_class: "mega-mobile-cart-svg"} %}
			</a>
		{% endif %}
	</div>
	<div class="mega-mobile-links">
		{% for p in pages %}
			{% if p.handle in ['quienes-somos', 'como-trabajamos'] %}
				<a href="{{ p.url }}" class="mega-link">{{ p.title }}</a>
			{% endif %}
		{% endfor %}
	</div>

	<div class="julia-mega-categories-block">
		<span class="mega-col-title">{{ 'Categorías' | translate }}</span>
		<div class="julia-mega-cat-links">
			{% for sub in mega_parent.subitems %}
				<a href="{% if sub.url %}{{ sub.url | setting_url }}{% else %}#{% endif %}" class="mega-link">{{ sub.name }}</a>
			{% endfor %}
		</div>
	</div>

	<div class="mega-view-all mega-view-all--mobile">
		<a href="{{ mega_view_href }}">
			{{ 'Ver todo' | translate }}
			<svg viewBox="0 0 24 24" aria-hidden="true"><line x1="5" y1="12" x2="19" y2="12"/><polyline points="13 6 19 12 13 18"/></svg>
		</a>
	</div>
</div>
{% endif %}
