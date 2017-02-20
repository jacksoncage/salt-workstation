{%- set name             = 'dotfiles' %}
{%- set ns               = '/' + name %}
{%- set username         = salt['pillar.get']('username', 'love') %}

{# create all dotfiles in home folder #}
{{ ns }}/add:
  file.recurse:
    - name: /home/{{ username }}
    - source: salt://dotfiles/files/home
    - user: {{ username }}
    - group: {{ username }}
    - file_mode: 644
    - dir_mode: 755
    - makedirs: True
    - backup: minion

{% for file in ['.gitignore', '.gitconfig' ]%}
{{ ns }}/symlink/git/{{ file }}:
  file.symlink:
    - name: /home/{{ username }}/{{ file }}
    - target: /home/{{ username }}/Dropbox/Apps/git/{{ file }}
{% endfor %}
