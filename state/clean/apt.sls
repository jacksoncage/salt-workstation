{%- set name             = 'apt' %}
{%- set ns               = '/clean/' + name %}
{%- set id               = grains['id'] %}

{{ ns }}/autoclean:
  cmd.run:
    - name: |
        apt-get -qqy autoremove
        apt-get -qqy autoclean
        apt-get -qqy clean
