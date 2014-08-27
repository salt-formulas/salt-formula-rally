{%- from "rally/map.jinja" import test with context %}
{%- if test.enabled %}

include:
- git

rally_packages:
  pkg.installed:
  - names: {{ test.pkgs }}

rally_dir:
  file.directory:
  - name: /srv/rally
  - require:
    - pkg: rally_packages

rally_app:
  git.latest:
  - name: {{ test.source.address }}
  - target: /srv/rally/
  - require:
    - file: rally_dir
    - pkg: git_packages

pip_update:
  pip.installed:
    - name: pip >= 1.5.4
    - require:
      - pkg: python-pip

rally_install:
  cmd.run:
  - name: cd /srv/rally; ./install_rally.sh
  - require:
    - git: rally_app
    - pip: pip_update
  - unless: "test -e /root/.rally/"

{%- for cloud_name, cloud in test.cloud.iteritems() %}

/srv/rally/{{ cloud_name }}.json:
  file.managed:
  - source: salt://rally/files/cloud.json
  - template: jinja
  - require:
    - cmd: rally_install
  - defaults:
      cloud_name: "{{ cloud_name }}"

register_{{ cloud_name }}:
  cmd.run:
  - name: rally deployment create --filename={{ cloud_name }}.json --name={{ cloud_name }}
  - cwd: /srv/rally
  - require:
    - file: /srv/rally/{{ cloud_name }}.json
  - unless: "cd /srv/rally; rally deployment list | grep {{ cloud_name }}"


{%- endfor %}

{%- endif %}