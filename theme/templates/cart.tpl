<section class="julia-cart-page">
{% embed "snipplets/page-header.tpl" with {'breadcrumbs': true} %}
    {% block page_header_text %}{{ "Carrito de Compras" | translate }}{% endblock page_header_text %}
{% endembed %}

<div id="shoppingCartPage" class="container julia-cart-page__inner" data-minimum="{{ settings.cart_minimum_value }}" data-store="cart-page">
    <form action="{{ store.cart_url }}" method="post" class="cart-body" data-store="cart-form" data-component="cart">
        <div class="cart-body">

            {# Cart alerts #}

            {% if error.add %}
                {{ component('alert', {'type': 'warning', 'message': 'our_components.cart.error_messages.' ~ error.add }) }}
            {% endif %}
            {% for error in error.update %}
                <div class="alert alert-warning">{{ "No podemos ofrecerte {1} unidades de {2}. Solamente tenemos {3} unidades." | translate(error.requested, error.item.name, error.stock) }}</div>
            {% endfor %}
            {% if cart.items %}
                <div class="js-ajax-cart-list cart-row">

                    {# Cart page items #}

                    {% if cart.items %}
                      {% for item in cart.items %}
                        {% include "snipplets/cart-item-ajax.tpl" with {'cart_page': true} %}
                      {% endfor %}
                    {% endif %}
                </div>
            {% else %}

                {#  Empty cart  #}

                {% if not error %}
                    {{ component('alert', {'type': 'info', 'message': ('El carrito de compras está vacío.' | translate) }) }}
                {% endif %}
            {% endif %}
            <div id="error-ajax-stock" style="display: none;">
                <div class="alert alert-warning">
                    {{ "¡Uy! No tenemos más stock de este producto para agregarlo al carrito. Si querés podés" | translate }}<a href="{{ store.products_url }}" class="btn-link ml-1">{{ "ver otros acá" | translate }}</a>
                </div>
            </div>
            <div class="cart-row">
                {% include "snipplets/cart-totals.tpl" with {'cart_page': true} %}
            </div>
        </div>
    </form>
    <div id="store-curr" class="hidden">{{ cart.currency }}</div>
</div>

{# Julia Design: /carrito no debe existir como página. Abrimos la sidebar del carrito y ocultamos el layout de página. #}
{% if settings.ajax_cart %}
<style>
  #shoppingCartPage { display: none !important; }
  .page-header { display: none !important; }
</style>
<script>
  (function () {
    function openCartSidebar() {
      var modal = document.getElementById("modal-cart");
      var overlay = document.querySelector('.js-modal-overlay[data-modal-id="#modal-cart"], .js-fullscreen-overlay[data-modal-id="#modal-cart"]');
      if (!modal) return false;
      modal.style.display = "block";
      modal.classList.add("modal-show");
      if (overlay) overlay.style.display = "block";
      document.documentElement.classList.add("modal-open");
      document.body.classList.add("modal-open");
      return true;
    }

    // Intento 1: abrir inmediatamente
    if (openCartSidebar()) return;

    // Intento 2: esperar a que cargue el DOM y el header inyecte el modal
    document.addEventListener("DOMContentLoaded", function () {
      if (openCartSidebar()) return;
      setTimeout(openCartSidebar, 300);
      setTimeout(openCartSidebar, 900);
    });
  })();
</script>
{% endif %}
</section>

