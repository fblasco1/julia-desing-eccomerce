<section class="julia-home__benefits" aria-labelledby="julia-beneficios-heading">
    <div class="julia-home__benefits-sticky">
        <h2 id="julia-beneficios-heading" class="julia-home__benefits-title">
            {% if settings.julia_benefits_title_1 | default('') | trim != '' %}
                {{ settings.julia_benefits_title_1 }}
            {% else %}
                {{ 'Diseño puro.' | translate }}
            {% endif %}
            <br />
            {% if settings.julia_benefits_title_2 | default('') | trim != '' %}
                {{ settings.julia_benefits_title_2 }}
            {% else %}
                {{ 'Para toda la vida.' | translate }}
            {% endif %}
        </h2>
        <p class="mb-0 julia-home__benefits-lead">
            {% if settings.julia_benefits_lead | default('') | trim != '' %}
                {{ settings.julia_benefits_lead }}
            {% else %}
                {{ 'Muebles que se adaptan a tus espacios ahora, sin comprometer la calidad para el futuro.' | translate }}
            {% endif %}
        </p>
    </div>
    <div class="julia-home__benefits-list-wrap">
        <p class="julia-home__benefits-intro">
            {% if settings.julia_benefits_intro | default('') | trim != '' %}
                {{ settings.julia_benefits_intro }}
            {% else %}
                {{ 'Nos especializamos en la fabricación propia. Cuidamos cada detalle de soldadura y pintura para asegurar un acabado perfecto.' | translate }}
            {% endif %}
        </p>
        <div class="julia-home__benefits-list">
            <div class="julia-home__benefits-row">
                <h3>
                    {% if settings.julia_benefits_item_1 | default('') | trim != '' %}
                        {{ settings.julia_benefits_item_1 }}
                    {% else %}
                        {{ 'Fabricación Propia' | translate }}
                    {% endif %}
                </h3>
            </div>
            <div class="julia-home__benefits-row">
                <h3>
                    {% if settings.julia_benefits_item_2 | default('') | trim != '' %}
                        {{ settings.julia_benefits_item_2 }}
                    {% else %}
                        {{ 'Hierro y Chapa' | translate }}
                    {% endif %}
                </h3>
            </div>
            <div class="julia-home__benefits-row">
                <h3>
                    {% if settings.julia_benefits_item_3 | default('') | trim != '' %}
                        {{ settings.julia_benefits_item_3 }}
                    {% else %}
                        {{ 'Atención Mayorista' | translate }}
                    {% endif %}
                </h3>
            </div>
            <div class="julia-home__benefits-row">
                <h3>
                    {% if settings.julia_benefits_item_4 | default('') | trim != '' %}
                        {{ settings.julia_benefits_item_4 }}
                    {% else %}
                        {{ 'Envíos a todo el país' | translate }}
                    {% endif %}
                </h3>
            </div>
            <div class="julia-home__benefits-row">
                <h3>
                    {% if settings.julia_benefits_item_5 | default('') | trim != '' %}
                        {{ settings.julia_benefits_item_5 }}
                    {% else %}
                        {{ 'Hasta 6 cuotas sin interés' | translate }}
                    {% endif %}
                </h3>
            </div>
        </div>
    </div>
</section>
