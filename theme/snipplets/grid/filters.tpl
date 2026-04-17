{% if applied_filters %}
    
    {# Applied filters chips #}

    {% if has_applied_filters %}
        {% set julia_clear_filters_url = (category is defined and category.url is defined and category.url) ? category.url : store.products_url %}
        <div class="col-12 mb-3 julia-applied-filters">
            <div class="d-md-inline-block mr-md-2 mb-3 julia-applied-filters__label">{{ 'Filtrado por:' | translate }}</div>
            {% for product_filter in product_filters %}
                {% for value in product_filter.values %}

                    {# List applied filters as tags #}
                    
                    {% if value.selected %}
                        {% set julia_remove_url = value.remove_url | default('') %}
                        <a class="chip julia-applied-filters__chip" href="{{ julia_remove_url ? julia_remove_url : julia_clear_filters_url }}">
                            {{ value.pill_label }}
                            {% include "snipplets/svg/times.tpl" with {svg_custom_class: "icon-inline chip-remove-icon"} %}
                        </a>
                    {% endif %}
                {% endfor %}
            {% endfor %}
            <a href="{{ julia_clear_filters_url }}" class="js-remove-all-filters d-inline-block px-0 julia-applied-filters__clear">{{ 'Borrar filtros' | translate }}</a> 
        </div>
    {% endif %}
{% else %}
    {% if product_filters is not empty %}
        <div id="filters" data-store="filters-nav">
            {# Precio primero: sin colapsable; título + slider + Aplicar quedan en el mismo bloque #}
            {% for product_filter in product_filters %}
                {% if product_filter.type == 'price' %}
                    {{ component(
                        'price-filter',
                        {'group_class': 'filters-container julia-catalog-filter-price mb-5', 'title_class': 'h6 mb-3', 'button_class': 'btn btn-default px-2 px-md-3 align-bottom' }
                    ) }}
                {% endif %}
            {% endfor %}
            {# Propiedades: colapsables, cerrados por defecto #}
            {% for product_filter in product_filters %}
                {% if product_filter.type != 'price' and product_filter.has_products %}
                    <details class="julia-catalog-filter-group mb-5">
                        <summary class="julia-catalog-filter-group__summary">{{ product_filter.name }}</summary>
                        <div class="julia-catalog-filter-group__body">
                            <div class="filters-container" data-store="filters-group">
                                {% set index = 0 %}
                                {% for value in product_filter.values %}
                                    {% if value.product_count > 0 %}
                                        {% set index = index + 1 %}
                                        {% set julia_apply_url = value.url | default('') %}
                                        {% set julia_remove_url = value.remove_url | default('') %}
                                        {% set julia_filter_href = value.selected ? (julia_remove_url ? julia_remove_url : '') : (julia_apply_url ? julia_apply_url : '') %}
                                        <a class="julia-catalog-filter-opt js-filter-checkbox {% if not value.selected %}js-apply-filter{% else %}js-remove-filter{% endif %} checkbox-container {% if mobile %}mb-3{% else %}mb-2{% endif %}"
                                           {% if julia_filter_href %}href="{{ julia_filter_href }}"{% else %}href="#"{% endif %}
                                           data-filter-name="{{ product_filter.key }}"
                                           data-filter-value="{{ value.name }}"
                                           aria-pressed="{{ value.selected ? 'true' : 'false' }}"
                                        >
                                            <span class="checkbox">
                                                <input type="checkbox" autocomplete='off' {% if value.selected %}checked{% endif %} tabindex="-1">
                                                <span class="checkbox-icon"></span>
                                                <span class="checkbox-text">{{ value.name }} ({{ value.product_count }})</span>
                                                {% if product_filter.type == 'color' and value.color_type == 'insta_color' %}
                                                    <span class="checkbox-color" style="background-color: {{ value.color_hexa }};"></span>
                                                {% endif %}
                                            </span>
                                        </a>
                                        {% if index == 8 and product_filter.values_with_products > 8 %}
                                            <div class="js-accordion-container" style="display: none;">
                                        {% endif %}
                                    {% endif %}
                                    {% if loop.last and product_filter.values_with_products > 8 %}
                                        </div>
                                        <a href="#" class="js-accordion-toggle btn-link d-inline-block mt-1 pl-0">
                                            <span class="js-accordion-toggle-inactive">
                                                {{ 'Ver todos' | translate }}
                                            </span>
                                            <span class="js-accordion-toggle-active" style="display: none;">
                                                {{ 'Ver menos' | translate }}
                                            </span>
                                        </a>
                                    {% endif %}
                                {% endfor %}
                            </div>
                        </div>
                    </details>
                {% endif %}
            {% endfor %}
        </div>
    {% endif %}
{% endif %}
