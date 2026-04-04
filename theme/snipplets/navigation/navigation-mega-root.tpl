{# Panel mega a nivel de body (fuera de .head-main) para que position:fixed cubra el viewport. #}
{% if navigation %}
	{% set mega_index = -1 %}
	{% for item in navigation %}
		{% if mega_index < 0 and item.subitems %}
			{% set mega_index = loop.index0 %}
		{% endif %}
	{% endfor %}
	{% if mega_index >= 0 %}
		{% for nav_item in navigation %}
			{% if loop.index0 == mega_index %}
				{% include "snipplets/navigation/navigation-mega-panel.tpl" with { mega_parent: nav_item } %}
			{% endif %}
		{% endfor %}
	{% endif %}
{% endif %}
