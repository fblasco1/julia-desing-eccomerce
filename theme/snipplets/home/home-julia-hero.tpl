{# Hero 50/50 — prototipo home.html (sección 1) #}
{% set julia_hero_first = settings.home_order_position_0 == 'julia_hero' %}
{% set julia_hero_img = 'julia_hero.jpg' | has_custom_image %}
{% set hero_cta_href = settings.julia_hero_cta_url ? (settings.julia_hero_cta_url | setting_url) : store.products_url %}
{% set hero_secondary_href = '#' %}
{% if settings.julia_hero_secondary_url is defined and settings.julia_hero_secondary_url %}
	{% set hero_secondary_href = settings.julia_hero_secondary_url | setting_url %}
{% endif %}
{% set julia_hero_secondary_label = '' %}
{% if settings.julia_hero_secondary_label is defined %}
	{% set julia_hero_secondary_label = settings.julia_hero_secondary_label %}
{% endif %}

<section class="julia-home-hero hero" id="julia-home-hero" data-store="home-julia-hero">
	<div class="julia-home-hero__left hero-left">
		{# Franja marrón como prototype/home.html (.hero-strip); ancla vertical del logo en store.js #}
		<div class="julia-home-hero__strip" aria-hidden="true"></div>
		<div class="hero-img">
			{% if julia_hero_img %}
				<img
					src="{{ 'julia_hero.jpg' | static_url | settings_image_url('large') }}"
					srcset="{{ 'julia_hero.jpg' | static_url | settings_image_url('xlarge') }} 1400w, {{ 'julia_hero.jpg' | static_url | settings_image_url('1080p') }} 1920w"
					alt="{{ settings.julia_hero_title | default(store.name) | e }}"
					class="julia-home-hero__img"
					loading="{% if julia_hero_first %}eager{% else %}lazy{% endif %}"
					{% if julia_hero_first %}fetchpriority="high"{% endif %}
					decoding="async"
					width="1400"
					height="1800"
				/>
			{% else %}
				<div class="hero-img-ph julia-home-hero__ph">
					<span>{{ 'Cargá la imagen del hero desde el panel del tema' | translate }}</span>
				</div>
			{% endif %}
		</div>
	</div>
	<div class="hero-copy julia-home-hero__copy">
		<div class="hero-copy-inner">
			{% if settings.julia_hero_title %}
				<h1 class="hero-tagline">
					{% for part in settings.julia_hero_title | split('\n') %}
						{% if not loop.first %}<br />{% endif %}{{ part | trim }}
					{% endfor %}
				</h1>
			{% endif %}
			{% if settings.julia_hero_subtitle %}
				<p class="hero-sub">
					{% for part in settings.julia_hero_subtitle | split('\n') %}
						{% if not loop.first %}<br />{% endif %}{{ part | trim }}
					{% endfor %}
				</p>
			{% endif %}
			{% if settings.julia_hero_cta_label or julia_hero_secondary_label %}
				<div class="hero-cta">
					{% if settings.julia_hero_cta_label %}
						<a class="btn-primary julia-home-hero__cta" href="{{ hero_cta_href }}">{{ settings.julia_hero_cta_label }}</a>
					{% endif %}
					{% if julia_hero_secondary_label %}
						<a class="hero-cta-secondary julia-home-hero__cta-secondary" href="{{ hero_secondary_href }}">{{ julia_hero_secondary_label }}</a>
					{% endif %}
				</div>
			{% endif %}
		</div>
	</div>
</section>
