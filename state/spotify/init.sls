{%- set name             = 'spotify' %}
{%- set ns               = '/' + name %}
{%- set id               = grains['id'] %}

{{ ns }}/repo:
  pkgrepo.managed:
    - humanname: Spotify
    - name: deb http://repository.spotify.com stable non-free
    - file: /etc/apt/sources.list.d/spotify.list
    - keyid: BBEBDCB318AD50EC6865090613B00F1FD2C19886
    - server: hkp://keyserver.ubuntu.com:80

{{ ns }}/install:
  pkg.latest:
    - name: spotify-client
    - refresh: true
    - require:
      - pkgrepo: {{ ns }}/repo

