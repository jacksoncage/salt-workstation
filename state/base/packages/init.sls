{%- set name             = 'packges' %}
{%- set ns               = '/base/' + name %}

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
      - virtualbox
      - vagrant
      - rdesktop
      {%- if grains['testingtravis'] is defined %}{% else %}
      - cgroupfs-mount
      {%- endif %}

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
