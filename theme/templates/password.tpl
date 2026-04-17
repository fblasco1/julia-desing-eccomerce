<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:fb="http://www.facebook.com/2008/fbml" xmlns:og="http://opengraphprotocol.org/schema/">
    <head>
        <link rel="preconnect" href="{{ store_resource_hints }}" />
        <link rel="dns-prefetch" href="{{ store_resource_hints }}" />
        <link rel="preconnect" href="https://fonts.googleapis.com" />
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>{{ page_title }}</title>
        <meta name="description" content="{{ page_description }}" />
        {% if settings.font_headings is defined and settings.font_rest is defined %}
        <link rel="preload" as="style" href="{{ [settings.font_headings, settings.font_rest] | google_fonts_url('300, 400, 700') }}" />
        {% endif %}
        <link rel="preload" href="{{ 'css/style-colors.scss.tpl' | static_url }}" as="style" />
        
        {{ component('social-meta') }}

        {#/*============================================================================
            #CSS and fonts
        ==============================================================================*/#}

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

        {# Carga completa (no-inline) de colores/tipografías basadas en settings #}

        <link rel="stylesheet" href="{{ 'css/style-colors.scss.tpl' | static_url }}" media="print" onload="this.media='all'">

        {# Load async styling not mandatory for first meaningfull paint #}

        <link rel="stylesheet" href="{{ 'css/style-async.scss.tpl' | static_url }}" media="print" onload="this.media='all'">

        {# Loads custom CSS added from Advanced Settings on the admin´s theme customization screen #}

        <style>
            {{ settings.css_code | default('') | raw }}
        </style>

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

        {# Loads private Tienda Nube JS #}

        {% head_content %}

        {# Structured data to provide information for Google about the page content #}

        {{ component('structured-data') }}

    </head>
    <body class="{% if customer is defined and customer %}customer-logged-in{% endif %} template-{{ (template | default('password')) | replace('.', '-') }}">

        {# Back to admin bar #}

        {{back_to_admin}}

        {# Page content #}

        <section class="section-password">
            <div class="container">
                <div class="row justify-content-md-center">
                    <div class="col-md-8 text-center">
                        <div class="my-5">
                            {{ component('logos/logo', {logo_size: 'large', logo_img_classes: 'transition-soft-slow', logo_text_classes: 'h1 m-0'}) }}
                        </div>

                        <h2 class="mb-5">{{ message | default('') }}</h2>
                        {# En preview del editor, store.customer_reset_password_url puede no existir: evitar 500 al compilar #}
                        {% set password_reset_url = store.customer_reset_password_url is defined ? (store.customer_reset_password_url | default('')) : '' %}
                        {% embed "snipplets/forms/form.tpl" with{form_id: 'password-form', submit_text: 'Desbloquear' | translate } %}
                            {% block form_body %}

                                {% embed "snipplets/forms/form-input.tpl" with{input_for: 'password', type_password: true, input_name: 'password', input_help: password_reset_url, input_help_link: password_reset_url, input_label_text: 'Contraseña de acceso' | translate } %}
                                    {% block input_help_text %}{{ '¿Olvidaste tu contraseña?' | translate }}{% endblock input_help_text %}
                                    {% block input_form_alert %}
                                        {% if invalid_password == true %}
                                            <div class="alert alert-danger">{{ 'La contraseña es incorrecta.' | translate }}</div>
                                        {% endif %}
                                    {% endblock input_form_alert %}
                                {% endembed %}

                            {% endblock %}
                        {% endembed %}

                    </div>
                </div>
            </div>
        </section>


        {# Pie: mismo que el resto del theme (footer.tpl legacy usa claim-info y puede fallar al compilar en /password) #}

        {% snipplet "footer/footer-julia.tpl" %}

        {# Javascript needed to footer logos lazyload #}

        <script type="text/javascript">
            {% include "static/js/external-no-dependencies.js.tpl" %}
        </script>
    </body>
</html>
