{% set has_filters_available = products and has_filters_enabled and ((filter_categories is defined and filter_categories is not empty) or (product_filters is defined and product_filters is not empty)) %}

{# Máximo precio del listado (category.products si existe; si no, página actual) para el slider de filtros #}
{% set julia_listing_price_max = 0 %}
{% if category.products is defined and category.products is not empty %}
	{% for p in category.products %}
		{% if p.display_price and p.price is defined and p.price > julia_listing_price_max %}
			{% set julia_listing_price_max = p.price %}
		{% endif %}
	{% endfor %}
{% elseif products is defined and products is not empty %}
	{% for p in products %}
		{% if p.display_price and p.price is defined and p.price > julia_listing_price_max %}
			{% set julia_listing_price_max = p.price %}
		{% endif %}
	{% endfor %}
{% endif %}

{# Título visible: "Muebles" si la categoría en admin se llama "Productos" (listado general). #}
{% set julia_category_title = category.name %}
{% if category.name is defined and category.name | trim | lower == 'productos' %}
	{% set julia_category_title = 'Muebles' | translate %}
{% endif %}

{# Only remove this if you want to take away the theme onboarding advices #}
{% set show_help = has_products is not defined or not has_products %}
{% paginate by 12 %}

{% if not show_help %}

<section class="julia-catalog-page">
	<div class="container-fluid julia-catalog-page__inner">
		<h1 class="julia-catalog-title">{{ julia_category_title }}</h1>

		{% if category.description %}
			<p class="julia-catalog-lead">{{ category.description }}</p>
		{% endif %}

		{% if products %}
			<div class="julia-catalog-subnav-anchor">
				<div class="js-category-controls-prev category-controls-sticky-detector"></div>
				<div class="js-category-controls-spacer category-controls-spacer" aria-hidden="true"></div>
				<div class="js-category-controls julia-category-toolbar w-100 mb-md-3">
					{% include 'snipplets/category-julia-toolbar.tpl' %}
				</div>
			</div>

			<div class="row">
				{% include "snipplets/grid/filters.tpl" with {applied_filters: true} %}
			</div>

			<div class="js-product-table row julia-catalog-grid" data-store="category-grid-{{ category.id }}">
				{% include 'snipplets/product_grid.tpl' %}
			</div>
			{% include 'snipplets/grid/pagination.tpl' with { infinite_scroll: true } %}
		{% else %}
			<p class="text-center julia-catalog-empty">
				{{ (has_filters_enabled ? "No tenemos resultados para tu búsqueda. Por favor, intentá con otros filtros." : "Próximamente") | translate }}
			</p>
		{% endif %}
	</div>
</section>

{% elseif show_help %}
	{# Category Placeholder #}
	{% include 'snipplets/defaults/show_help_category.tpl' with { julia_category_title: julia_category_title } %}
{% endif %}
