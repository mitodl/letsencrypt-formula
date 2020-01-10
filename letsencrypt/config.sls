{% from "letsencrypt/map.jinja" import letsencrypt with context %}

include:
  - .install
  - .service

{% if letsencrypt.get('staging', false) %}
{% set staging = '--staging' %}
{% else %}
{% set staging = '' %}
{% endif %}

{% set domains = [letsencrypt.common_name] + letsencrypt.subject_alternative_names %}

generate_certbot_{{ letsencrypt.common_name }}:
  cmd.run:
    - name: >
        certbot --authenticator webroot -w {{ letsencrypt.webroot }}
        --installer {{ letsencrypt.webserver }} {{ staging }}
        --non-interactive --agree-tos --email {{ letsencrypt.email }}
        -d {{ domains|join(',') }}
        --expand
    - require:
      - pkg: install_certbot
    - onchanges_in:
      - service: certbot_service_running
