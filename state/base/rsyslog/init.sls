{%- set name             = 'base/rsyslog' %}
{%- set ns               = '/' + name %}
{%- set id               = grains['id'] %}

{{ ns }}/installed:
  pkg.latest:
    - name: rsyslog

{{ ns }}/config:
  file.managed:
    - name: /etc/rsyslog.conf
    - source: salt://base/rsyslog/rsyslog.conf
    - template: jinja

{{ ns }}/logrotate/config:
  file.managed:
    - name: /etc/logrotate.d/rsyslog
    - source: salt://base/rsyslog/logrotate.rsyslog
    - template: jinja

{{ ns }}/running:
  service.running:
    - name: rsyslog
    - enable: True
    - watch:
      - file: {{ ns }}/config
      - pkg: {{ ns }}/installed
