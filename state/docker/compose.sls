{%- set kernel = salt['grains.get']('kernel') %}
{%- set cpuarch = salt['grains.get']('cpuarch') %}

compose:
  file.managed:
    - name: /usr/local/bin/docker-compose
    - source:
      - https://github.com/docker/compose/releases/download/1.10.0/docker-compose-{{ kernel }}-{{ cpuarch }}
    - source_hash: md5=a0a5ad80dff7fac6b2ce6e85265542e8
    - makedirs: True
    - mode: 0775
