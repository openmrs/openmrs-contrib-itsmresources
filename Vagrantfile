# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  # canonical Ubuntu basebox
  config.vm.box = "ubuntu/trusty64"
  config.vm.hostname = "bamboo-agent.vagrant.openmrs.org"
  config.vm.synced_folder ".", "/etc/puppet/"

  config.vm.provider "virtualbox" do |v|
    v.memory = 1024
    v.cpus = 2
  end

  config.vm.provision "shell", :path => 'bin/first-boot.sh' 
  
  # And running puppet 
  config.vm.provision "puppet" do |puppet|
    puppet.module_path = [ 'modules', 'openmrs-modules' ]
    puppet.manifest_file = 'site.pp'
#    puppet.options = ['--debug']
#    puppet.facter = {
#      "environment" => "vagrant"
#    }
  end

end
