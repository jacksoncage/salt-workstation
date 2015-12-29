{%- set name          = 'base/make' %}
{%- set ns            = '/' + name %}
{%- set kernelrelease = salt['grains.get']('kernelrelease')%}

{{ ns }}/install:
  pkg.latest:
    - pkgs:
      - make
      - gcc
      - build-essential
      {%- if grains['prd'] is defined %}
      - linux-headers-{{ kernelrelease }}
      {%- endif %}
