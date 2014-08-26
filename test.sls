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
  pip.install:
  - name: pip


rally_install:
  cmd.run:
  - name: cd /srv/rally; ./install_rally.sh
  - require:
    - git: rally_app
    - pip: pip_update 

{%- endif %}