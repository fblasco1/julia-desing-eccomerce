{# Quiénes somos — layout split; datos desde settings (handle de página: quienes-somos) #}
{% set inst_media_bg = settings.julia_inst_media_bg | default('#D2D0D0') %}
{% set inst_panel_bg = settings.julia_inst_panel_bg | default('#54463D') %}
<main
	class="julia-inst-split julia-inst-split--quienes"
	style="--julia-inst-media-bg: {{ inst_media_bg }}; --julia-inst-panel-bg: {{ inst_panel_bg }};"
>
	<div class="julia-inst-split__media">
		{% if 'julia_inst_quienes_hero.jpg' | has_custom_image %}
			<img
				class="julia-inst-split__img"
				src="{{ 'julia_inst_quienes_hero.jpg' | static_url | settings_image_url('large') }}"
				srcset="{{ 'julia_inst_quienes_hero.jpg' | static_url | settings_image_url('large') }} 1x, {{ 'julia_inst_quienes_hero.jpg' | static_url | settings_image_url('1080p') }} 2x"
				alt="{% if settings.julia_inst_quienes_title %}{{ settings.julia_inst_quienes_title | e }}{% else %}{{ 'Quiénes Somos' | translate }}{% endif %}"
				loading="eager"
				decoding="async"
				width="1400"
				height="1800"
			/>
		{% else %}
			<div class="julia-inst-split__media-ph" aria-hidden="true"></div>
		{% endif %}
	</div>
	<div class="julia-inst-split__panel">
		{% if settings.julia_inst_quienes_title %}
			<h1 class="julia-inst-split__title">{{ settings.julia_inst_quienes_title | nl2br | raw }}</h1>
		{% endif %}
		<div class="julia-inst-split__body julia-inst-split__body--about julia-inst-user-html">
			{# Texto principal: editor enriquecido del admin (Páginas → Quienes somos → Contenido). #}
			{% if page is defined and page.content is defined and page.content | trim %}
				{{ page.content | raw }}
			{% else %}
				{% if settings.julia_inst_quienes_p1 %}
					<p class="julia-inst-split__p">{{ settings.julia_inst_quienes_p1 | nl2br | raw }}</p>
				{% endif %}
				{% if settings.julia_inst_quienes_p2 %}
					<p class="julia-inst-split__p">{{ settings.julia_inst_quienes_p2 | nl2br | raw }}</p>
				{% endif %}
				{% if settings.julia_inst_quienes_p3 %}
					<p class="julia-inst-split__p">{{ settings.julia_inst_quienes_p3 | nl2br | raw }}</p>
				{% endif %}
			{% endif %}
		</div>
	</div>
</main>
