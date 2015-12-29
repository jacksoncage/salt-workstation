{%- set name             = 'wifi' %}
{%- set ns               = '/base/' + name %}

{# Install packges #}
{{ ns }}/installed:
  pkg.latest:
    - pkgs:
      - iw
      - firmware-iwlwifi

{# make sure kernel module for wifi is loaded and persist #}
{%- if not grains['testing'] %}
{{ ns }}/:
  cmd.run:
    - name: |
        modprobe -r iwlwifi
        modprobe iwlwifi
    - user: root
    - require:
      - pkg: {{ ns }}/installed
{%- endif %}
