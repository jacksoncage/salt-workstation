{%- set name = 'base/vim' %}
{%- set ns = '/' + name %}
{%- set id = grains['id'] %}
{%- set username = salt['pillar.get']('username', 'love') %}

{{ ns }}/repo:
  pkgrepo.managed:
    - humanname: Neovim
    - name: deb http://ppa.launchpad.net/neovim-ppa/unstable/ubuntu vivid main
    - file: /etc/apt/sources.list.d/neovim.list
    - keyid: 55F96FCF8231B6DD
    - keyserver: keyserver.ubuntu.com
    - require_in:
      - pkg: {{ ns }}/installed

{{ ns }}/installed:
  pkg.latest:
    - name: neovim
    - refresh: True
    - skip_verify: True

{{ ns }}/alternatives/vi:
  alternatives.install:
    - name: vi
    - link: /usr/bin/vi
    - path: /usr/bin/nvim
    - priority: 60

{{ ns }}/alternatives/vim:
  alternatives.install:
    - name: vim
    - link: /usr/bin/vim
    - path: /usr/bin/nvim
    - priority: 60

{{ ns }}/alternatives/editor:
  alternatives.install:
    - name: editor
    - link: /usr/bin/editor
    - path: /usr/bin/nvim
    - priority: 60

{{ ns }}/plugin/path:
  file.directory:
    - name: /home/love/.vim/plugin
    - user: love
    - makedirs: True

{{ ns }}/plugin-manager:
  cmd.run:
    - name: git clone https://github.com/Shougo/dein.vim /home/love/.vim/plugin/dein.vim
    - creates: /home/love/.vim/plugin/dein.vim
