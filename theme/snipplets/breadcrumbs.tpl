{# /*============================================================================
  #Page breadcrumbs
==============================================================================*/
#Properties

#Breadcrumb
    //breadcrumbs_custom_class for custom CSS classes
#}

{% if breadcrumbs %}
    <div class="breadcrumbs {{ breadcrumbs_custom_class }}">
        <a class="crumb" href="{{ store.url }}" title="{{ store.name }}">{{ "Inicio" | translate }}</a>
        <span class="divider">></span>
        {% if template == 'page' %}
            <span class="crumb active">{{ page.name }}</span>
        {% elseif template == 'cart' %}
            <span class="crumb active">{{ "Carrito de compras" | translate }}</span>
        {% elseif template == 'search' %}
            <span class="crumb active">{{ "Resultados de búsqueda" | translate }}</span>
        {% elseif template == 'account.order' %}
             <span class="crumb active">{{ 'Orden {1}' | translate(order.number) }}</span>
        {% elseif template == 'blog' %}
             <span class="crumb active">{{ 'Blog' | translate }}</span>
        {% elseif template == 'blog-post' %}
             <a href="{{ store.blog_url }}" class="crumb">{{ 'Blog' | translate }}</a>
             <span class="divider">></span>
             <span class="crumb active">{{ post.title }}</span>
        {% else %}
            {% for crumb in breadcrumbs %}
                {% if crumb.last %}
                    <span class="crumb active">{{ crumb.name }}</span>
                {% else %}
                    <a class="crumb" href="{{ crumb.url }}" title="{{ crumb.name }}">{{ crumb.name }}</a>
    	            <span class="divider">></span>
                {% endif %}
            {% endfor %}
        {% endif %}
    </div>

    {# SEO: BreadcrumbList JSON-LD (solo cuando TN provee urls en "breadcrumbs") #}
    {% if template != 'page'
        and template != 'cart'
        and template != 'search'
        and template != 'account.order'
        and template != 'blog'
        and template != 'blog-post'
        and breadcrumbs is defined
        and breadcrumbs is not empty %}
        {% set crumb_items = [{
            '@type': 'ListItem',
            'position': 1,
            'name': 'Inicio' | translate,
            'item': store.url
        }] %}
        {% set pos = 2 %}
        {% for crumb in breadcrumbs %}
            {% if crumb.url is defined and crumb.url %}
                {% set crumb_items = crumb_items | merge([{
                    '@type': 'ListItem',
                    'position': pos,
                    'name': crumb.name,
                    'item': crumb.url
                }]) %}
                {% set pos = pos + 1 %}
            {% endif %}
        {% endfor %}
        {% if crumb_items | length > 1 %}
            <script type="application/ld+json">
                {{ {
                    '@context': 'https://schema.org',
                    '@type': 'BreadcrumbList',
                    'itemListElement': crumb_items
                } | json_encode | raw }}
            </script>
        {% endif %}
    {% endif %}
{% endif %}
