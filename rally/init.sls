
{%- if pillar.rally is defined %}
include:
{%- if pillar.rally.benchmark is defined %}
- rally.benchmark
{%- endif %}
{%- endif %}