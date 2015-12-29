{%- set name             = 'base' %}
{%- set ns               = '/' + name %}

{%- if grains['testingtravis'] is defined %}{% else %}
{# Setup apt source #}
{{ ns }}/source/add:
  file.managed:
    - name: /etc/apt/sources.list
    - source: salt://base/file/source.list
    - makedirs: True
    - template: jinja

{# turn off translations, speed up apt-get update #}
{{ ns }}/source/apt.conf.d:
  file.managed:
    - name: /etc/apt/apt.conf.d/99translations
    - contents: Acquire::Languages "none";
    - makedirs: True
    - template: jinja
{%- endif %}

{# Install base packges #}
{{ ns }}/installed:
  pkg.latest:
    - install_recommends: False
    - pkgs:
      - htop
      - dnstop
      - iotop
      - tmux
      - etckeeper
      - wget
      - openssl
      - libssl-dev
      - python-pip
      - python-dev
      - python-apt
      - adduser
      - alsa-utils
      - apt-transport-https
      - automake
      - bash-completion
      - bc
      - bridge-utils
      - bzip2
      - ca-certificates
      - cgroupfs-mount
      - cmake
      - coreutils
      - curl
      - dnsutils
      - file
      - findutils
      - fortune-mod
      - fortunes-off
      - gcc
      - git
      - gnupg
      - gnupg-agent
      - gnupg-curl
      - grep
      - gzip
      - hostname
      - indent
      - iptables
      - jq
      - less
      - libc6-dev
      - libltdl-dev
      - libnotify-bin
      - locales
      - lsof
      - make
      - mercurial
      - mount
      - net-tools
      - nfs-common
      - network-manager
      - openvpn
      - rxvt-unicode-256color
      - s3cmd
      - scdaemon
      - silversearcher-ag
      - ssh
      - strace
      - sudo
      - tar
      - tree
      - tzdata
      - unzip
      - xclip
      - xcompmgr
      - xz-utils
      - zip

{# Setup time, always use sweden time but not if we run tests via docker #}
{%- if grains['prd'] is defined %}
{{ ns }}/time:
  file.symlink:
    - name: /etc/localtime
    - target: /usr/share/zoneinfo/Europe/Stockholm
    - force: True

{{ ns }}/timezone:
  timezone.system:
   - name: Europe/Stockholm
{%- endif %}

{# Include base applications and it's configs #}
include:
  - .ntp
  - .make
  - .sshd
  - .sudoers
  - .users
  - .vim
  - .rsyslog
  - .tlp
  - .fprint
  - .graphics
  - .wifi
  - .wm
  - .systemd
