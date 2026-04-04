{# Exhibidor: productos de Destacados (sections.primary). Logo fondo = logo_negro según modo panel. #}
{% if sections is defined and sections.primary is defined and sections.primary.products is defined and sections.primary.products | length > 0 %}
	{% set logo_mode = settings.julia_home_exhibitor_logo_mode | default('auto') %}
	{% if logo_mode == 'blanco' %}
		{% set logo_file = 'logo-blanco-placeholder.png' %}
		{% set exhibitor_logo_light = true %}
	{% else %}
		{% set logo_file = 'logo-negro-placeholder.png' %}
		{% set exhibitor_logo_light = false %}
	{% endif %}
	{% set logo_has_custom = logo_file | has_custom_image %}
	{% set op_key = settings.julia_home_exhibitor_logo_opacity | default('opacity_80') %}
	{% if op_key == 'opacity_50' %}
		{% set op_raw = '0.5' %}
	{% elseif op_key == 'opacity_65' %}
		{% set op_raw = '0.65' %}
	{% elseif op_key == 'opacity_100' %}
		{% set op_raw = '1' %}
	{% else %}
		{% set op_raw = '0.8' %}
	{% endif %}
	{% set catalog_url_setting = settings.julia_home_exhibitor_catalog_url | default('') | trim %}
	{% set catalog_label_setting = settings.julia_home_exhibitor_catalog_label | default('') | trim %}
	{% if catalog_url_setting %}
		{% set catalog_href = catalog_url_setting | setting_url %}
	{% elseif settings.julia_home_info_catalog_url %}
		{% set catalog_href = settings.julia_home_info_catalog_url | setting_url %}
	{% else %}
		{% set catalog_href = store.products_url %}
	{% endif %}
	{% if catalog_label_setting %}
		{% set catalog_label = catalog_label_setting %}
	{% else %}
		{% set catalog_label = settings.julia_home_info_catalog_label | default('Ver catálogo completo') %}
	{% endif %}
	{% set exhibitor_heading = settings.julia_home_exhibitor_heading | default('') | trim %}
	<section
		class="julia-home-exhibitor exhibitor"
		id="julia-home-exhibitor"
		data-store="home-julia-exhibitor"
		aria-label="{{ 'Más vendidos' | translate }}"
		style="--julia-exhibitor-logo-opacity: {{ op_raw }};"
	>
		<div class="julia-home-exhibitor__bg-logo" aria-hidden="true">
			{% if logo_has_custom %}
				<img
					class="julia-home-exhibitor__bg-img{% if exhibitor_logo_light %} julia-home-exhibitor__bg-img--light{% endif %}"
					src="{{ logo_file | static_url | settings_image_url('large') }}"
					alt=""
					loading="eager"
					decoding="async"
					onerror="this.style.display='none';this.nextElementSibling.classList.remove('julia-home-exhibitor__bg-fallback--hidden');"
				/>
				<span class="julia-home-exhibitor__bg-fallback julia-home-exhibitor__bg-fallback--hidden">{{ (settings.julia_home_wordmark | default('julia')) | lower }}</span>
			{% else %}
				<span class="julia-home-exhibitor__bg-fallback">{{ (settings.julia_home_wordmark | default('julia')) | lower }}</span>
			{% endif %}
		</div>

		{% if exhibitor_heading %}
			<div class="julia-home-exhibitor__heading-wrap">
				<h2 class="julia-home-exhibitor__heading">{{ exhibitor_heading }}</h2>
			</div>
		{% endif %}

		<div class="julia-home-exhibitor__carousel-wrap" id="juliaHomeExhibitorWrap">
			<div class="julia-home-exhibitor__track" id="juliaHomeExhibitorTrack">
				{% for product in sections.primary.products %}
					{% if loop.index <= 10 %}
					{% set cat_label = '' %}
					{% if product.categories is defined and product.categories | length > 0 %}
						{% set cat0 = product.categories[0] %}
						{% if cat0.name is defined %}
							{% set cat_label = cat0.name | trim %}
						{% endif %}
					{% endif %}
					{% if not cat_label and product.category %}
						{% if product.category.name is defined %}
							{% set cat_label = product.category.name | trim %}
						{% endif %}
					{% endif %}
					{% if not cat_label %}
						{% set cat_label = 'Productos' | translate %}
					{% endif %}
					<a href="{{ product.url }}" class="julia-exhibitor-card" data-store="home-julia-exhibitor-item-{{ product.id }}">
						<div class="julia-exhibitor-card__media">
							{% if product.featured_image %}
								<img
									class="julia-exhibitor-card__img"
									src="{{ product.featured_image | product_image_url('huge') }}"
									alt="{{ product.name }}"
									loading="lazy"
									decoding="async"
									sizes="(max-width: 768px) 45vw, 300px"
								/>
							{% else %}
								<div class="julia-exhibitor-card__ph" aria-hidden="true">
									<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1"><rect x="3" y="3" width="18" height="18" rx="2"/><path d="M3 9h18M9 21V9"/></svg>
								</div>
							{% endif %}
						</div>
						<span class="julia-exhibitor-card__title">{{ product.name }}</span>
						<span class="julia-exhibitor-card__subtitle">{{ cat_label }}</span>
						{% if product.display_price %}
							<span class="julia-exhibitor-card__price">
								{% if product.variations %}
									{{ 'Desde' | translate }} {{ product.price | money }}
								{% else %}
									{{ product.price | money }}
								{% endif %}
							</span>
						{% endif %}
					</a>
					{% endif %}
				{% endfor %}
			</div>
		</div>

		{% if catalog_label %}
			<div class="julia-home-exhibitor__footer">
				<a href="{{ catalog_href }}" class="julia-home-exhibitor__catalog-btn">{{ catalog_label }}</a>
			</div>
		{% endif %}
	</section>
{% endif %}
