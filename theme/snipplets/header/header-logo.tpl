{# Logo encabezado — image settings TN: clave = original filename, filtro has_custom_image. #}
{# Fondo claro (catálogo, PDP Lusano crema): logo oscuro para contraste #}
{% set julia_catalog = template == 'category' %}
{% set use_logo_negro = julia_catalog or (template == 'product') or (settings.head_background == 'light') %}
{% if use_logo_negro %}
	{% set logo_file = 'logo-negro-placeholder.png' %}
	{% set logo_file_alt = 'logo-blanco-placeholder.png' %}
{% else %}
	{% set logo_file = 'logo-blanco-placeholder.png' %}
	{% set logo_file_alt = 'logo-negro-placeholder.png' %}
{% endif %}
{% if logo_file | has_custom_image %}
	{% set logo_src = logo_file | static_url | settings_image_url('large') %}
{% elseif logo_file_alt | has_custom_image %}
	{% set logo_src = logo_file_alt | static_url | settings_image_url('large') %}
{% else %}
	{% set logo_src = '' %}
{% endif %}

{% if logo_src %}
	<div class="logo-img-container julia-header-logo-inner">
		<a href="{{ store.url }}" title="{{ store.name }}">
			<img
				src="{{ logo_src }}"
				alt="{{ store.name }}"
				class="logo-img transition-soft-slow"
				loading="eager"
			/>
		</a>
	</div>
{% else %}
	{{ component('logos/logo', { logo_size: 'medium', logo_img_classes: 'transition-soft-slow logo-img', logo_text_classes: 'logo-text h1 m-0' }) }}
{% endif %}
