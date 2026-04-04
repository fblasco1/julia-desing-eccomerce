{# Menú desktop: primer ítem con subítems → mega menú (prototipo home.html); resto enlaces planos. #}
{% if navigation %}
	{% set mega_index = -1 %}
	{% for item in navigation %}
		{% if mega_index < 0 and item.subitems %}
			{% set mega_index = loop.index0 %}
		{% endif %}
	{% endfor %}

<nav class="julia-nav-desktop" aria-label="{{ 'Menú principal' | translate }}" data-component="menu">
	<ul class="julia-nav-desktop-list julia-nav-links">
		{% if mega_index >= 0 %}
			{% for nav_item in navigation %}
				{% if loop.index0 == mega_index %}
			<li class="julia-nav-mega-trigger" id="julia-mega-trigger" data-component="menu.item">
				<button type="button" class="nav-muebles-btn js-julia-mega-btn{% if nav_item.current %} nav-muebles-btn--current{% endif %}" id="julia-mega-btn" aria-expanded="false" aria-controls="julia-mega-menu"{% if nav_item.current %} aria-current="page"{% endif %}>
					{{ nav_item.name }}
					<svg class="nav-arrow" viewBox="0 0 10 6" aria-hidden="true"><polyline points="1 1 5 5 9 1" fill="none" stroke="currentColor" stroke-width="2"/></svg>
				</button>
			</li>
				{% endif %}
			{% endfor %}
			{% for item in navigation %}
				{% if loop.index0 != mega_index %}
					<li class="julia-nav-desktop-item julia-nav-plain-item">
						<a class="julia-nav-desktop-link julia-nav-plain-link{% if item.current %} julia-nav-desktop-link--current{% endif %}" href="{% if item.url %}{{ item.url | setting_url }}{% else %}#{% endif %}"{% if item.current %} aria-current="page"{% endif %}>{{ item.name }}</a>
					</li>
				{% endif %}
			{% endfor %}
		{% else %}
			{% for item in navigation %}
				<li class="julia-nav-desktop-item">
					{% if item.subitems %}
						<details class="julia-nav-desktop-details">
							<summary class="julia-nav-desktop-summary{% if item.current %} julia-nav-desktop-link--current{% endif %}">
								{{ item.name }}
								{% include "snipplets/svg/chevron-down.tpl" with {svg_custom_class: "icon-inline icon-w-8 julia-nav-desktop-chevron svg-icon-text"} %}
							</summary>
							<div class="julia-nav-desktop-panel">
								<ul class="julia-nav-desktop-sub">
									{% if item.isCategory %}
										<li>
											<a class="julia-nav-desktop-sub-link" href="{{ item.url | setting_url }}">
												{% if item.isRootCategory %}
													{{ 'Ver todos los productos' | translate }}
												{% else %}
													{{ 'Ver todo en' | translate }} {{ item.name }}
												{% endif %}
											</a>
										</li>
									{% endif %}
									{% for sub in item.subitems %}
										<li>
											<a class="julia-nav-desktop-sub-link" href="{% if sub.url %}{{ sub.url | setting_url }}{% else %}#{% endif %}">{{ sub.name }}</a>
										</li>
									{% endfor %}
								</ul>
							</div>
						</details>
					{% else %}
						<a class="julia-nav-desktop-link{% if item.current %} julia-nav-desktop-link--current{% endif %}" href="{% if item.url %}{{ item.url | setting_url }}{% else %}#{% endif %}"{% if item.current %} aria-current="page"{% endif %}>{{ item.name }}</a>
					{% endif %}
				</li>
			{% endfor %}
		{% endif %}
	</ul>
</nav>
{% endif %}
