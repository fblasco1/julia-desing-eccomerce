{% set ed1_url = store.contact_url %}
{% if settings.julia_editorial_1_link_url | default('') | trim != '' %}
    {% set ed1_url = settings.julia_editorial_1_link_url | setting_url %}
{% endif %}
{% set ed2_url = store.products_url %}
{% if settings.julia_editorial_2_link_url | default('') | trim != '' %}
    {% set ed2_url = settings.julia_editorial_2_link_url | setting_url %}
{% endif %}

<section class="julia-home__editorial">
    <div class="julia-home__editorial-grid">
        <div class="julia-home__editorial-col">
            <h3>
                {% if settings.julia_editorial_1_title | default('') | trim != '' %}
                    {{ settings.julia_editorial_1_title }}
                {% else %}
                    {{ 'Nuestra Historia' | translate }}
                {% endif %}
            </h3>
            <p>
                {% if settings.julia_editorial_1_text | default('') | trim != '' %}
                    {{ settings.julia_editorial_1_text }}
                {% else %}
                    {{ 'Somos una empresa familiar dedicada al diseño de autor. Transformamos materiales puros y crudos en piezas elegantes y duraderas.' | translate }}
                {% endif %}
            </p>
            <div class="julia-home__editorial-media">
                {% if 'julia_editorial_01.jpg' | has_custom_image %}
                    <img
                        src="{{ 'julia_editorial_01.jpg' | static_url }}"
                        alt=""
                        loading="lazy"
                        width="1000"
                        height="563"
                    />
                {% else %}
                    <img
                        src="https://images.unsplash.com/photo-1542013936693-884638332954?q=80&amp;w=1000&amp;auto=format&amp;fit=crop"
                        alt=""
                        loading="lazy"
                        width="1000"
                        height="563"
                    />
                {% endif %}
            </div>
            <div class="mt-4">
                <a class="julia-link-underline" href="{{ ed1_url }}">
                    {% if settings.julia_editorial_1_link_label | default('') | trim != '' %}
                        {{ settings.julia_editorial_1_link_label }}
                    {% else %}
                        {{ 'Leer más' | translate }}
                    {% endif %}
                </a>
            </div>
        </div>
        <div class="julia-home__editorial-col">
            <h3>
                {% if settings.julia_editorial_2_title | default('') | trim != '' %}
                    {{ settings.julia_editorial_2_title }}
                {% else %}
                    {{ 'Muebles de Exterior' | translate }}
                {% endif %}
            </h3>
            <p>
                {% if settings.julia_editorial_2_text | default('') | trim != '' %}
                    {{ settings.julia_editorial_2_text }}
                {% else %}
                    {{ 'Diseños preparados para resistir la intemperie, ideales para galerías y jardines. Un toque moderno para cualquier ambiente al aire libre.' | translate }}
                {% endif %}
            </p>
            <div class="julia-home__editorial-media">
                {% if 'julia_editorial_02.jpg' | has_custom_image %}
                    <img
                        src="{{ 'julia_editorial_02.jpg' | static_url }}"
                        alt=""
                        loading="lazy"
                        width="1000"
                        height="563"
                    />
                {% else %}
                    <img
                        src="https://images.unsplash.com/photo-1604578762246-41134e37f9cc?q=80&amp;w=1000&amp;auto=format&amp;fit=crop"
                        alt=""
                        loading="lazy"
                        width="1000"
                        height="563"
                    />
                {% endif %}
            </div>
            <div class="mt-4">
                <a class="julia-link-underline" href="{{ ed2_url }}">
                    {% if settings.julia_editorial_2_link_label | default('') | trim != '' %}
                        {{ settings.julia_editorial_2_link_label }}
                    {% else %}
                        {{ 'Ver colección' | translate }}
                    {% endif %}
                </a>
            </div>
        </div>
    </div>
</section>
