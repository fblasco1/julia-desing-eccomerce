{# Tabs = categorías del menú (primer ítem con subítems, igual que mega menú). Si no hay subítems, filter_categories. #}
{% set julia_mega_idx = -1 %}
{% if navigation is defined %}
	{% for nav_item in navigation %}
		{% if julia_mega_idx < 0 and nav_item.subitems %}
			{% set julia_mega_idx = loop.index0 %}
		{% endif %}
	{% endfor %}
{% endif %}

{% set julia_catalog_all_href = store.products_url %}
{% if settings.julia_home_info_catalog_url | default('') | trim %}
	{% set julia_catalog_all_href = settings.julia_home_info_catalog_url | setting_url %}
{% endif %}

<div class="julia-catalog-toolbar-main w-100">
	{% if julia_mega_idx >= 0 and navigation is defined %}
		{% for nav_item in navigation %}
			{% if loop.index0 == julia_mega_idx %}
				{% if nav_item.url %}
					{% set julia_catalog_all_href = nav_item.url | setting_url %}
				{% endif %}
				{% if nav_item.subitems is not empty %}
					<nav class="julia-catalog-tabs" aria-label="{{ 'Categorías' | translate }}">
						<a
							href="{{ julia_catalog_all_href }}"
							class="julia-catalog-tab {% if category.url == julia_catalog_all_href %}julia-catalog-tab--active{% endif %}"
						>{{ "All" | translate }}</a>
						{% for sub in nav_item.subitems %}
							{% set sub_href = sub.url ? (sub.url | setting_url) : '#' %}
							<a
								href="{{ sub_href }}"
								class="julia-catalog-tab {% if sub.url and (sub.url | setting_url) == category.url %}julia-catalog-tab--active{% endif %}"
								title="{{ sub.name }}"
							>{{ sub.name }}</a>
						{% endfor %}
					</nav>
				{% elseif filter_categories is defined and filter_categories is not empty %}
					<nav class="julia-catalog-tabs" aria-label="{{ 'Categorías' | translate }}">
						<a
							href="{{ julia_catalog_all_href }}"
							class="julia-catalog-tab {% if category.url == julia_catalog_all_href %}julia-catalog-tab--active{% endif %}"
						>{{ "All" | translate }}</a>
						{% for cat_tab in filter_categories %}
							<a
								href="{{ cat_tab.url }}"
								class="julia-catalog-tab {% if cat_tab.url == category.url or cat_tab.id == category.id %}julia-catalog-tab--active{% endif %}"
								title="{{ cat_tab.name }}"
							>{{ cat_tab.name }}</a>
						{% endfor %}
					</nav>
				{% endif %}
			{% endif %}
		{% endfor %}
	{% elseif filter_categories is defined and filter_categories is not empty %}
		<nav class="julia-catalog-tabs" aria-label="{{ 'Categorías' | translate }}">
			<a
				href="{{ julia_catalog_all_href }}"
				class="julia-catalog-tab {% if category.url == julia_catalog_all_href %}julia-catalog-tab--active{% endif %}"
			>{{ "All" | translate }}</a>
			{% for cat_tab in filter_categories %}
				<a
					href="{{ cat_tab.url }}"
					class="julia-catalog-tab {% if cat_tab.url == category.url or cat_tab.id == category.id %}julia-catalog-tab--active{% endif %}"
					title="{{ cat_tab.name }}"
				>{{ cat_tab.name }}</a>
			{% endfor %}
		</nav>
	{% endif %}

	<div class="julia-catalog-controls">
		{% if products %}
			{% include 'snipplets/category-julia-sort.tpl' %}
		{% endif %}

		{% if has_filters_available and product_filters is defined and product_filters is not empty %}
			<details
				class="julia-catalog-dropdown julia-catalog-dropdown--filters"
				id="julia-catalog-filters-panel"
				{% if julia_listing_price_max is defined and julia_listing_price_max > 0 %}
					data-julia-listing-price-max="{{ julia_listing_price_max }}"
				{% endif %}
				data-julia-lbl-desde="{{ 'Desde' | translate | escape('html_attr') }}"
				data-julia-lbl-hasta="{{ 'Hasta' | translate | escape('html_attr') }}"
				data-julia-lbl-max="{{ 'Máx.' | translate | escape('html_attr') }}"
				data-julia-aria-rango-precio="{{ 'Rango de precios en esta categoría' | translate | escape('html_attr') }}"
			>
				<summary class="julia-catalog-dropdown__summary">
					<span class="julia-catalog-dropdown__label">{{ "Filtros" | translate }}</span>
				</summary>
				<div class="julia-catalog-dropdown__body">
					{% include 'snipplets/grid/filters.tpl' %}
				</div>
			</details>
		{% endif %}
	</div>
</div>
