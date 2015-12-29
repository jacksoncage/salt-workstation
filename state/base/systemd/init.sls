{%- set name             = 'systemd' %}
{%- set ns               = '/base/' + name %}
{%- set username         = salt['pillar.get']('username', 'love') %}

{# create all systemd managed files #}
{{ ns }}/add:
  file.recurse:
    - name: /etc/systemd
    - source: salt://base/systemd/files
    - user: root
    - group: root
    - file_mode: 644
    - dir_mode: 644
    - makedirs: True

{%- if grains['osfinger'] == 'Debian-8' %}
{# enable dbus for the user session #}
{{ ns }}/dbus:
  cmd.run:
    - name: systemctl --user enable dbus.socket
    - user: root

{# suspend on closing the lid #}
{{ ns }}/suspend:
  cmd.run:
    - name: systemctl enable suspend-sedation.service
    - user: root
{%- endif %}
