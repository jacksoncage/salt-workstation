{# This state will create users accounts #}
{%- set name             = 'base/users' %}
{%- set ns               = '/' + name %}
{%- set id               = grains['id'] %}
{%- set test_username    = salt['pillar.get']('username', 'love') %}

include:
  - base.sudoers

{% for username, details in pillar.get('users', {}).items() %}
{{ ns }}/{{ username }}:
  group.present:
    - name: {{ username }}
    {% if 'gid' in details %}
    - gid: {{ details.get('gid', '') }}
    {% endif %}
  user.present:
    - fullname: {{ details.get('fullname','') }}
    - name: {{ username }}
    - shell: /bin/bash
    - home: /home/{{ username }}
    {% if 'uid' in details %}
    - uid: {{ details.get('uid', '') }}
    {% endif %}
    {% if 'gid' in details %}
    - gid: {{ details.get('gid', '') }}
    {% endif %}
    {% if 'password' in details %}
    - password: {{ details.get('password','') }}
    {% endif %}
    - enforce_password: False
    {% if 'groups' in details %}
    - groups:
      {% for group in details.get('groups', []) %}
      - {{ group }}
      {% endfor %}
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
    - makedirs: True
{% endfor -%}
