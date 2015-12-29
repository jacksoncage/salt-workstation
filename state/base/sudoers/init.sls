{% from "base/sudoers/package-map.jinja" import pkgs with context %}
{%- set name             = 'base/sudoers' %}
{%- set ns               = '/' + name %}
{%- set id               = grains['id'] %}

{{ ns }}/installed:
  pkg.latest:
    - name: {{ pkgs.sudo }}

{{ ns }}/group:
    group.present:
        - name: sudo

{{ ns }}/config:
  file.managed:
    - name: /etc/sudoers
    - user: root
    - group: root
    - mode: 440
    - template: jinja
    - source: salt://base/sudoers/files/sudoers
    - context:
        included: False
    - require:
      - pkg: {{ ns }}/installed
