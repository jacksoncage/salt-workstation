{# This state will create users accounts #}
{%- set name             = 'base/users' %}
{%- set ns               = '/' + name %}
{%- set id               = grains['id'] %}

{% for username, details in pillar.get('users', {}).items() %}
{{ ns }}/{{ username }}:
  group.present:
    - name: {{ username }}
    - gid: {{ details.get('gid', '') }}
  user.present:
    - fullname: {{ details.get('fullname','') }}
    - name: {{ username }}
    - shell: /bin/bash
    - home: /home/{{ username }}
    - uid: {{ details.get('uid', '') }}
    - gid: {{ details.get('gid', '') }}
    - password: {{ details.get('password','') }}
    {% if 'groups' in details %}
    - groups:
      {% for group in details.get('groups', []) %}
      - {{ group }}
      {% endfor %}
    - require:
      {% for group in details.get('groups', []) %}
      - group: {{ group }}
      {% endfor %}
      - sls: base.sshd
    {% endif %}
  {% if 'pub_ssh_keys' in details %}
  ssh_auth.present:
    - user: {{ username }}
    - names:
    {% for pub_ssh_key in details.get('pub_ssh_keys', []) %}
      - {{ pub_ssh_key }}
    {% endfor %}
    - require:
      - user: {{ username }}
  {% endif %}

{{ ns }}/{{ username }}/permissions:
  file.managed:
    - name: /home/{{ username }}/.ssh/authorized_keys
    - mode: 600
    - user: {{ username }}
{% endfor -%}
