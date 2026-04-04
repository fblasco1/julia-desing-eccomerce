{# Placeholder admin: Hero Julia sin imagen ni textos #}
<section class="julia-home-hero hero julia-home-hero--help position-relative" id="julia-home-hero" data-store="home-julia-hero">
	<div class="julia-home-hero__left hero-left">
		<div class="julia-home-hero__strip" aria-hidden="true"></div>
		<div class="hero-img">
			<div class="hero-img-ph julia-home-hero__ph">
				<span>{{ 'Imagen del hero' | translate }}</span>
			</div>
		</div>
	</div>
	<div class="hero-copy julia-home-hero__copy">
		<div class="hero-copy-inner">
			<h1 class="hero-tagline">{{ 'Título del hero' | translate }}</h1>
			<p class="hero-sub">{{ 'Subtítulo' | translate }}</p>
			<div class="hero-cta">
				<span class="btn-primary julia-home-hero__cta">{{ 'Ver catálogo' | translate }}</span>
				<span class="hero-cta-secondary julia-home-hero__cta-secondary">{{ 'Saber más' | translate }}</span>
			</div>
		</div>
	</div>
	{% if params is not defined or not params.preview %}
		<div class="placeholder-overlay transition-soft" style="position:absolute;inset:0;z-index:5;">
			<div class="placeholder-info">
				{% include "snipplets/svg/edit.tpl" with {svg_custom_class: "icon-inline icon-3x"} %}
				<div class="placeholder-description font-small-xs">
					{{ "Configurá el hero desde" | translate }} <strong>{{ "Hero principal (Julia)" | translate }}</strong> {{ "y el orden en" | translate }} <strong>{{ "Página de inicio" | translate }}</strong>.
				</div>
				<a href="{{ admin_link }}#instatheme=pagina-de-inicio" class="btn-primary btn btn-small">{{ "Editar" | translate }}</a>
			</div>
		</div>
	{% endif %}
</section>
