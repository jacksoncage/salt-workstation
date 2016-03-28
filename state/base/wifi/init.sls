{%- set name             = 'wifi' %}
{%- set ns               = '/base/' + name %}

{%- if grains['testingtravis'] is defined %}{% else %}
{# Install packges #}
{{ ns }}/installed:
  pkg.latest:
    - pkgs:
      - iw
      - firmware-iwlwifi
      - network-manager
      - network-manager-openvpn
      - network-manager-vpnc
      - network-manager-gnome
      - network-manager-openvpn-gnome
      - network-manager-vpnc-gnome
      - network-manager-pptp
      - network-manager-pptp-gonome

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

{{ ns }}/wicd/disabled:
  pkg.removed:
    - pkgs: 
      - wicd-curses
      - wicd-cli

#{{ ns }}/wicd/running:
#  service.running:
#    - name: wicd
#    - enable: True
#    - reload: True
{% endif %}

