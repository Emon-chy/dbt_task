{% macro extract_year_month(column_name) %}
    EXTRACT(YEAR FROM {{ column_name }}) AS {{ column_name }}_year,
    EXTRACT(MONTH FROM {{ column_name }}) AS {{ column_name }}_month
{% endmacro %}