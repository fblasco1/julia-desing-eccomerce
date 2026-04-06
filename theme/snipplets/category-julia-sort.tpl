{# Ordenar: panel tipo prototipo (radios); el select nativo .js-sort-by queda oculto y se sincroniza con store.js #}
{% set sort_text = {
	'user': 'Destacado',
	'price-ascending': 'Precio: Menor a Mayor',
	'price-descending': 'Precio: Mayor a Menor',
	'alpha-ascending': 'A - Z',
	'alpha-descending': 'Z - A',
	'created-ascending': 'Más Viejo al más Nuevo',
	'created-descending': 'Más Nuevo al más Viejo',
	'best-selling': 'Más Vendidos',
} %}
{% set julia_sort_current_label = attribute(sort_text, sort_by) | default('Destacado') | t %}

<div class="julia-catalog-pill julia-catalog-pill--sort julia-catalog-sort">
	<span class="julia-catalog-pill__label">{{ "Ordenar" | translate }}</span>
	<div class="julia-catalog-sort-ui">
		<details class="julia-catalog-sort-details" id="juliaCatalogSortPanel">
			<summary class="julia-catalog-sort-summary" aria-label="{{ 'Ordenar por' | translate }}">
				<span class="julia-catalog-sort-summary__value" id="juliaCatalogSortLabel">{{ julia_sort_current_label }}</span>
			</summary>
			<div class="julia-catalog-sort-dropdown" role="listbox">
				{% for sort_method in sort_methods %}
					{% if sort_method != 'user' or category.sort_method == 'user' %}
						<label class="julia-catalog-sort-opt">
							<input
								type="radio"
								name="julia-catalog-sort-rad"
								value="{{ sort_method }}"
								class="julia-catalog-sort-rad-input"
								{% if sort_by == sort_method %}checked{% endif %}
							/>
							<span>{{ sort_text[sort_method] | t }}</span>
						</label>
					{% endif %}
				{% endfor %}
			</div>
		</details>
	</div>
	{# Include directo: component('sort-by') en TN puede omitir la clase .js-sort-by en el <select> #}
	<div class="julia-catalog-sort-native">
		{% include 'snipplets/grid/sort-by.tpl' %}
	</div>
</div>
