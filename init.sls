{%- if pillar.rally is defined %}
include:
{%- if pillar.rally.test is defined %}
- rally.test
{%- endif %}
{%- endif %}