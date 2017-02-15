{%- set name             = 'packges' %}
{%- set ns               = '/base/' + name %}

{%- if grains['testingtravis'] is defined %}{% else %}
{# Setup apt source #}
{{ ns }}/source/absent:
  file.absent:
    - name: /etc/apt/sources.list

{{ ns }}/source/add:
  file.recurse:
    - name: /etc/apt/
    - source: salt://base/apt/etc/
    - makedirs: True
    - template: jinja

{# turn off translations, speed up apt-get update #}
{{ ns }}/source/apt.conf.d:
  file.managed:
    - name: /etc/apt/apt.conf.d/99translations
    - contents: Acquire::Languages "none";
    - makedirs: True
    - template: jinja
{%- endif %}

