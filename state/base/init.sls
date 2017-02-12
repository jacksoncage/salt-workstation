{%- set name             = 'base' %}
{%- set ns               = '/' + name %}

{# Include base applications and it's configs #}
include:
  - .packages
  - .ntp
  - .make
  - .sshd
  - .sudoers
  - .users
  - .vim
  - .rsyslog
  - .tlp
  - .fprint
  - .wifi
  - .dropbox
  - .keepass

