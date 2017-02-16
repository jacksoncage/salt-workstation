{%- set name             = 'base/dropbox' %}
{%- set ns               = '/' + name %}
{%- set id               = grains['id'] %}

{{ ns }}/download:
  file.managed:
    - name: /tmp/dropbox_2015.10.28_amd64.deb
    - source: 'https://www.dropbox.com/download?dl=packages/debian/dropbox_2015.10.28_amd64.deb'
    - source_hash: md5=a6e6e2735662dd8cd0171cc67ea49f07
    - makedirs: True
    - mode: 0550

{{ ns }}/requirements:
  pkg.installed:
    - pkgs:
      - libxslt1.1

{{ ns }}/install:
  pkg.installed:
    - sources:
      - dropbox: /tmp/dropbox_2015.10.28_amd64.deb
    - require:
      - file: {{ ns }}/download
