{%- set name             = 'base/dropbox' %}
{%- set ns               = '/' + name %}
{%- set id               = grains['id'] %}

{{ ns }}/requirements:
  pkg.installed:
    - pkgs:
      - libxslt1.1

{{ ns }}/install:
  pkg.installed:
    - sources:
      - dropbox: https://www.dropbox.com/download?dl=packages/debian/dropbox_2015.10.28_amd64.deb 

