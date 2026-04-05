{# Cómo trabajamos — split + FAQ (hasta 10); categoría opcional agrupa títulos; settings (handle: como-trabajamos) #}
{% set inst_media_bg = settings.julia_inst_media_bg | default('#D2D0D0') %}
{% set inst_panel_bg = settings.julia_inst_panel_bg | default('#54463D') %}
<main
	class="julia-inst-split julia-inst-split--como"
	style="--julia-inst-media-bg: {{ inst_media_bg }}; --julia-inst-panel-bg: {{ inst_panel_bg }};"
>
	<div class="julia-inst-split__media">
		{% if 'julia_inst_como_hero.jpg' | has_custom_image %}
			<img
				class="julia-inst-split__img"
				src="{{ 'julia_inst_como_hero.jpg' | static_url | settings_image_url('large') }}"
				srcset="{{ 'julia_inst_como_hero.jpg' | static_url | settings_image_url('large') }} 1x, {{ 'julia_inst_como_hero.jpg' | static_url | settings_image_url('1080p') }} 2x"
				alt="{% if settings.julia_inst_como_title %}{{ settings.julia_inst_como_title | e }}{% else %}{{ 'Cómo Trabajamos' | translate }}{% endif %}"
				loading="eager"
				decoding="async"
				width="1400"
				height="1800"
			/>
		{% else %}
			<div class="julia-inst-split__media-ph" aria-hidden="true"></div>
		{% endif %}
	</div>
	<section class="julia-inst-split__panel">
		{% if settings.julia_inst_como_title %}
			<h1 class="julia-inst-split__title">{{ settings.julia_inst_como_title | nl2br | raw }}</h1>
		{% endif %}
		<div class="julia-inst-faq-list">
			{% set prev_cat = false %}
			{% for i in 1..10 %}
				{% set faq_t = attribute(settings, 'julia_inst_como_faq_' ~ i ~ '_title') %}
				{% set faq_b = attribute(settings, 'julia_inst_como_faq_' ~ i ~ '_body') %}
				{% set faq_c = attribute(settings, 'julia_inst_como_faq_' ~ i ~ '_category') | default('') | trim %}
				{% if faq_t is defined and faq_t | trim %}
					{% if faq_c != '' %}
						{% if prev_cat is same as(false) or faq_c != prev_cat %}
							<h2 class="julia-inst-faq-group">{{ faq_c | e }}</h2>
						{% endif %}
						{% set prev_cat = faq_c %}
					{% else %}
						{% set prev_cat = false %}
					{% endif %}
					<article class="julia-inst-faq-item">
						<button type="button" class="julia-inst-faq-trigger" aria-expanded="false">
							<span class="julia-inst-faq-q">{{ faq_t | nl2br | raw }}</span>
							<span class="julia-inst-faq-plus" aria-hidden="true"></span>
						</button>
						<div class="julia-inst-faq-content">
							{% if faq_b is defined and faq_b | trim %}
								<div class="julia-inst-faq-answer">{{ faq_b | nl2br | raw }}</div>
							{% endif %}
						</div>
					</article>
				{% endif %}
			{% endfor %}
		</div>
	</section>
</main>
