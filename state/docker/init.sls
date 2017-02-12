{%- set name = 'docker' %}
{%- set ns = '/' + name %}

{{ ns }}/install_deps:
  pkg.latest:
    - pkgs:
      - iptables
      - ca-certificates
      - apt-transport-https
      - python-apt
      - python-pip

{{ ns }}/add_repo:
  pkgrepo.managed:
    - name: 'deb https://apt.dockerproject.org/repo debian-jessie main'
    - file: '/etc/apt/sources.list.d/docker.list'
    - keyid: 58118E89F3A912897C070ADBF76221572C52609D
    - keyserver: hkp://p80.pool.sks-keyservers.net:80

{{ ns }}/install:
  pkg.latest:
    - name: docker-engine
    - require:
      - pkg: {{ ns }}/install_deps
      - pkgrepo: {{ ns }}/add_repo

{{ ns }}nstall_python_deps:
  pip.installed:
    - name: docker-py>=1.4.0
    - require:
      - pkg: {{ ns }}/install_deps

{{ ns }}/onroot_access:
  cmd.run:
    - name: |
        groupadd docker
        gpasswd -a love docker
    - require:
      - pkg: {{ ns }}/install

{{ ns }}/running:
  service.running:
    - name: docker
    - require:
      - pkg: {{ ns }}/install
