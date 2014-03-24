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
- Change into module directory
```
cd /etc/puppet/modules
```
- Clone this repo into the modules directory
```
# git clone https://github.com/downeym/openmrs-contrib-bambooagent.git
```
- Configure bamboo server and number of agents in `install.pp`
- Apply the puppet module
```
# puppet apply install.pp
```
