<!DOCTYPE html>
<html class="{% if template == 'home' %}julia-html-home{% endif %}" xmlns="http://www.w3.org/1999/xhtml" xmlns:fb="http://www.facebook.com/2008/fbml" xmlns:og="http://opengraphprotocol.org/schema/" lang="{% for language in languages %}{% if language.active %}{{ language.lang }}{% endif %}{% endfor %}">
    <head>
        <link rel="preconnect" href="{{ store_resource_hints }}" />
        <link rel="dns-prefetch" href="{{ store_resource_hints }}" />
        <link rel="preconnect" href="https://fonts.googleapis.com" />
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <title>{{ page_title }}</title>
        <meta name="description" content="{{ page_description }}" />
        <link rel="preload" as="style" href="{{ [settings.font_headings, settings.font_rest] | google_fonts_url('300, 400, 700') }}" />
        <link rel="preload" href="{{ 'css/style-colors.scss.tpl' | static_url }}" as="style" />

        {# Preload LCP home, category and product page elements #}

        {% snipplet 'preload-images.tpl' %}

        {{ component('social-meta') }}

        {#/*============================================================================
            #CSS and fonts
        ==============================================================================*/#}

        {# Critical CSS needed to show first elements of store while CSS async is loading #}

        <style>
            {# Font families #}
            {{ component(
                'fonts',{
                    font_weights: '300, 400, 700',
                    font_settings: 'settings.font_headings, settings.font_rest'
                })
            }}

            {% include "static/css/style-critical.tpl" %}

            {# Inline mínimo: variables/tipografías desde settings #}
            {% include "static/css/style-colors-inline.tpl" %}
        </style>

        {# Colors and fonts used from settings.txt and defined on theme customization #}

        <link rel="stylesheet" href="{{ 'css/style-colors.scss.tpl' | static_url }}" media="print" onload="this.media='all'">

        {# Load async styling not mandatory for first meaningfull paint #}

        <link rel="stylesheet" href="{{ 'css/style-async.scss.tpl' | static_url }}" media="print" onload="this.media='all'">

        {#/*============================================================================
            #Javascript: Needed before HTML loads
        ==============================================================================*/#}

        {# Defines if async JS will be used by using script_tag(true) #}

        {% set async_js = true %}

        {# Defines the usage of jquery loaded below, if nojquery = true is deleted it will fallback to jquery 1.5 #}

        {% set nojquery = true %}

        {# Jquery async by adding script_tag(true) #}

        {% if load_jquery %}

            {{ '//ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js' | script_tag(true) }}

        {% endif %}

        {# Loads private Tiendanube JS #}

        {% head_content %}

        {# Structured data to provide information for Google about the page content #}

        {{ component('structured-data') }}

    </head>
    {# Julia Design: modos de encabezado (home / catálogo / páginas institucionales) #}
    {% set julia_head_mode = '' %}
    {% if template == 'home' %}
        {% set julia_head_mode = 'julia-head-mode--home' %}
    {% elseif template == 'category' %}
        {% set julia_head_mode = 'julia-head-mode--catalog' %}
    {% elseif template == 'page' and page is defined and page.handle is defined and page.handle in ['quienes-somos', 'como-trabajamos'] %}
        {% set julia_head_mode = 'julia-head-mode--static' %}
    {% endif %}

    <body class="{% if customer is defined and customer %}customer-logged-in{% endif %} template-{{ template | replace('.', '-') }}{% if julia_head_mode %} {{ julia_head_mode }}{% endif %}">
        {# Header = Advertising + Nav + Logo + Search + Ajax Cart #}

        {% snipplet "header/header.tpl" %}

        {# Page content #}

        {% template_content %}

        {% snipplet "footer/footer-julia.tpl" %}

        {# Modals overlay (menú, búsqueda, carrito viven en header.tpl) #}

        <div class="js-modal-overlay modal-overlay" style="display: none;"></div>

        <script type="text/javascript">
            {# Libraries that do NOT depend on other libraries, e.g: Jquery #}
            {% include "static/js/external-no-dependencies.js.tpl" %}

            {# LS.ready.then function waits to Jquery and private Tiendanube JS to be loaded before executing what´s inside #}

            LS.ready.then(function(){

                {# Libraries that requires Jquery to work #}

                {% include "static/js/external.js.tpl" %}

                {# Specific store JS functions: product variants, cart, shipping, etc #}

                {% include "static/js/store.js.tpl" %}
            });
        </script>
    </body>
</html>
