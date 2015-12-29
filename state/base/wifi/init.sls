{%- set name             = 'wifi' %}
{%- set ns               = '/base/' + name %}

{# Install packges #}
{{ ns }}/installed:
  pkg.latest:
    - pkgs:
      - iw
      - firmware-iwlwifi

{# make sure kernel module for wifi is loaded and persist #}
{{ ns }}/:
  kmod.present:
    - name: iwlwifi
    - persist: True
    - require:
      - pkg: {{ ns }}/installed
