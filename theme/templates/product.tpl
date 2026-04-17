{# Julia Design — PDP editorial (layout Lusano: 3 columnas, scroll interno, 100vh) #}

<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:ital,wght@0,300;0,400;0,500;0,600;1,300;1,400;1,500;1,600&display=swap" />

{# Dimensiones: 1) Peso y dimensiones del admin (ancho × alto × profundidad en cm sobre la variante) 2) metacampos opcionales #}
{% set lusano_dimensiones = '' %}
{% if product.metafields is defined %}
  {% set lusano_dim_raw = null %}
  {% if product.metafields.specs is defined and product.metafields.specs.dimensiones is defined and product.metafields.specs.dimensiones %}
    {% set lusano_dim_raw = product.metafields.specs.dimensiones %}
  {% elseif product.metafields.custom is defined and product.metafields.custom.dimensiones is defined and product.metafields.custom.dimensiones %}
    {% set lusano_dim_raw = product.metafields.custom.dimensiones %}
  {% elseif product.metafields.specs is defined and product.metafields.specs.Dimensiones is defined and product.metafields.specs.Dimensiones %}
    {% set lusano_dim_raw = product.metafields.specs.Dimensiones %}
  {% elseif product.metafields.specs is defined and product.metafields.specs.dimensions is defined and product.metafields.specs.dimensions %}
    {% set lusano_dim_raw = product.metafields.specs.dimensions %}
  {% endif %}
  {% if lusano_dim_raw is not null and lusano_dim_raw is not same as(false) %}
    {% if lusano_dim_raw.value is defined %}
      {% set lusano_dimensiones = lusano_dim_raw.value %}
    {% else %}
      {% set lusano_dimensiones = lusano_dim_raw %}
    {% endif %}
  {% endif %}
{% endif %}
{% set lusano_dims_native = '' %}
{% if product.selected_or_first_available_variant is defined and product.selected_or_first_available_variant %}
  {% set pv = product.selected_or_first_available_variant %}
  {% set dim_parts = [] %}
  {% for key in ['width', 'height', 'depth'] %}
    {% if attribute(pv, key) is defined and attribute(pv, key) is not same as(false) and attribute(pv, key) is not null %}
      {% set dv = attribute(pv, key) %}
      {% set dvs = (dv ~ '') | trim %}
      {% if dvs != '' and dvs != '0' %}
        {% set dim_parts = dim_parts | merge([dvs]) %}
      {% endif %}
    {% endif %}
  {% endfor %}
  {% if dim_parts | length > 0 %}
    {% set lusano_dims_native = dim_parts | join(' × ') ~ ' cm' %}
  {% endif %}
{% endif %}
{# Si la variante no trae medidas, intentar a nivel producto (algunas tiendas) #}
{% if lusano_dims_native == '' %}
  {% set dim_parts_p = [] %}
  {% for key in ['width', 'height', 'depth'] %}
    {% if attribute(product, key) is defined and attribute(product, key) is not same as(false) and attribute(product, key) is not null %}
      {% set dv = attribute(product, key) %}
      {% set dvs = (dv ~ '') | trim %}
      {% if dvs != '' and dvs != '0' %}
        {% set dim_parts_p = dim_parts_p | merge([dvs]) %}
      {% endif %}
    {% endif %}
  {% endfor %}
  {% if dim_parts_p | length > 0 %}
    {% set lusano_dims_native = dim_parts_p | join(' × ') ~ ' cm' %}
  {% endif %}
{% endif %}
{% set lusano_dimensiones_final = lusano_dims_native != '' ? lusano_dims_native : lusano_dimensiones %}
{# Nombres de variación de color (idiomas / panel TN) #}
{% set lusano_color_names = ['Color', 'Cor', 'Colores', 'Colour', 'Colours', 'Couleur', 'Couleurs', 'COLOR', 'COR'] %}

<div id="single-product"
     class="js-has-new-shipping js-product-detail js-product-container js-shipping-calculator-container lusano-wrap"
     data-variants="{{ product.variants_object | json_encode }}"
     data-store="product-detail">

  <div class="lusano">

    {# ══════════════════════════════════════
       Columna izquierda — notas editoriales
    ══════════════════════════════════════ #}
    <aside class="lusano__col lusano__col--left">
      <button type="button" class="lusano__close js-lusano-back" data-lusano-back-href="{{ store.products_url }}">{{ 'Volver' | translate }}</button>

      <div class="lusano__notes">
        {% if product.description is not empty %}
        <div class="lusano__note">
          <span class="lusano__note-ix">i.</span>
          <p class="lusano__note-body">{{ product.description | striptags | slice(0, 400) }}{% if product.description | striptags | length > 400 %}…{% endif %}</p>
        </div>
        {% endif %}
        {% if product.variations is defined and product.variations is not empty %}
          <div class="lusano__note">
            <span class="lusano__note-ix">ii.</span>
            <p class="lusano__note-body lusano__note-body--em js-lusano-variant-label">—</p>
          </div>
        {% endif %}
      </div>
    </aside>

    {# ══════════════════════════════════════
       Columna central — galería con scroll
    ══════════════════════════════════════ #}
    <main class="lusano__col lusano__col--center js-lusano-gallery" data-store="product-image-{{ product.id }}">
      {% for image in product.images %}
      <img
        data-index="{{ loop.index }}"
        data-image="{{ image.id }}"
        {% if loop.first %}
          src="{{ image | product_image_url('original') }}"
          fetchpriority="high"
        {% else %}
          src="data:image/gif;base64,R0lGODlhAQABAAAAACH5BAEKAAEALAAAAAABAAEAAAICTAEAOw=="
          data-src="{{ image | product_image_url('original') }}"
          data-sizes="auto"
        {% endif %}
        {% if not loop.first %}data-{% endif %}srcset="{{ image | product_image_url('large') }} 480w, {{ image | product_image_url('huge') }} 640w, {{ image | product_image_url('original') }} 1024w"
        class="lusano__gallery-img js-lusano-gallery-img {% if not loop.first %}lazyautosizes lazyload{% endif %}"
        data-full="{{ image | product_image_url('original') }}"
        alt="{{ image.alt | default(product.name) }}"
        {% if image.dimensions.width and image.dimensions.height %}width="{{ image.dimensions.width }}" height="{{ image.dimensions.height }}"{% endif %} />
      {% endfor %}
    </main>

    {# ══════════════════════════════════════
       Columna derecha — info + compra
    ══════════════════════════════════════ #}
    <aside class="lusano__col lusano__col--right" data-store="product-info-{{ product.id }}">

      {# Contador de imagen sincronizado con scroll #}
      <div class="lusano__counter">
        <span class="lusano__counter-num js-lusano-counter">001</span>
        <div class="lusano__counter-meta">
          <span class="js-lusano-counter-total"></span>
          <span class="lusano__counter-hint">(Scroll)</span>
        </div>
      </div>

      {# Título del producto #}
      <h1 class="lusano__title" data-store="product-name-{{ product.id }}">{{ product.name }}</h1>

      {# Tabla de specs / variantes expandibles #}
      <div class="lusano__specs">

        {% for variation in product.variations %}
        {% set lusano_opts_count = variation.options | length %}
        {% set lusano_row_open = lusano_opts_count > 1 %}
        <div class="lusano__row js-lusano-row" data-variation-id="{{ variation.id }}">
          <div class="lusano__row-head">
            <span class="lusano__row-label">{{ variation.name }}</span>
            <span class="lusano__row-value">
              <span class="js-lusano-row-selected">{% for option in variation.options %}{% if product.default_options[variation.id] is same as(option.id) %}{{ option.name }}{% endif %}{% endfor %}</span>
              {% if lusano_opts_count > 1 %}
              <button type="button" class="lusano__row-toggle js-lusano-row-toggle" aria-label="{{ 'Expandir opciones' | translate }}" data-initial-open="{{ lusano_row_open ? '1' : '0' }}">{% if lusano_row_open %}×{% else %}+{% endif %}</button>
              {% endif %}
            </span>
          </div>
          {% if lusano_opts_count > 1 %}
          <div class="lusano__row-opts js-lusano-row-opts{% if lusano_row_open %} open{% endif %}">
            {% for option in variation.options %}
            <button type="button"
                    class="lusano__opt js-lusano-opt {% if product.default_options[variation.id] is same as(option.id) %}active{% endif %}"
                    data-option-id="{{ option.id }}"
                    data-variation-id="{{ variation.id }}"
                    data-label="{{ option.name }}">
              {# Muestra chip de color si TN guardó valor en custom_data (hex u otro) #}
              {% if option.custom_data %}
                <span class="lusano__opt-swatch" style="background:{{ option.custom_data | escape('html_attr') }}"></span>
              {% elseif variation.name in lusano_color_names %}
                <span class="lusano__opt-swatch lusano__opt-swatch--neutral" aria-hidden="true"></span>
              {% endif %}
              {{ option.name }}
            </button>
            {% endfor %}
          </div>
          {% endif %}
        </div>
        {% endfor %}

        {# Dimensiones: admin Peso y dimensiones (cm) o metacampo #}
        {% if lusano_dimensiones_final %}
        <div class="lusano__row">
          <div class="lusano__row-head">
            <span class="lusano__row-label">{{ "Dimensiones" | translate }}</span>
            <span class="lusano__row-value js-lusano-dimensions-value">{{ lusano_dimensiones_final }}</span>
          </div>
        </div>
        {% endif %}

        {# Precio #}
        <div class="lusano__row lusano__row--price" data-store="product-price-{{ product.id }}">
          <div class="lusano__row-head">
            <span class="lusano__row-label">{{ "Precio" | translate }}</span>
            <span class="lusano__row-value lusano__row-value--price">
              <span class="js-compare-price-display lusano__price-old" id="compare_price_display"
                    {% if not product.compare_at_price or not product.display_price %}style="display:none;"{% endif %}>
                {% if product.compare_at_price and product.display_price %}{{ product.compare_at_price | money }}{% endif %}
              </span>
              <span class="js-price-display" id="price_display"
                    {% if not product.display_price %}style="display:none;"{% endif %}
                    data-product-price="{{ product.price }}">
                {% if product.display_price %}{{ product.price | money }}{% endif %}
              </span>
            </span>
          </div>
        </div>
      </div>

      {# ── Formulario de compra (integración TN nativa) ── #}
      <form id="product_form" class="js-product-form lusano__form" method="post" action="{{ store.cart_url }}" data-store="product-form-{{ product.id }}">
        <input type="hidden" name="add_to_cart" value="{{ product.id }}" />

        {# Selects ocultos que TN JS necesita para variantes #}
        {% if product.variations %}
          {% for variation in product.variations %}
          <select name="variation[{{ variation.id }}]"
                  class="js-variation-option js-refresh-installment-data js-lusano-hidden-select"
                  data-variation-id="{{ variation.id }}"
                  aria-hidden="true" tabindex="-1">
            {% for option in variation.options %}
            <option value="{{ option.id }}" {% if product.default_options[variation.id] is same as(option.id) %}selected{% endif %}>{{ option.name }}</option>
            {% endfor %}
          </select>
          {% endfor %}
        {% endif %}

        {# Cantidad #}
        {% if product.available and product.display_price %}
        <div class="lusano__qty" data-component="product.quantity">
          <span class="lusano__qty-label">{{ "Cantidad" | translate }}</span>
          <div class="lusano__qty-ctrl">
            <button type="button" class="lusano__qty-btn js-lusano-qty-down" data-component="product.quantity.minus" aria-label="{{ 'Quitar' | translate }}">−</button>
            <input type="number" name="quantity" value="1" min="1"
                   class="js-quantity-input lusano__qty-input"
                   aria-label="{{ 'Cantidad' | translate }}"
                   data-component="adding-amount.value" />
            <button type="button" class="lusano__qty-btn js-lusano-qty-up" data-component="product.quantity.plus" aria-label="{{ 'Agregar' | translate }}">+</button>
          </div>
        </div>
        {% endif %}

        {# Medios de pago #}
        {% set installments_info = product.installments_info_from_any_variant %}
        {% set show_payments_info = product.show_installments and product.display_price and installments_info %}
        {% if show_payments_info %}
        <div class="lusano__payments js-product-payments-container"
             {% if not (product.get_max_installments and product.get_max_installments(false)) %}style="display:none;"{% endif %}>
          {% set max_installments_without_interests = product.get_max_installments(false) %}
          {% if max_installments_without_interests and max_installments_without_interests.installment > 1 %}
            <span class="lusano__payments-text">
              {{ max_installments_without_interests.installment }} {{ "cuotas sin interés" | translate }}
            </span>
          {% endif %}
          <a href="#" id="btn-installments"
             data-toggle="#installments-modal"
             data-modal-url="modal-fullscreen-payments"
             class="js-modal-open js-fullscreen-modal-open lusano__payments-link"
             {% if not (product.get_max_installments and product.get_max_installments(false)) %}style="display:none;"{% endif %}>
            {{ "Ver medios de pago" | translate }}
          </a>
        </div>
        {% endif %}

        {# Botón de compra #}
        {% set state = store.is_catalog ? 'catalog' : (product.available ? (product.display_price ? 'cart' : 'contact') : 'nostock') %}
        {% set texts = {'cart': "Agregar al carrito", 'contact': "Consultar precio", 'nostock': "Sin stock", 'catalog': "Consultar"} %}

        <input type="submit"
               class="js-addtocart js-prod-submit-form lusano__cta {{ state }}"
               value="{{ texts[state] | translate }}"
               {% if state == 'nostock' %}disabled{% endif %}
               data-store="product-buy-button"
               data-component="product.add-to-cart" />

        {% include 'snipplets/placeholders/button-placeholder.tpl' with {custom_class: "lusano__cta-ph"} %}

        <div class="js-added-to-cart-product-message lusano__added-msg" style="display:none;">
          {{ 'Ya agregaste este producto.' | translate }}
          <a href="#" class="js-modal-open js-fullscreen-modal-open lusano__added-link"
             data-toggle="#modal-cart" data-modal-url="modal-fullscreen-cart">
            {{ 'Ver carrito' | translate }}
          </a>
        </div>
      </form>
    </aside>
  </div>

  {# Lightbox fullscreen #}
  <div class="lusano__lightbox js-lusano-lightbox" aria-hidden="true">
    <button type="button" class="lusano__lightbox-close js-lusano-lightbox-close">{{ 'Cerrar' | translate }}</button>
    <img class="lusano__lightbox-img js-lusano-lightbox-img" src="" alt="" />
  </div>
</div>

{# Modal de medios de pago (componente TN reutilizado) #}
{% include 'snipplets/product/product-payment-details.tpl' %}