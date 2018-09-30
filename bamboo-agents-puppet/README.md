openmrs-contrib-bambooagent
===========================
Installation of Bamboo Agents.


## Updating Production/Staging machines
```
$ /etc/openmrs-puppet/bin/pull-changes.sh
$ /etc/openmrs-puppet/bin/run-puppet.sh
```

## New Production/Staging machines

### Requirements
  - Ubuntu 16.04
  - Puppet 4.x/Hiera/facter

### Setting up new machine

 - SSH key for clone is configured via terraform
 - Files are initially copied from ansible  


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


To run an Ubuntu 16.04 VM:
```$ vagrant up ```
.... and go grab a coffee. Or two. Maybe a shower. While waiting for it to finish downloading the internet.
Other vagrant commands can be found in [Confluence](https://wiki.openmrs.org/x/CIC3Ag)


To run only the tests:

```vagrant provision --provision-with serverspec
```

### Using secrets

To encrypt data for vagrant:

```
eyaml encrypt --pkcs7-public-key=hieradata/keys/vagrant/public_key.pkcs7.pem -s "<your string>"
```

## Tech considerations

While this runs in puppet 4, it's a migration from a puppet 3 tree, so we are not using the default folders for puppet code.  

It's not using puppet environments (it's not necessary in our case), we only use environments for hiera (puppet 3 style). So I decided to use a different puppet fact for that.

As we run masterless (and only on-demand), I decided to use a non-conventional folder.

We are using librarian-puppet (I don't think it's worth moving to r10k).  
