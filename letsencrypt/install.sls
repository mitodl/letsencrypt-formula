{% from "letsencrypt/map.jinja" import letsencrypt with context %}
{% set os_family = salt.grains.get('os_family') %}
{% set distro_codename = salt.grains.get('lsb_distrib_codename') %}

{% if os_family == 'Debian' %}
configure_backports_repo:
  pkgrepo.managed:
    - humanname: letsencrypt
    - name: deb http://ftp.debian.org/debian {{ distro_codename }}-backports main
    - refresh_db: True
    - enabled: 1

install_certbot:
  pkg.installed:
    - name: {{ letsencrypt.pkg }}-{{ letsencrypt.webserver }}
    - fromrepo: {{ distro_codename }}-backports
    - require:
        - pkgrepo: configure_backports_repo

{% elif os_family == 'RedHat' %}
install_certbot:
  pkg.installed:
    - name: {{ letsencrypt.pkg }}-{{ letsencrypt.webserver }}
{% endif %}
