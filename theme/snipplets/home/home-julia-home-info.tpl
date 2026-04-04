{# Sección 2 — prototipo home.html (info): grid 50/50, fondo visón (--mink) #}
{% set catalog_href = settings.julia_home_info_catalog_url ? (settings.julia_home_info_catalog_url | setting_url) : store.products_url %}
{% set has_acc =
	(settings.julia_home_info_acc_1_title | trim) or (settings.julia_home_info_acc_1_body | trim)
	or (settings.julia_home_info_acc_2_title | trim) or (settings.julia_home_info_acc_2_body | trim)
	or (settings.julia_home_info_acc_3_title | trim) or (settings.julia_home_info_acc_3_body | trim)
	or (settings.julia_home_info_acc_4_title | trim) or (settings.julia_home_info_acc_4_body | trim)
%}
{% set has_info_content =
	(settings.julia_home_info_title | trim) or (settings.julia_home_info_subtitle | trim)
	or (settings.julia_home_info_catalog_label | trim) or (settings.julia_home_info_intro | trim) or has_acc
%}
{% if has_info_content %}
<section class="julia-home-info info" id="julia-home-info" data-store="home-julia-info" aria-label="{{ 'Información' | translate }}">
	<div class="julia-home-info__left info-left">
		{% if settings.julia_home_info_title %}
			<h2 class="julia-home-info__headline info-headline">
				{% for part in settings.julia_home_info_title | split('\n') %}
					{% if not loop.first %}<br />{% endif %}{{ part | trim }}
				{% endfor %}
			</h2>
		{% endif %}
		{% if settings.julia_home_info_subtitle %}
			<p class="julia-home-info__lead info-lead">
				{% for part in settings.julia_home_info_subtitle | split('\n') %}
					{% if not loop.first %}<br />{% endif %}{{ part | trim }}
				{% endfor %}
			</p>
		{% endif %}
		{% if settings.julia_home_info_catalog_label %}
			<a class="julia-home-info__catalog btn-catalog-sage" href="{{ catalog_href }}">{{ settings.julia_home_info_catalog_label }}</a>
		{% endif %}
	</div>
	<div class="julia-home-info__right info-right">
		{% if settings.julia_home_info_intro %}
			<p class="julia-home-info__intro info-intro">
				{% for part in settings.julia_home_info_intro | split('\n') %}
					{% if not loop.first %}<br />{% endif %}{{ part | trim }}
				{% endfor %}
			</p>
		{% endif %}
		{% if has_acc %}
			<div class="julia-home-info__accordion accordion">
				{% for i in 1..4 %}
					{% set acc_t = attribute(settings, 'julia_home_info_acc_' ~ i ~ '_title') %}
					{% set acc_b = attribute(settings, 'julia_home_info_acc_' ~ i ~ '_body') %}
					{% if acc_t | trim or acc_b | trim %}
						<div class="acc-item">
							<div class="acc-header" role="button" tabindex="0" aria-expanded="false">
								<span class="acc-title">{{ acc_t | trim }}</span>
								<svg class="acc-icon" viewBox="0 0 24 24" aria-hidden="true"><line x1="12" y1="5" x2="12" y2="19" /><line x1="5" y1="12" x2="19" y2="12" /></svg>
							</div>
							<div class="acc-body">
								{% if acc_b | trim %}
									<p>
										{% for part in acc_b | split('\n') %}
											{% if not loop.first %}<br />{% endif %}{{ part | trim }}
										{% endfor %}
									</p>
								{% endif %}
							</div>
						</div>
					{% endif %}
				{% endfor %}
			</div>
		{% endif %}
	</div>
</section>
{% endif %}
