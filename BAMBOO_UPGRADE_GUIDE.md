# Bamboo Upgrade Guide

This comprehensive guide covers upgrading Bamboo from version 8.2.4 to the latest version, including server migration and environment setup.

## Prerequisites and Dependencies

### Python 3.13 and Ansible 2.18.6 Installation

Before starting the Bamboo upgrade process, ensure you have the correct Python and Ansible versions installed.

#### Install Python 3.13 on Ubuntu 22.04

1. **Install build dependencies:**
   ```bash
   sudo apt update
   sudo apt install -y build-essential libssl-dev zlib1g-dev \
       libncurses-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm \
       libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev
   ```

2. **Download and compile Python 3.13:**
   ```bash
   cd /usr/src
   sudo wget https://www.python.org/ftp/python/3.13.5/Python-3.13.5.tgz
   sudo tar xzf Python-3.13.5.tgz
   cd Python-3.13.5
   sudo ./configure --enable-optimizations
   sudo make -j$(nproc)
   sudo make altinstall
   ```

3. **Verify Python installation:**
   ```bash
   python3.13 --version
   ```

#### Set Up Virtual Environment and Install Ansible

1. **Create and activate virtual environment:**
   ```bash
   python3.13 -m venv /ansible-py13-venv
   source /ansible-py13-venv/bin/activate
   ```

2. **Install Ansible 2.18.6:**
   ```bash
   pip install --upgrade pip
   pip install ansible==11.7.0
   ```

3. **Create convenient alias:**
   ```bash
   echo '#!/bin/bash
   source /ansible-py13-venv/bin/activate
   ansible "$@"' > /ansible
   chmod +x /ansible
   sudo mv /ansible /usr/local/bin/ansible
   ```

### Java Environment Configuration

- **Set JAVA_HOME:**
  ```bash
  export JAVA_HOME="$(readlink -f $(which java) | sed 's:bin/java::')"
  ```

- **Switch between Java versions (if multiple installed):**
  ```bash
  sudo update-alternatives --config java
  ```

## Bamboo Upgrade Process

### Step 1: Preparation and Backups

> ⚠️ **Important**: Pause all builds and deployments before proceeding.

1. **Stop the current Bamboo service:** (Optional as it is production and we may not want to stop it)
   ```bash
   sudo -u bamboo /opt/bamboo/bin/stop-bamboo.sh
   ```

2. **Create database backup:**
   ```bash
   mysqldump --databases bamboo > bamboo_backup.sql
   ```

3. **Create home directory backup:**
   ```bash
   tar -czvf bamboo_home_backup.tar.gz /data/bamboo_home
   ```

### Step 2: Transfer Data to New Server

Transfer the backed-up data to the new server:

1. **Transfer Bamboo home directory:**
   ```bash
   rsync -av --exclude='v' bamboo_home/ your-username@jinghu.openmrs.org:/data/bamboo_home-prod
   ```
   > 📝 **Note**: We exclude the 'v' directory to avoid copying old version artifacts and use a different directory name to avoid conflicts.

2. **Transfer database backup:**
   ```bash
   rsync -av bamboo_backup.sql your-username@jinghu.openmrs.org:/home/your-username/
   ```

### Step 3: Install Old Bamboo Version (8.2.4)

Install the same version that was previously running to ensure compatibility:

```bash
cd /opt
sudo wget https://product-downloads.atlassian.com/software/bamboo/downloads/atlassian-bamboo-8.2.4.tar.gz
sudo tar -xzf atlassian-bamboo-8.2.4.tar.gz
sudo mv atlassian-bamboo-8.2.4 bamboo-old
sudo chown -R bamboo:bamboo /opt/bamboo-old
```

### Step 4: Configure Old Bamboo Instance

Configure Bamboo to use the transferred home directory:

```bash
sudo nano /opt/bamboo-old/atlassian-bamboo/WEB-INF/classes/bamboo-init.properties
```

Set the home directory:
```properties
bamboo.home=/data/bamboo_home-prod
```

### Step 5: Import Database

Restore the database backup:

```bash
mysql bamboo < /home/your-username/bamboo_backup.sql
```

### Step 6: Start and Verify Old Instance

1. **Start the old Bamboo instance:**
   ```bash
   sudo -u bamboo /opt/bamboo-old/bin/start-bamboo.sh
   ```

