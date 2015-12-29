{%- set name             = 'wm' %}
{%- set ns               = '/base/' + name %}

{# Install packges #}
{{ ns }}/installed:
  pkg.latest:
    - pkgs:
      - feh
      - i3
      - i3lock
      - i3status
      - scrot
      - slim

{%- if grains['osfinger'] == 'Debian-8' %}
{{ ns }}/enabled:
  cmd.run:
    - name: systemctl enable i3lock
    - user: root
{%- endif %}

{{ ns }}/install/slim/minimal:
  git.latest:
    - name: https://github.com/naglis/slim-minimal.git
    - target: /usr/share/slim/themes/slim-minimal
    - identity: /home/love/.ssh/id_rsa
    - require:
      - pkg: {{ ns }}/installed

{# update clickpad settings #}
{{ ns }}/clickpad:
  file.managed:
    - name: /etc/X11/xorg.conf.d/50-synaptics-clickpad.conf
    - source: salt://base/wm/files/etc/X11/xorg.conf.d/50-synaptics-clickpad.conf
    - user: root
    - group: root
    - mode: 644
    - makedirs: True
    - require:
      - pkg: {{ ns }}/installed

{# # add xorg conf #}
{{ ns }}/config/xorg:
  file.managed:
    - name: /etc/X11/xorg.conf
    - source: salt://base/wm/files/etc/X11/xorg.conf
    - user: root
    - group: root
    - mode: 644
    - makedirs: True
    - require:
      - pkg: {{ ns }}/installed

{# get correct sound cards on boot #}
{{ ns }}/config/modprobe:
  file.managed:
    - name: /etc/modprobe.d/intel.conf
    - source: salt://base/wm/files/etc/modprobe.d/intel.conf
    - user: root
    - group: root
    - mode: 644
    - makedirs: True
    - require:
      - pkg: {{ ns }}/installed

{# pretty fonts #}
{{ ns }}/config/fonts:
  file.managed:
    - name: /etc/fonts/local.conf
    - source: salt://base/wm/files/etc/fonts/local.conf
    - user: root
    - group: root
    - mode: 644
    - makedirs: True
    - require:
      - pkg: {{ ns }}/installed

{# setup fonts #}
{{ ns }}/setup/fonts:
  cmd.run:
    - name: |
        dpkg-reconfigure fontconfig-config
        dpkg-reconfigure fontconfig
    - user: root
    - require:
      - file: {{ ns }}/config/fonts
