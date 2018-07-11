{% from "letsencrypt/map.jinja" import letsencrypt with context %}

include:
  - .service

letsencrypt:
  pkg.installed:
    - pkgs: {{ letsencrypt.pkgs }}
    - require_in:
        - service: letsencrypt_service_running
