{# Valor usable en |static_url para settings tipo image (string, objeto url/path/src, o URL absoluta).
   Sin "is string" (compatibilidad Twig antiguo): si no hay claves de objeto, se trata como cadena. #}
{% macro setting_image_value(raw) -%}
	{%- if raw is null or raw is same as(false) -%}
	{%- elseif raw is same as('') -%}
	{%- elseif raw.url is defined and raw.url -%}
		{{- raw.url -}}
	{%- elseif raw.path is defined and raw.path -%}
		{{- raw.path -}}
	{%- elseif raw.src is defined and raw.src -%}
		{{- raw.src -}}
	{%- elseif raw.relative_url is defined and raw.relative_url -%}
		{{- raw.relative_url -}}
	{%- elseif raw.name is defined and raw.name -%}
		{{- raw.name -}}
	{%- elseif raw.filename is defined and raw.filename -%}
		{{- raw.filename -}}
	{%- elseif raw.url is not defined and raw.path is not defined and raw.src is not defined and raw.relative_url is not defined and raw.name is not defined and raw.filename is not defined -%}
		{{- raw | trim -}}
	{%- endif -%}
{%- endmacro %}
