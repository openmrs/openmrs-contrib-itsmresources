# Ansible-role-docker-discourse

* Env Vars
```
# Required Variables
DISCOURSE_HTTP_PORT: 80

DISCOURSE_HOSTNAME: discourse.localhost

DISCOURSE_DEVELOPER_EMAILS: developer1@example.com, developer2@example.com
DISCOURSE_SMTP_ADDRESS: localhost
DISCOURSE_SMTP_PORT: 587
DISCOURSE_SMTP_USER_NAME: username@example.com
DISCOURSE_SMTP_PASSWORD: aS0meWh@ts3cuR3P@assW0rd(HashesCauseProblems)
DISCOURSE_SMTP_ENABLE_START_TLS: true
DISCOURSE_FROM_EMAIL: emailbot@example.com

DISCOURSE_DB_PASSWORD: aS3cur3P@assw0rdfoRp0$tGr3S$

# Optinal Variables
DISCOURSE_INSTALLATION_DIR: /opt/discourse
DISCOURSE_WEB_DIR: /var/discourse/shared/web
DISCOURSE_WEB_LOGS_DIR: /var/log/discourse/web
DISCOURSE_DATA_DIR: /var/discourse/shared/data
DISCOURSE_DATA_LOGS_DIR: /var/log/discourse/data

DISCOURSE_DB_SHARED_BUFFERS: 256MB
DISCOURSE_DB_WORK_MEMORY: 40MB
DISCOURSE_UNICORN_WORKERS: 4
DISCOURSE_DEFAULT_LOCALE: en
DISCOURSE_WEB_CONTAINER_NAME: web
DISCOURSE_DATA_CONTAINER_NAME: data
DISCOURSE_VERSION: tests-passed
DISCOURSE_REPO_VERSION: master

```
