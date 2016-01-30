{%- set name             = 'base/keepass' %}
{%- set ns               = '/' + name %}
{%- set id               = grains['id'] %}

{{ ns }}/requirements:
  pkg.installed:
    - pkgs:
      - perl
      - perl-tk

{{ ns }}/kpcli/download:
  file.managed:
    - name: /usr/local/bin/kpcli
    - source: http://netix.dl.sourceforge.net/project/kpcli/kpcli-3.0.pl
    - source_hash: md5=b03cac8d6a7345ea45eaa52ccca18ed1
    - user: love
    - mode: 0755
    - makedirs: True

