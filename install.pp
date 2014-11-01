##
# openmrs-contrib-bambooagent
# Required OS: Ubuntu 12.04
# Required modules should be installed previously with librarian-puppet
# $ gem install librarian-puppet -v 0.9.17 --no-ri --no-rdoc
# $ cp Puppetfile /etc/puppet/
# $ cd /etc/puppet/; librarian-puppet install

##
# Vars
$bamboo_server = "https://ci.openmrs.org/"
$GrailsVersion = "2.3.7"
$bamboo_user_1="bamboo-agent-1"
$bamboo_user_home_1 = "/home/bamboo-agent-1"
$bamboo_user_2="bamboo-agent-2"
$bamboo_user_home_2 = "/home/bamboo-agent-2"

# Ensure the ppa repo is installed before installing maven3 package
class prepare {
  
  class { 'apt':
    always_apt_update    => true,
  }
  apt::ppa { 'ppa:natecarlson/maven3': }
  apt::ppa { 'ppa:chris-lea/node.js' : }

  user { $bamboo_user_1:
    ensure     => 'present',
    managehome => true,
    home       => $bamboo_user_home_1, 
  }

  user { $bamboo_user_2:
    ensure     => 'present',
    managehome => true,
    home       => $bamboo_user_home_2, 
  }

}
include prepare


# Install packages needed for building
class install {
  $JavaPackages = [ 'maven2','maven3','ant','git','openjdk-7-jre','openjdk-6-jdk','subversion','nodejs' ]
  package { $JavaPackages :
    ensure  => present,
    require => Class['prepare'],
  }
  #Install packages needed for tests
  $TestPackages = [ 'chromium-browser','firefox','xvfb' ]
  package { $TestPackages :
    ensure  => latest,
    require => Class['prepare'],
  }
   # Other helper packages
  package { 'unzip' :
    ensure  => latest,
    require => Class['prepare'],
  }
  exec { 'fetch grails' :
    command => "/usr/bin/wget http://dist.springframework.org.s3.amazonaws.com/release/GRAILS/grails-$GrailsVersion.zip",
    cwd     => '/opt',
    creates => "/opt/grails-$GrailsVersion.zip",
    timeout     => 1800,
    require => Package['unzip']
  }
  exec { 'extract grails' :
    command => "/usr/bin/unzip -o grails-$GrailsVersion.zip",
    cwd     => '/opt',
    creates => "/opt/grails-$GrailsVersion",
    require => Exec['fetch grails'],
  }
  file { 'link grails' :
    path   => '/opt/grails',
    ensure => 'link',
    target => "/opt/grails-$GrailsVersion",    
    require => Exec['extract grails'],
  }
}
include install

define bamboo_agent_home_config(
  $home = $title,
  $user,
  $group,
){

  file { "$home/.m2/" :
    ensure  => directory,
    mode    => 644,
    owner   => $user,
    group   => $group,
    require => User[$user],
  }

  file { "$home/.gitconfig" :
    ensure => file,
    mode   => 600,
    owner   => $user,
    group   => $group,
    source => 'puppet:///modules/openmrs-contrib-bambooagent/gitconfig',
    require => User[$user],
  }

  file { "$home/.m2/settings.xml" :
    ensure => file,
    mode   => 600,
    owner  => $user,
    group  => $group,
    source => 'puppet:///modules/openmrs-contrib-bambooagent/mvn_settings.xml',
  }

  file { "$home/bamboo-ssh-deploy" :
    ensure  => directory,
    recurse => true,
    purge   => true, # remove unmanaged files
    force   => true, # remove unmanaged subdirectories and files
    mode    => 600,
    owner   => $user,
    group   => $group,
    source  => 'puppet:///modules/openmrs-contrib-bambooagent/bamboo-ssh-deploy',
    require => User[$user],
  }

  file { "$home/bamboo-github-key" :
    ensure  => directory,
    recurse => true,
    purge   => true, # remove unmanaged files
    force   => true, # remove unmanaged subdirectories and files
    mode    => 600,
    owner   => $user,
    group   => $group,
    require => User[$user],
    source  => 'puppet:///modules/openmrs-contrib-bambooagent/bamboo-github-key', 
  }

  file { "$home/.ssh" :
    ensure  => directory,
    recurse => true,
    purge   => true, # remove unmanaged files
    force   => true, # remove unmanaged subdirectories and files
    mode    => 600,
    owner   => $user,
    group   => $group,
    require => User[$user],
    source  => 'puppet:///modules/openmrs-contrib-bambooagent/ssh/',
  }
}

# Configs for maven, ssh keys.  Place these in the files directory in module directory
class configs {

  bamboo_agent_home_config { $bamboo_user_home_1:
    user   => $bamboo_user_1,
    group  => $bamboo_user_1,
  }

  bamboo_agent_home_config { $bamboo_user_home_2:
    user   => $bamboo_user_2,
    group  => $bamboo_user_2,
  }
  file { '/opt/scripts' :
    ensure  => directory,
    recurse => true,
    mode    => 755,
    owner   => 'root',
    group   => 'root',
    source  => 'puppet:///modules/openmrs-contrib-bambooagent/scripts',
  }
}
include configs


# Install bamboo remote agents. Adjust agents accordingly
class { 'bamboo_agent':
  require                 => Class['configs'],
  server_url              => $bamboo_server,
  manage_user             => false, 
  install_dir             => "/opt/bamboo-agent",
  user_name               => 'root', 
  agent_defaults          => {
    'manage_capabilities' => true,
    'refresh_service'     => true,
  },
  agents     => {
    '1' => {
        'home'       => "$bamboo_user_home_1/bamboo-agent",
        'user_name'  => $bamboo_user_1,
        'group'      => $bamboo_user_1,
    },
    '2' => {
        'home'       => "$bamboo_user_home_2/bamboo-agent",
        'user_name'  => $bamboo_user_2,
        'group'      => $bamboo_user_2,
    }
  }, 
  default_capabilities                                     => {
    'system.builder.command.Bash'                          => '/bin/bash',
    'hostname'                                             => $::hostname,
    'reserved'                                             => false,
    'system.jdk.openjdk-6-jdk'                             => '/usr/lib/jvm/java-6-openjdk-amd64',
    'system.jdk.openjdk-7-jdk'                             => '/usr/lib/jvm/java-7-openjdk-amd64',
    'system.builder.mvn3.Maven3'                           => '/usr/share/maven3',
    'system.builder.mvn2.Maven\ 2'                         => '/usr/share/maven2',
    "system.builder.grailsBuilder.Grails\\ $GrailsVersion" => '/opt/grails',
    'system.builder.node.Node.js'                          => '/usr/bin/nodejs',
    'system.builder.grailsBuilder.Grails\ 2'               => '/opt/grails',
  }
}

