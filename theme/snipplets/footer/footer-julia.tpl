{# Pie editorial Julia: enlaces desde menús (Navegación); redes y WhatsApp aparte.
   Sello = solo footer_stamp_logo (nunca logo_blanco del header; mismos "original" en settings duplicaban la imagen en TN). #}
{% import "snipplets/julia-macros.tpl" as julia %}
{% set stamp_upload = julia.setting_image_value(attribute(settings, 'footer_stamp_logo') | default(null)) | trim %}
{% set letter_fb = (settings.footer_stamp_letter | default('j') | trim) | slice(0, 1) %}
{% if not letter_fb %}
	{% set letter_fb = 'j' %}
{% endif %}

{# Primera columna: categorías = subítems del primer ítem de navegación con submenú (misma lógica que el mega menú). #}
{% set footer_cat_parent = false %}
{% if navigation is defined %}
	{% for nav_item in navigation %}
		{% if not footer_cat_parent and nav_item.subitems %}
			{% set footer_cat_parent = nav_item %}
		{% endif %}
	{% endfor %}
{% endif %}
{% set has_cat_col = footer_cat_parent and footer_cat_parent.subitems is defined and (footer_cat_parent.subitems | length > 0) %}

{% set mk_info = settings.footer_julia_menu_info | default('') | trim %}
{% set mk_legal = settings.footer_julia_menu_legal | default('') | trim %}

{# Paréntesis: evita ambigüedad entre filtros y and #}
{% set show_ig = (settings.footer_social_show_instagram | default(1)) and store.instagram %}
{% set show_fb = (settings.footer_social_show_facebook | default(1)) and store.facebook %}
{% set show_wa = settings.footer_social_show_whatsapp | default(1) %}
{% set wa_url = settings.footer_whatsapp_url | default('') | trim %}

{% set has_m2 = menus is defined and mk_info and attribute(menus, mk_info) is not empty %}
{% set has_legal_nav = menus is defined and mk_legal and attribute(menus, mk_legal) is not empty %}

{% set show_social_block = show_ig or show_fb or (show_wa and wa_url) %}
{% set show_col2 = has_m2 or show_social_block %}

{% set h_muebles = settings.footer_heading_muebles | default('') | trim %}
{% set h_info = settings.footer_heading_info | default('') | trim %}

<footer class="julia-footer js-footer js-hide-footer-while-scrolling display-when-content-ready" data-store="footer">
	<div class="julia-footer__inner">
		{% if has_cat_col or show_col2 %}
			<div class="footer-cols">
				{% if has_cat_col %}
					<div class="footer-cols__col">
						<span class="footer-col-label">{% if h_muebles %}{{ h_muebles }}{% else %}{{ "Categorías" | translate }}{% endif %}</span>
						<ul class="footer-nav">
							{% for sub in footer_cat_parent.subitems %}
								<li{% if loop.last %} class="footer-nav-extra"{% endif %}>
									<a href="{% if sub.url %}{{ sub.url | setting_url }}{% else %}#{% endif %}">{{ sub.name }}</a>
								</li>
							{% endfor %}
						</ul>
					</div>
				{% endif %}
				{% if show_col2 %}
					<div class="footer-cols__col">
						{% if has_m2 %}
							<span class="footer-col-label">{% if h_info %}{{ h_info }}{% else %}{{ "Información" | translate }}{% endif %}</span>
							<ul class="footer-info-nav">
								{% for item in attribute(menus, mk_info) %}
									<li>
										<a href="{{ item.url }}"{% if item.url | is_external %} target="_blank" rel="noopener noreferrer"{% endif %}>{{ item.name }}</a>
									</li>
								{% endfor %}
							</ul>
						{% endif %}
						{% if show_social_block %}
							<div class="footer-social">
								{% if show_ig %}
									<a href="{{ store.instagram }}" target="_blank" rel="noopener noreferrer" aria-label="Instagram">
										<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" aria-hidden="true"><rect x="2" y="2" width="20" height="20" rx="5"/><circle cx="12" cy="12" r="4"/><circle cx="17.5" cy="6.5" r=".5" fill="currentColor" stroke="none"/></svg>
									</a>
								{% endif %}
								{% if show_fb %}
									<a href="{{ store.facebook }}" target="_blank" rel="noopener noreferrer" aria-label="Facebook">
										<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" aria-hidden="true"><path d="M18 2h-3a5 5 0 00-5 5v3H7v4h3v8h4v-8h3l1-4h-4V7a1 1 0 011-1h3z"/></svg>
									</a>
								{% endif %}
								{% if show_wa and wa_url %}
									<a href="{{ wa_url | setting_url }}" target="_blank" rel="noopener noreferrer" aria-label="WhatsApp">
										<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" aria-hidden="true"><path d="M21 11.5a8.38 8.38 0 01-.9 3.8 8.5 8.5 0 01-7.6 4.7 8.38 8.38 0 01-3.8-.9L3 21l1.9-5.7a8.38 8.38 0 01-.9-3.8 8.5 8.5 0 014.7-7.6 8.38 8.38 0 013.8-.9h.5a8.48 8.48 0 018 8v.5z"/></svg>
									</a>
								{% endif %}
							</div>
						{% endif %}
					</div>
				{% endif %}
			</div>
		{% endif %}

		<div class="footer-logo-row">
			<div class="footer-stamp">
				{% if stamp_upload %}
					{% set stamp_http = (stamp_upload | slice(0, 8) == 'https://') or (stamp_upload | slice(0, 7) == 'http://') %}
					<img
						class="footer-stamp__img"
						{% if stamp_http %}
						src="{{ stamp_upload }}"
						srcset="{{ stamp_upload }} 1x, {{ stamp_upload }} 2x"
						{% else %}
						src="{{ stamp_upload | static_url | settings_image_url('large') }}"
						srcset="{{ stamp_upload | static_url | settings_image_url('large') }} 1x, {{ stamp_upload | static_url | settings_image_url('huge') }} 2x"
						{% endif %}
						alt="{{ store.name }}"
						loading="lazy"
						decoding="async"
						width="64"
						height="64"
					/>
				{% else %}
					<span class="footer-stamp__wordmark" aria-hidden="true">{{ letter_fb }}</span>
				{% endif %}
			</div>
		</div>

		{% if has_legal_nav %}
			<div class="footer-legal-row">
				<ul class="footer-legal">
					{% for item in attribute(menus, mk_legal) %}
						<li>
							<a href="{{ item.url }}"{% if item.url | is_external %} target="_blank" rel="noopener noreferrer"{% endif %}>{{ item.name }}</a>
						</li>
					{% endfor %}
				</ul>
				<span class="footer-copy">© {{ "now" | date('Y') }} {{ store.name }}</span>
			</div>
		{% else %}
			<div class="footer-legal-row footer-legal-row--copy-only">
				<span class="footer-copy">© {{ "now" | date('Y') }} {{ store.name }}</span>
			</div>
		{% endif %}

		<div class="julia-footer__powered">
			{% if new_powered_by_link is defined %}
				{{ new_powered_by_link }}
			{% endif %}
		</div>
	</div>
</footer>
