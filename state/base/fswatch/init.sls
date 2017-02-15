{%- set name             = 'base/fswatch' %}
{%- set ns               = '/' + name %}
{%- set id               = grains['id'] %}

{{ ns }}/download:
  file.managed:
    - name: /usr/local/src/fswatch-1.9.3.tar.gz
    - source:
      - https://github.com/emcrisostomo/fswatch/releases/download/1.9.3/fswatch-1.9.3.tar.gz
    - source_hash: md5=37595ca5c584709864cac81a8ed1753b
    - makedirs: True
    - mode: 0550

{{ ns }}/compile:
  cmd.run:
    - name: |
        tar -xzf /usr/local/src/fswatch-1.9.3.tar.gz && \
        cd /usr/local/src/fswatch-1.9.3 && \
        ./configure && \
        make && \
        make install && \
        ldconfig
    - cwd: /usr/local/src/
    - shell: /bin/bash
    - timeout: 300
    - creates: /usr/local/lib/libfswatch.so.6.2.0
    - require:
      - file: {{ ns }}/download