2. **Verify functionality:**
   - Open your web browser and navigate to `https://your-server-url`
   - Ensure all builds and configurations are intact

3. **Check logs for issues:**
   ```bash
   sudo tail -f /opt/bamboo-old/logs/catalina.out
   sudo tail -f /data/bamboo_home-prod/logs/atlassian-bamboo.log
   ```

### Step 7: Upgrade to Latest Version

1. **Stop the old Bamboo instance:**
   ```bash
   sudo -u bamboo /opt/bamboo-old/bin/stop-bamboo.sh
   ```

2. **Run Ansible playbook for new installation:**
   ```bash
   ansible-galaxy install -r requirements.yml --force
   ansible-playbook -vv -i inventories/prod-tier2 --limit jinghu.openmrs.org site.yml
   ```

### Step 8: Configure New Bamboo Instance

1. **Move home directory to expected location:**
   ```bash
   sudo mv /data/bamboo_home-prod /data/bamboo_home
   ```

2. **Configure new Bamboo instance:**
   ```bash
   sudo nano /opt/bamboo/atlassian-bamboo/WEB-INF/classes/bamboo-init.properties
   ```
   
   Set the home directory:
   ```properties
   bamboo.home=/data/bamboo_home
   ```

3. **Change the license key in bamboo.cfg.xml:**
   ```bash
   sudo nano /data/bamboo_home/bamboo.cfg.xml
   <property name="license.string">YOUR_NEW_LICENSE_KEY</property>
   ```
   Update the license key as needed.
   Get the license key from the Atlassian account.
   https://www.atlassian.com/purchase/my/license-evaluation

4. **Update the URL in bamboo.cfg.xml:**
   ```bash
   sudo nano /data/bamboo_home/bamboo.cfg.xml
   <property name="bamboo.jms.broker.client.uri">failover:(tcp://YOUR_SUBDOMAIN.openmrs.org:54663?wireFormat.maxInactivityDuration=300000)?initialReconnectDelay=15000&amp;maxReconnectAttempts=10</property>
   ```
5. **Update the URL in bamboo_home/shared/configuration/administration.xml:**
   ```bash
   sudo nano /data/bamboo_home/shared/configuration/administration.xml
   <myBaseUrl>https://YOUR_SUBDOMAIN.openmrs.org</myBaseUrl>
   ```

### Step 9: Start and Verify New Instance

1. **Start the new Bamboo service:**
   ```bash
   systemctl start bamboo
   ```

2. **Verify the upgrade:**
   - Navigate to `https://your-server-url` in your web browser
   - Ensure the new Bamboo instance is running correctly
   - Verify that migrations are proceeding as expected

3. **Monitor migration logs:**
   ```bash
   sudo tail -f /opt/bamboo/logs/catalina.out
   sudo tail -f /data/bamboo_home/logs/atlassian-bamboo.log
   ```

## Reference Documentation

- [Bamboo Upgrade Guide (Official)](https://confluence.atlassian.com/bamboo/bamboo-upgrade-guide-720411366.html)
- [MySQL Collation and Character Set Fix](https://confluence.atlassian.com/bamkb/how-to-fix-the-collation-and-character-set-of-a-mysql-database-1345820601.html)
- [Bamboo Version Build Numbers](https://marketplace.atlassian.com/rest/2/products/key/bamboo/versions?limit=100&_ga=2.30616379.566521521.1547416824-1897136561.1522036691)
- [MySQL Dump Format Documentation](https://dev.mysql.com/doc/refman/8.4/en/mysqldump-sql-format.html)
- [Connecting Bamboo to MySQL](https://confluence.atlassian.com/bamboo/connect-bamboo-to-a-mysql-database-289276817.html)
- [Running Bamboo as Linux Service](https://confluence.atlassian.com/bamboo/running-bamboo-as-a-linux-service-416056046.html)

## Troubleshooting

### Common Issues

1. **Database collation errors**: Refer to the MySQL collation fix documentation above
2. **Permission issues**: Ensure proper ownership with `sudo chown -R bamboo:bamboo`
3. **Port conflicts**: Verify no other services are using Bamboo's ports
4. **Memory issues**: Check JVM settings in Bamboo configuration

### Log Locations

- **Bamboo application logs**: `/data/bamboo_home/logs/atlassian-bamboo.log`
- **Tomcat logs**: `/opt/bamboo/logs/catalina.out`
- **System service logs**: `journalctl -u bamboo -f`