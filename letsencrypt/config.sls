{% from "letsencrypt/map.jinja" import letsencrypt with context %}

include:
  - .install
  - .service

{% if letsencrypt.get('staging', false) %}
{% set staging = '--staging' %}
{% else %}
{% set staging = '' %}
{% endif %}

generate_certbot_{{ letsencrypt.CN }}:
  cmd.run:
    - name: >
        certbot --authenticator webroot -w {{ letsencrypt.webroot }}
        --installer {{ letsencrypt.webserver }} {{ staging }}
        --non-interactive --agree-tos --email {{ letsencrypt.email }}
        -d {{ letsencrypt.common_name }} \
        {% for subject_alternative_name in letsencrypt.subject_alternative_names %}
        -d {{ subject_alternative_name }} \
        {% endfor %}
        --expand
    - require:
      - pkg: install_certbot
    - onchanges_in:
      - service: certbot_service_running
