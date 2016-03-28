{%- set name             = 'slack' %}
{%- set ns               = '/' + name %}
{%- set id               = grains['id'] %}

{{ ns }}/repo:
  pkgrepo.managed:
    - humanname: Google Chrome
    - name: deb http://dl.google.com/linux/chrome/deb/ stable main
    - dist:
    - file:
    - keyid:
    - keyserver:



{{ ns }}/install:
  pkg.installed:
    - name:

