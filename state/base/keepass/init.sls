{%- set name             = 'base/keepass' %}
{%- set ns               = '/' + name %}
{%- set id               = grains['id'] %}

{{ ns }}/install:
  pkg.installed:
    - pkgs:
      - perl
      - perl-tk
      - mono-complete
      - keepass2

{{ ns }}/keepasshttp/download:
  file.managed:
    - name: /usr/lib/keepass2/KeePassHttp.plgx
    - source: https://raw.github.com/pfn/keepasshttp/master/KeePassHttp.plgx
    - source_hash: md5=4cf47b051cfa5a95fca0a06b56a7879b
    - user: root
    - mode: 0644
    - makedirs: True

{{ ns }}/kpcli/download:
  file.managed:
    - name: /usr/local/bin/kpcli
    - source: http://netix.dl.sourceforge.net/project/kpcli/kpcli-3.0.pl
    - source_hash: md5=b03cac8d6a7345ea45eaa52ccca18ed1
    - user: love
    - mode: 0755
    - makedirs: True
