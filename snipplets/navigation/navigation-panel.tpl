{% if primary_links %}
    <div class="nav-primary">
        <ul class="nav-list" data-store="navigation" data-component="menu">
            {% include 'snipplets/navigation/navigation-nav-list.tpl' with { 'hamburger' : true  } %}
        </ul>
    </div>
{% else %}
    {# Julia Design: sin bloque de login / crear cuenta en el pie del menú hamburguesa #}
{% endif %}