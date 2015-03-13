{%- from "rally/map.jinja" import benchmark with context %}
{%- if benchmark.enabled %}

include:
- git

rally_packages:
  pkg.installed:
  - names: {{ benchmark.pkgs }}

rally_conf_dir:
  file.directory:
  - name: /etc/rally

pip_update:
  pip.installed:
    - name: pip >= 1.5.4
    - require:
      - pkg: python-pip

/srv/rally:
  virtualenv.manage:
  - system_site_packages: False
  - requirements: salt://rally/files/requirements.txt
  - require:
    - pkg: rally_packages
    - pip: pip_update

rally_user:
  user.present:
  - name: rally
  - system: True
  - home: /srv/rally
  - require:
    - virtualenv: /srv/rally

rally_app:
  git.latest:
  - name: {{ benchmark.source.address }}
  - target: /srv/rally/rally
  - require:
    - virtualenv: /srv/rally
    - pkg: git_packages

/etc/rally/rally.conf:
  file.managed:
  - source: salt://rally/files/rally.conf
  - template: jinja
  - require:
    - file: rally_conf_dir


rally_install:
  cmd.run:
  - name: cd /srv/rally; ./install_rally.sh
  - require:
    - git: rally_app
    - pip: pip_update
  - unless: "test -e /root/.rally/"



{%- for provider_name, provider in benchmark.cloud.iteritems() %}

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