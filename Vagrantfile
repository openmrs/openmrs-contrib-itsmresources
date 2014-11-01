# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  # canonical Ubuntu basebox
  config.vm.box = "canonical-ubuntu-12.04"
  config.vm.box_url = "http://cloud-images.ubuntu.com/vagrant/precise/current/precise-server-cloudimg-amd64-vagrant-disk1.box"
  config.vm.hostname = "bamboo-agent.vagrant.openmrs.org"

  config.vm.synced_folder "files", "/etc/puppet/modules/openmrs-contrib-bambooagent/files"

  # Canonical basebox comes with an old puppet; uninstalling it. 
  # Also, git is required by librarian puppet. 
  config.vm.provision "shell",
   inline: "echo 'Installing git and removing installed puppet'; apt-get -q -y install git; apt-get remove -y puppet; apt-get remove -y facter"
  
  # Installing puppet and librarian-puppet
  config.vm.provision "shell",
    inline: "echo 'Installing puppet and librarian-puppet'; gem install puppet -v 3.1.1 --no-ri --no-rdoc; gem install librarian-puppet -v 0.9.17 --no-ri --no-rdoc"

  # Running librarian-puppet to download all puppet modules dependencies defined in Puppetfile
  config.vm.provision "shell",
    inline: "echo 'Running librarian-puppet to install puppet dependencies'; cp /vagrant/Puppetfile /etc/puppet; cd /etc/puppet; librarian-puppet install"

  # And running puppet 
  config.vm.provision "puppet" do |puppet|
      puppet.manifests_path = "."
      puppet.manifest_file  = "install.pp"
  end

end
