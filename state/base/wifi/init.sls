{%- set name             = 'wifi' %}
{%- set ns               = '/base/' + name %}

{%- if grains['testingtravis'] is defined %}{% else %}
{# Install packges #}
{{ ns }}/installed:
  pkg.latest:
    - pkgs:
      - iw
      - firmware-iwlwifi
      - wicd-cli
      - wicd-curses

{# make sure kernel module for wifi is loaded and persist #}
{%- if grains['prd'] is defined %}
{{ ns }}/:
  cmd.run:
    - name: |
        modprobe -r iwlwifi
        modprobe iwlwifi
    - user: root
    - require:
      - pkg: {{ ns }}/installed
{%- endif %}
{%- endif %}

{{ ns }}/networkmanager/disabled:
  service.disabled:
    - name: network-manager

{{ ns }}/wicd/running:
  service.running:
    - name: wicd
    - enable: True
    - reload: True

