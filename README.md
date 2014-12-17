openmrs-contrib-bambooagent
===========================
## Running locally with vagrant
Exactly as described in https://wiki.openmrs.org/x/CIC3Ag:
 - Virtualbox
 - Vagrant
 - $ vagrant up


## Requirements
- Ubuntu 14.04
- Puppet 3.x
- Git, make, ruby-dev

## Install Instructions
- Install required modules
```
gem install librarian-puppet  --no-ri --no-rdoc
# Copy puppetfile from this repository using, for example, scp
cp Puppetfile /etc/puppet/
cd /etc/puppet/; librarian-puppet install
```
- Add a ssh key to root user
```
mkdir -p /root/.ssh
#copy files/bamboo-github-key/id_rsa from this repository using, for example, scp
cp files/bamboo-github-key/id_rsa /root/.ssh/
```
- Create a /root/.ssh/config file
```
Host github.com
	HostName github.com
	PreferredAuthentications publickey
	IdentityFile /root/.ssh/id_rsa
```
- Change into module directory
```
cd /etc/puppet/modules
```
- Clone this repo into the modules directory
```
# git clone git@github.com:openmrs/openmrs-contrib-bambooagent.git
```
- Apply the puppet module
```
# puppet apply install.pp
```

## Updating Agent
```
cd /etc/puppet/modules/openmrs-contrib-bambooagent
sudo git pull
sudo puppet apply install.pp
```
