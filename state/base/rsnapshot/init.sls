{%- set name             = 'base/rsnapshot' %}
{%- set ns               = '/' + name %}
{%- set id               = grains['id'] %}

{{ ns }}installed:
  pkg.latest:
    - name: rsnapshot

{{ ns }}validate/rsync:
  file.managed:
    - name: /home/rsnapshot/validate_rsync.sh
    - source: salt://base/rsnapshot/files/validate_rsync.sh
    - template: jinja
    - user: rsnapshot
    - group: rsnapshot
    - mode: 775

{{ ns }}rsync/wrapper:
  file.managed:
    - name: /usr/local/bin/rsync_wrapper.sh
    - source: salt://base/rsnapshot/files/rsync_wrapper.sh
    - template: jinja
    - user: root
    - group: root
    - mode: 775
