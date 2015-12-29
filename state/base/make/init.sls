{%- set name          = 'base/make' %}
{%- set ns            = '/' + name %}
{%- set kernelrelease = salt['grains.get']('kernelrelease')%}

{{ ns }}/install:
  pkg.latest:
    - pkgs:
      - make
      - gcc
      - build-essential
      {%- if not grains['testing'] %}
      - linux-headers-{{ kernelrelease }}
      {%- endif %}
