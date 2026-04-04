{# Tarjeta del carrusel exhibidor (home). Pasar image_src con URL completa o una URL ya filtrada con product_image_url. #}
<div class="card">
  <div class="card-img">
    {% if image_src is defined and image_src %}
      <img src="{{ image_src }}" alt="{{ name }}" loading="lazy" width="300" height="375" />
    {% else %}
      <div class="card-img-ph">
        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1" aria-hidden="true"><rect x="3" y="3" width="18" height="18" rx="2"/><path d="M3 9h18M9 21V9"/></svg>
      </div>
    {% endif %}
  </div>
  <span class="card-name">{{ name }}</span>
  <span class="card-cat">{{ category }}</span>
  <span class="card-price">{{ price_label }}</span>
</div>
