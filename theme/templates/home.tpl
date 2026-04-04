{# Home: navbar en layout. Hero Julia + info + exhibidor; sin bucle home_order completo. #}

{% set has_julia_hero = settings.julia_hero_title or settings.julia_hero_subtitle or settings.julia_hero_cta_label or ('julia_hero.jpg' | has_custom_image) %}
{% set show_component_help = params is defined and params.preview %}

{% if params is not defined or not params.preview %}
	{% set admin_link = '/admin/themes/settings/active/' %}
	{% if is_theme_draft is defined and is_theme_draft %}
		{% set admin_link = '/admin/themes/settings/draft/' %}
	{% endif %}
{% endif %}

<div class="js-home-sections-container">
	{% if show_component_help and not has_julia_hero %}
		{% include 'snipplets/defaults/home/julia_hero_help.tpl' %}
	{% else %}
		{% include 'snipplets/home/home-julia-hero.tpl' %}
	{% endif %}
	{% if settings.julia_home_info_show | default(1) %}
		{% include 'snipplets/home/home-julia-home-info.tpl' %}
	{% endif %}
	{% if settings.julia_home_exhibitor_show | default(1) %}
		{% include 'snipplets/home/home-julia-exhibitor.tpl' %}
	{% endif %}
</div>
