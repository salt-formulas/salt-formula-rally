
{%- if pillar.rally is defined %}
include:
{%- if pillar.rally.benchmark is defined %}
- rally.benchmark
{%- endif %}
{%- if pillar.rally.client is defined %}
- rally.client
{%- endif %}
{%- endif %}