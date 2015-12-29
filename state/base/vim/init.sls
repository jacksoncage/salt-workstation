{%- set name             = 'base/vim' %}
{%- set ns               = '/' + name %}
{%- set id               = grains['id'] %}

{{ ns }}/installed:
  pkg.latest:
    - name: vim

{{ ns }}/default:
  cmd.run:
    - name: "update-alternatives --set editor /usr/bin/vim"
