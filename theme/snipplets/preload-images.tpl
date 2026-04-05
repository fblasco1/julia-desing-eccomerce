{% if template == 'home' %}

	{# Preload home LCP image of slider section #}

	{% set has_main_slider = settings.slider and settings.slider is not empty %}
	{% set has_mobile_slider = settings.toggle_slider_mobile and settings.slider_mobile and settings.slider_mobile is not empty %}

	{% if has_mobile_slider %}
		{% set slider = settings.slider_mobile %}
	{% else %}
		{% set slider = settings.slider %}
	{% endif %}

	{% if settings.home_order_position_0 == 'julia_hero' and ('julia_hero.jpg' | has_custom_image) %}
		{% set hero_src = 'julia_hero.jpg' | static_url %}
		<link rel="preload" as="image" href="{{ hero_src | settings_image_url('large') }}" imagesrcset="{{ hero_src | settings_image_url('large') }} 480w, {{ hero_src | settings_image_url('xlarge') }} 1400w, {{ hero_src | settings_image_url('1080p') }} 1920w">
	{% endif %}

	{% if settings.home_order_position_0 == 'slider' and (has_main_slider or has_mobile_slider) %}
		{% for slide in slider %}
			{% if loop.first %}
				<link rel="preload" as="image" href="{{ slide.image | static_url | settings_image_url('large') }}" imagesrcset="{{ slide.image | static_url | settings_image_url('large') }} 480w, {{ slide.image | static_url | settings_image_url('xlarge') }} 1400w, {{ slide.image | static_url | settings_image_url('1080p') }} 1920w">
			{% endif %}
		{% endfor %}
	{% endif %}

    {% if settings.home_order_position_0 == 'categories' %}

        {% set priority_assigned = false %}

        {% for banner in ['banner_01', 'banner_02', 'banner_03'] %}
            {% set banner_show = attribute(settings,"#{banner}_show") %}
            {% set banner_image = "#{banner}.jpg" | has_custom_image %}
            {% set banner_image_src = "#{banner}.jpg" | static_url %}

            {% if banner_show and banner_image and not priority_assigned %}
                {% set priority_assigned = true %}
                <link rel="preload" as="image" href="{{ banner_image_src | settings_image_url('large') }}" imagesrcset="{{ banner_image_src | settings_image_url('large') }} 480w, {{ banner_image_src | settings_image_url('huge') }} 640w">
            {% endif %}
        {% endfor %}

    {% endif %}

    {% if settings.home_order_position_0 == 'modules' %}
    
        {% set priority_assigned = false %}

        {% for module in ['module_01', 'module_02'] %}
            {% set module_show = attribute(settings,"#{module}_show") %}
            {% set module_image = "#{module}.jpg" | has_custom_image %}
            {% set module_image_src = "#{module}.jpg" | static_url %}

            {% if module_show and module_image and not priority_assigned %}
                {% set priority_assigned = true %}
                <link rel="preload" as="image" href="{{ module_image_src | settings_image_url('large') }}" imagesrcset="{{ module_image_src | settings_image_url('large') }} 480w, {{ module_image_src | settings_image_url('huge') }} 640w">
            {% endif %}
        {% endfor %}
        
    {% endif %}
{% elseif template == 'product' %}

    {# Preload product LCP image #}

    {% for image in product.images %}
        {% if loop.first %}
            <link rel="preload" as="image" href="{{ image | product_image_url('large') }}" imagesrcset="{{ image | product_image_url('large') }} 480w, {{ image | product_image_url('huge') }} 640w, {{ image | product_image_url('original') }} 1024w">
        {% endif %}
    {% endfor %}
{% elseif template == 'page' and page is defined and page.handle is defined %}

    {% if page.handle == 'quienes-somos' and ('julia_inst_quienes_hero.jpg' | has_custom_image) %}
        {% set inst_q_src = 'julia_inst_quienes_hero.jpg' | static_url %}
        <link rel="preload" as="image" href="{{ inst_q_src | settings_image_url('large') }}" imagesrcset="{{ inst_q_src | settings_image_url('large') }} 480w, {{ inst_q_src | settings_image_url('xlarge') }} 1400w, {{ inst_q_src | settings_image_url('1080p') }} 1920w">
    {% elseif page.handle == 'como-trabajamos' and ('julia_inst_como_hero.jpg' | has_custom_image) %}
        {% set inst_c_src = 'julia_inst_como_hero.jpg' | static_url %}
        <link rel="preload" as="image" href="{{ inst_c_src | settings_image_url('large') }}" imagesrcset="{{ inst_c_src | settings_image_url('large') }} 480w, {{ inst_c_src | settings_image_url('xlarge') }} 1400w, {{ inst_c_src | settings_image_url('1080p') }} 1920w">
    {% endif %}

{% elseif template == 'category' %}

    {# Preload category LCP image #}

    {% set category_banner = (category.images is not empty) or ("banner-products.jpg" | has_custom_image) %}
    
    {% if category_banner %}
        {# Sin merge({(size): ...}) ni [] para compatibilidad Twig TN (evita 500 al compilar). #}
        {% set has_category_images = category.images is not empty %}
        {% if has_category_images %}
            {% set cat0 = category.images | first %}
            {% set cat_url_large = cat0 | category_image_url('large') %}
            {% set cat_url_huge = cat0 | category_image_url('huge') %}
            {% set cat_url_orig = cat0 | category_image_url('original') %}
            {% set cat_url_1080 = cat0 | category_image_url('1080p') %}
        {% else %}
            {% set cat_url_large = 'banner-products.jpg' | static_url | settings_image_url('large') %}
            {% set cat_url_huge = 'banner-products.jpg' | static_url | settings_image_url('huge') %}
            {% set cat_url_orig = 'banner-products.jpg' | static_url | settings_image_url('original') %}
            {% set cat_url_1080 = 'banner-products.jpg' | static_url | settings_image_url('1080p') %}
        {% endif %}
        <link rel="preload" as="image" href="{{ cat_url_large }}" imagesrcset="{{ cat_url_large }} 480w, {{ cat_url_huge }} 640w, {{ cat_url_orig }} 1024w, {{ cat_url_1080 }} 1920w">
    {% endif %}

{% endif %}