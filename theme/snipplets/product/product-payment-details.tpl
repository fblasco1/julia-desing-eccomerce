{# Product payments details #}

{% if product.installments_info_from_any_variant %}

    {% embed "snipplets/modal.tpl" with{
        modal_id: 'installments-modal',
        modal_class: 'julia-payments',
        modal_position: 'bottom',
        modal_transition: 'slide',
        modal_header: true,
        modal_header_class: 'julia-modal-head',
        modal_footer: true,
        modal_footer_class: 'julia-modal-foot',
        modal_width: 'centered',
        modal_mobile_full_screen: 'true'} %}
        {% block modal_head %}
            {{ 'Medios de pago' | translate }}
        {% endblock %}
        {% block modal_body %}

            {# Modal header and gateways tab links #}

            {{ component('payments/payments-details',
                {
                    text_classes: {
                        text_accent: "julia-payments-accent label label-accent ml-1",
                        subtitles: "julia-payments-subtitle h6 mb-3",
                        text_big: "julia-payments-lead font-big",
                        text_small: "julia-payments-small font-small",
                        align_right: "text-right",
                        opacity: "julia-payments-muted opacity-60"
                    },
                    spacing_classes: {
                        top_1x: "mt-1",
                        top_2x: "mt-2",
                        top_3x: "mt-3",
                        right_1x: "mr-1",
                        right_2x: "mr-2",
                        right_3x: "mr-3",
                        bottom_1x: "mb-1",
                        bottom_2x: "mb-2",
                        bottom_3x: "mb-3",
                        left_3x: "ml-3",
                    },
                    container_classes : {
                        payment_method: "julia-payments-method card p-3"
                    },
                    discounts_conditional_visibility: true
                })
            }}
        {% endblock %}
        {% block modal_foot %}
            <div class="text-right julia-payments-foot-actions">
                <button type="button" class="js-modal-close js-fullscreen-modal-close julia-payments-back">{{ 'Volver al producto' | translate }}</button>
            </div>
        {% endblock %}
    {% endembed %}

{% endif %}
