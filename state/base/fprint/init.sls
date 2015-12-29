{%- set name             = 'base/fprint' %}
{%- set ns               = '/' + name %}
{%- set id               = grains['id'] %}

{{ ns }}/installed:
  pkg.latest:
    - pkgs:
      - libpam-fprintd
      - libfprint0
      - fprint-demo
