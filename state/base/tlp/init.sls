{%- set name             = 'base/tpl' %}
{%- set ns               = '/' + name %}
{%- set id               = grains['id'] %}

{{ ns }}/package:
  pkgrepo.managed:
    - humanname: Advanced Linux Power Management
    - name: deb http://repo.linrunner.de/debian jessie main
    - dist: jessie
    - file: /etc/apt/sources.list.d/tlp.list
    - keyid: CD4E8809
    - keyserver: pool.sks-keyservers.net

{{ ns }}/installed:
  pkg.latest:
    - pkgs:
      - tlp
      - tlp-rdw
