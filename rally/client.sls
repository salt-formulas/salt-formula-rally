{%- from "rally/map.jinja" import client with context %}
{%- if client.enabled %}

include:
- git

rally_client_packages:
  pkg.installed:
  - names: {{ client.get("pkgs", []) }}

rally_client_home:
  file.directory:
  - name: /srv/rally

{%- if client.source.engine == 'git' %}

{{ client.source.address }}:
  git.latest:
  - target: /srv/rally/scenarios
  - rev: {{ client.source.revision }}
  - require:
    - pkg: git_packages
    - file: /srv/rally

{%- endif %}

{%- endif %}