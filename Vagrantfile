# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  # canonical Ubuntu basebox
  config.vm.box = "canonical-ubuntu-14.04"
  config.vm.box_url = "https://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box"
  config.vm.hostname = "bamboo-agent.vagrant.openmrs.org"

  config.vm.synced_folder "files", "/etc/puppet/modules/openmrs-contrib-bambooagent/files"

  # git is required by librarian puppet; ruby-dev is required to install gems 
  config.vm.provision "shell",
   inline: "echo 'Installing git and ruby-dev'; apt-get -q -y install git; apt-get install -y ruby-dev; apt-get -y autoremove"
  
  # Installing puppet and librarian-puppet
  config.vm.provision "shell",
    inline: "echo 'Installing librarian-puppet; it can take a few minutes'; gem install librarian-puppet --no-ri --no-rdoc"

  # Running librarian-puppet to download all puppet modules dependencies defined in Puppetfile
  config.vm.provision "shell",
    inline: "echo 'Running librarian-puppet to install puppet dependencies'; cp /vagrant/Puppetfile /etc/puppet; cd /etc/puppet; librarian-puppet install"

  # And running puppet 
  config.vm.provision "puppet" do |puppet|
      puppet.manifests_path = "."
      puppet.manifest_file  = "install.pp"
  end

end
