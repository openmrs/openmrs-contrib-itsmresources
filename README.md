openmrs-contrib-bambooagent
===========================

## Requirements
- Ubuntu 12.04
- Puppet 3.x

## Install Instructions
- Install required modules
```
# puppet module install puppetlabs/apt
# puppet module install kayak/bamboo_agent
```
- Add this to root's ssh config ( /root/.ssh/config ) for easy pulling
```
Host github.com
	HostName github.com
	PreferredAuthentications publickey
	IdentityFile /home/bamboo/.ssh/id_rsa
```
- Change into module directory
```
cd /etc/puppet/modules
```
- Clone this repo into the modules directory
```
# git clone git@github.com:downeym/openmrs-contrib-bambooagent.git
```
- Configure bamboo server and number of agents in `install.pp`
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
