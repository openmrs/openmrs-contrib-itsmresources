Follow this template for Nginx configuration:
```yaml
nginx_config_http_template_enable: true
nginx_config_http_template:
  # HTTP redirect for ci-new.openmrs.org
  - template_file: http/default.conf.j2
    deployment_location: /etc/nginx/conf.d/ci-new.openmrs.org.80.conf
    config:
      servers:
        - core:
            listen:
              - address: "0.0.0.0"
                port: 80
            server_name: ci-new.openmrs.org
          locations:
            - location: /
              core:
                return: "301 https://$host$request_uri"

  # HTTPS for ci-new.openmrs.org
  - template_file: http/default.conf.j2
    deployment_location: /etc/nginx/conf.d/ci-new.openmrs.org.conf
    config:
      servers:
        - core:
            listen:
              - port: 443
                ssl: true
            server_name: ci-new.openmrs.org
            client_max_body_size: "0"
            access_log: /var/log/nginx/ci-stg_access.log
            error_log: /var/log/nginx/ci-stg_error.log
            index: "index.html index.htm"
          ssl:
            certificate: /etc/letsencrypt/live/jinghu.openmrs.org/fullchain.pem
            certificate_key: /etc/letsencrypt/live/jinghu.openmrs.org/privkey.pem
          locations:
            - location: "^~ /.well-known/acme-challenge/"
              core:
                root: /usr/share/nginx/html
            - location: "/authors/"
              custom_directives:
                - "return 423;"
            - location: "/reports/"
              custom_directives:
                - "return 423;"
            - location: "/"
              proxy:
                pass: "http://127.0.0.1:8085/"
                set_header:
                  - field: "HOST"
                    value: "$host"
                  - field: "X-Forwarded-Proto"
                    value: "$scheme"
```

I'm not changing the existing NGINX configuration for all the other hosts. But moving forward, all new hosts should follow this template.