{# Carrusel infinito — productos destacados (sections.primary) + spruce-carousel.js #}
{% set julia_products = [] %}
{% if sections is defined and sections.primary is defined and sections.primary.products is defined %}
    {% set julia_products = sections.primary.products %}
{% endif %}

{% if julia_products | length > 0 %}
    <section id="julia-catalogo" class="julia-home__catalog" aria-label="{{ 'Productos destacados' | translate }}">
        {% if 'julia-spruce-bg-logo.png' | has_custom_image %}
            <div class="julia-home__catalog-logo-bg">
                <img src="{{ 'images/julia-spruce-bg-logo.png' | static_url }}" alt="" />
            </div>
        {% endif %}

        <div class="julia-home__catalog-inner w-100 overflow-hidden">
            <div
                data-spruce-carousel
                data-speed="65"
                class="position-relative"
                aria-label="{{ 'Productos destacados' | translate }}"
            >
                <div class="spruce-carousel-viewport overflow-hidden">
                    <div class="spruce-carousel-track d-flex" data-track>
                        {% for product in julia_products | slice(0, 16) %}
                            <a
                                href="{{ product.url }}"
                                class="julia-home__product-card spruce-carousel-item text-decoration-none"
                                data-component="product-list-item"
                                data-component-value="{{ product.id }}"
                            >
                                <div class="julia-home__product-media">
                                    {% if product.featured_image %}
                                        <img
                                            src="{{ product.featured_image | product_image_url('large') }}"
                                            alt="{{ product.name }}"
                                            loading="{% if loop.first %}eager{% else %}lazy{% endif %}"
                                            {% if loop.first %}fetchpriority="high"{% endif %}
                                            decoding="async"
                                            width="400"
                                            height="400"
                                        />
                                    {% else %}
                                        <img src="{{ 'images/empty-placeholder.png' | static_url }}" alt="{{ product.name }}" loading="lazy" />
                                    {% endif %}
                                </div>
                                <div>
                                    <h3 class="julia-home__product-name">{{ product.name }}</h3>
                                    {% if product.display_price %}
                                        <p class="julia-home__product-price">
                                            {% if product.compare_at_price %}
                                                <span style="opacity: 0.55; text-decoration: line-through; margin-right: 0.35rem;">{{ product.compare_at_price | money }}</span>
                                            {% endif %}
                                            {{ product.price | money }}
                                        </p>
                                    {% endif %}
                                </div>
                            </a>
                        {% endfor %}
                    </div>
                </div>
            </div>
        </div>

        <div class="text-center mt-5">
            <a class="julia-btn-solid" href="{{ store.products_url }}">{{ 'Ver todo el catálogo' | translate }}</a>
        </div>
    </section>
{% endif %}
