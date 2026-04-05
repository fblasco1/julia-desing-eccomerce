{% if template == 'page' and page is defined and page.handle is defined and page.handle == 'quienes-somos' %}
	{% include "snipplets/page-institutional-quienes.tpl" %}
{% elseif template == 'page' and page is defined and page.handle is defined and page.handle == 'como-trabajamos' %}
	{% include "snipplets/page-institutional-como.tpl" %}
{% else %}
	{% embed "snipplets/page-header.tpl" with {'breadcrumbs': true} %}
		{% block page_header_text %}{{ page.name }}{% endblock page_header_text %}
	{% endembed %}

	<section class="user-content">
		<div class="container">
			<div class="row justify-content-md-center">
				<div class="col-md-8">
					{{ page.content }}
				</div>
			</div>
		</div>
	</section>
{% endif %}
