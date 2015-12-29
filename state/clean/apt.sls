{%- set name             = 'apt' %}
{%- set ns               = '/clean/' + name %}
{%- set id               = grains['id'] %}

{# TODO: Clean apt-get cache

apt-get autoremove
apt-get autoclean
apt-get clean

#}
{{ ns }}/autoclean:
  cmd.run:
    - name: |
        apt-get -qqy autoremove
        apt-get -qqy autoclean
        apt-get -qqy clean
