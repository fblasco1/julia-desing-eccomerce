{# Julia Design — Home únicamente con el diseño Spruce (sin secciones clásicas del Base Theme) #}
{% include 'snipplets/home/julia-home.tpl' %}

{# Popup promocional opcional (solo si lo activás en la personalización del tema) #}
{% if settings.home_promotional_popup and ("home_popup_image.jpg" | has_custom_image or settings.home_popup_title or settings.home_popup_txt or settings.home_news_box or (settings.home_popup_btn and settings.home_popup_url)) %}
    {% include 'snipplets/home/home-popup.tpl' %}
{% endif %}
