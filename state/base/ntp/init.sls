{%- set name             = 'base/ntp' %}
{%- set ns               = '/' + name %}
{%- set id               = grains['id'] %}

{{ ns }}/installed:
  pkg.latest:
    - name: ntp

{{ ns }}/config:
  file.managed:
    - name: /etc/ntp.conf
    - source: salt://base/ntp/ntp.conf
    - template: jinja

{{ ns }}/running:
  service.running:
    - name: ntp
    - enable: True
    - watch:
      - file: {{ ns }}/config
      - pkg: {{ ns }}/installed
