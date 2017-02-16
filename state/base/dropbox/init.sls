{%- set name             = 'base/dropbox' %}
{%- set ns               = '/' + name %}
{%- set id               = grains['id'] %}

{{ ns }}/download:
  cmd.run:
    - name: 'wget -O /tmp/dropbox_2015.10.28_amd64.deb https://www.dropbox.com/download?dl=packages/debian/dropbox_2015.10.28_amd64.deb'

{{ ns }}/requirements:
  pkg.installed:
    - pkgs:
      - libxslt1.1

{{ ns }}/install:
  pkg.installed:
    - sources:
      - dropbox: /tmp/dropbox_2015.10.28_amd64.deb
    - require:
      - cmd: {{ ns }}/download
