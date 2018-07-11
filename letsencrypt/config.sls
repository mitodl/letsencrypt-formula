{% from "letsencrypt/map.jinja" import letsencrypt with context %}

include:
  - .install
  - .service

letsencrypt-config:
  file.managed:
    - name: {{ letsencrypt.conf_file }}
    - source: salt://letsencrypt/templates/conf.jinja
    - template: jinja
    - watch_in:
      - service: letsencrypt_service_running
    - require:
      - pkg: letsencrypt
