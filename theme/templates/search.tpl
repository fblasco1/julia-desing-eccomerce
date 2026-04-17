{% paginate by 12 %}

{% embed "snipplets/page-header.tpl" with { breadcrumbs: false } %}
	{% block page_header_text %}{{ "Búsqueda deshabilitada" | translate }}{% endblock page_header_text %}
{% endembed %}

<section class="category-body">
	<div class="container text-center">
		<p class="mb-3">{{ "Esta tienda no tiene buscador habilitado." | translate }}</p>
		<a class="btn btn-primary" href="{{ store.products_url }}">{{ "Ver productos" | translate }}</a>
	</div>
</section>