{%- set name = 'base/print' %}
{%- set ns = '/' + name %}
{%- set id = grains['id'] %}
{%- set username = salt['pillar.get']('username', 'love') %}

{{ ns }}/samsung/repo/dep:
  pkg.installed:
   - sources: 
     - suldr-keyring: http://www.bchemnet.com/suldr/pool/debian/extra/su/suldr-keyring_2_all.deb
   - cache_valid_time: 300
   - require_in:
     - pkgrepo: {{ ns }}/samsung/repo

{{ ns }}/samsung/repo:
  pkgrepo.managed:
    - humanname: Samsungmfp
    - name: deb http://www.bchemnet.com/suldr/ debian extra
    - file: /etc/apt/sources.list.d/samsungmfp.list
    - require_in:
      - pkg: {{ ns }}/samsung/installed

{{ ns }}/samsung/installed:
  pkg.latest:
    - pkgs:
      - suld-driver-4.00.39
      - suld-ppd-1
      - suld-driver-common-1
    - refresh: True

