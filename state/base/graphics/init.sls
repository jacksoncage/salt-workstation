{%- set name             = 'graphics' %}
{%- set ns               = '/base/' + name %}

{# Install packges #}
{{ ns }}/installed:
  pkg.latest:
    - install_recommends: False
    - pkgs:
      - xorg
      - xserver-xorg
      - xserver-xorg-video-intel
