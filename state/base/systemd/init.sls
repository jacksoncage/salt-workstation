{%- set name             = 'systemd' %}
{%- set ns               = '/base/' + name %}
{%- set username         = salt[]%}

{# create all systemd managed files #}
{{ ns }}/add:
  file.recurse:
    - name: /etc/systemd
    - source: salt://base/systemd/files
    - user: {{ username }}
    - group: {{ username }}
    - file_mode: 644
    - dir_mode: 644
    - makedir: True

{# enable dbus for the user session #}
{{ ns }}/dbus:
  cmd.run:
    - name: systemctl --user enable dbus.socket
    - user: {{ username }}

{# suspend on closing the lid #}
{{ ns }}/suspend:
  cmd.run:
    - name: systemctl enable suspend-sedation.service
    - user: root
