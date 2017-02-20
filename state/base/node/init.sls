{%- set name             = 'base/node' %}
{%- set ns               = '/' + name %}
{%- set id               = grains['id'] %}

{{ ns }}/nodejs-ppa:
  pkgrepo.managed:
    - name: deb https://deb.nodesource.com/node_7.x trusty main
    - file: /etc/apt/sources.list.d/nodesource.list
  cmd.run:
    - name: 'apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 1655A0AB68576280'
    - unless: 'apt-key list | grep 68576280'

{{ ns }}/nodejs:
  pkg.latest:
    - name: nodejs
    - refresh: true
    - skip_verify: True
    - require:
      - pkgrepo: {{ ns }}/nodejs-ppa

{{ ns }}/npm/diff-so-fancy:
  cmd.run:
    - name: npm install diff-so-fancy
    - runas: love
    - cwd: /home/love
    - unless: npm list|grep diff-so-fancy
