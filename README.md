openmrs-contrib-bambooagent
===========================
Installation of Bamboo Agents.

## Development environment

### Setting up
  - [Virtualbox](https://www.virtualbox.org/)
  - [Vagrant](https://www.vagrantup.com/)
  - git
  - ruby (2.1 recommended. Use rvm or renv for easier installation)


[Geppeto IDE](https://puppetlabs.github.io/geppetto/index.html) is recommended, but not necessary. 

## Running locally

Install required gems
```
$ gem install bundler
$ bundle install 
```

Download the correct versions of third party modules into 'modules' folder:
```$ librarian-puppet install```
When updating the `Puppetfile`, you'll need to rerun this command. 

 
To run an Ubuntu 14.04 VM:
```$ vagrant up ```
.... and go grab a coffee. Or two. Maybe a shower. While waiting for it to finish downloading the internet. 
Other vagrant commands can be found in [Confluence](https://wiki.openmrs.org/x/CIC3Ag)


## Production/Staging environments

### Requirements
  - Ubuntu 14.04
  - Puppet 3.x/Hiera/facter
This tree doesn't work with puppet 4. 

### Setting up new machine
#### Configuring git SSH
```
mkdir -p /root/.ssh
```

From your machine:
```
# copy files from this repository using, for example, scp
scp files/bamboo-github-key/id_rsa $SERVER:/root/.ssh/
scp files/ssh/config $SERVER:/root/.ssh/
```

#### Clone this repository into puppet folder
```
$ cd /etc
$ mv puppet puppet_old
$ git clone git@github.com:openmrs/openmrs-contrib-bambooagent.git puppet
```

### Installing more dependencies
```
$ /etc/puppet/bin/first-boot.sh
$ gem install librarian-puppet
```


### Running puppet
```
$ /etc/puppet/bin/run-puppet.sh
```
