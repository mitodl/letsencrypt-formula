{% from "letsencrypt/map.jinja" import letsencrypt with context %}

{% for pkg in letsencrypt.pkgs %}
test_{{pkg}}_is_installed:
  testinfra.package:
    - name: {{ pkg }}
    - is_installed: True
{% endfor %}
