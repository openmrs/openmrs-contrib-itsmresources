# Ansible-role-docker-discourse

* Env Vars
```
# Required Variables Defaults
DISCOURSE_HTTP_PORT: 80

DISCOURSE_HOSTNAME: discourse.localhost

DISCOURSE_DEVELOPER_EMAILS: developer1@example.com, developer2@example.com
DISCOURSE_SMTP_ADDRESS: localhost
DISCOURSE_SMTP_PORT: 587
DISCOURSE_SMTP_USER_NAME: username@example.com
DISCOURSE_SMTP_PASSWORD: aS0meWh@ts3cuR3P@assW0rd(HashesCauseProblems)
DISCOURSE_SMTP_ENABLE_START_TLS: true
DISCOURSE_FROM_EMAIL: emailbot@example.com

# Optinal Variables Defaults
DISCOURSE_INSTALLATION_DIR: /opt/discourse
DISCOURSE_HOME_DIR: /var/discourse/shared/standalone
DISCOURSE_LOGS_DIR: /var/log/discourse

DISCOURSE_DB_SHARED_BUFFERS: 256MB
DISCOURSE_DB_WORK_MEMORY: 40MB
DISCOURSE_UNICORN_WORKERS: 4
DISCOURSE_DEFAULT_LOCALE: en
DISCOURSE_APP_NAME: app
DISCOURSE_VERSION: tests-passed
DISCOURSE_REPO_VERSION: master
```
