{% from "letsencrypt/map.jinja" import letsencrypt with context %}

certbot_service_running:
  service.running:
    - name: {{ letsencrypt.service }}
    - enable: True
