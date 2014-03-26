##
# openmrs-contrib-bambooagent
# Required OS: Ubuntu
# Required modules: puppetlabs/apt, kayak/bamboo_agent
##
# Vars
$bamboo_server = "ci.openmrs.org"

# Ensure the ppa repo is installed before installing maven3 package
class prepare {
  class { 'apt':
    always_apt_update    => true,
  }
  apt::ppa { 'ppa:natecarlson/maven3': }
  apt::ppa { 'ppa:chris-lea/node.js' : }
}
include prepare

# Install packages needed for building
class install {
  $JavaPackages = [ 'maven2','maven3','ant','git','openjdk-7-jre','openjdk-6-jdk','subversion','nodejs' ]
  package { $JavaPackages :
    ensure  => present,
    require => Class['prepare'],
  }

  # Install packages needed for tests
  $TestPackages = [ 'chromium-browser','firefox','xvfb' ]
  package { $TestPackages :
    ensure  => latest,
    require => Class['prepare'],
  }
# Extract and install grails and softlink it to /opt/grails
  $GrailsVersion = "2.3.7"
  exec { 'fetch grails' :
    command => "/usr/bin/wget http://dist.springframework.org.s3.amazonaws.com/release/GRAILS/grails-$GrailsVersion.zip",
    cwd     => '/opt',
    creates => "/opt/grails-$GrailsVersion.zip",
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
    target => "/opt/grails-$GrailVersion",    
    require => Exec['extract grails'],
  }
}
include install

# Configs for maven, ssh keys.  Place these in the files directory in module directory
class configs {
  file { '/etc/maven2/settings.xml' :
    ensure  => file,
    mode    => 644,
    source  => 'puppet:///modules/openmrs-contrib-bambooagent/settings.xml.mvn2',
    require => Class['install'],
  }
  file { '/usr/share/maven3/conf/settings.xml' :
    ensure  => file,
    mode    => 644,
    source  => 'puppet:///modules/openmrs-contrib-bambooagent/settings.xml.mvn3',
    require => Class['install'],
  }
  file { 'ssh-keys' :
    ensure  => directory,
    path    => '/home/bamboo/bamboo-ssh-deploy',
    recurse => true,
    mode    => 600,
    owner   => 'bamboo',
    group   => 'bamboo',
    source  => 'puppet:///modules/openmrs-contrib-bambooagent/bamboo-ssh-deploy',
  }
    file { 'bamboo-ssh-keys' :
    ensure  => directory,
    path    => '/home/bamboo/.ssh',
    recurse => true,
    mode    => 600,
    owner   => 'bamboo',
    group   => 'bamboo',
    source  => 'puppet:///modules/openmrs-contrib-bambooagent/ssh/',
  }
  file { '/opt/scripts' :
    ensure  => directory,
    path    => '/opt/scripts',
    recurse => true,
    mode    => 700,
    owner   => 'bamboo',
    group   => 'bamboo',
    source  => 'puppet:///modules/openmrs-contrib-bambooagent/scripts',
  }
  file { '/opt/bamboo-home' :
    ensure => "directory",
    owner  => "bamboo",
    group  => "bamboo",
    mode   => 700,
    }
}
include configs

# Install bamboo remote agents. Adjust agents accordingly
class { 'bamboo_agent':
  require                 => Class['install'],
  server                  => $bamboo_server,
  agents                  => [1,2],
  install_dir             => '/opt/bamboo-agent',
  agent_defaults          => {
    'manage_capabilities' => true,
    'wrapper_conf_properties' => {
         'wrapper.app.parameter.2' => "https://${bamboo_server}/agentServer/",
      }
  },
  default_capabilities                                    => {
    'system.builder.command.Bash'                         => '/bin/bash',
    'hostname'                                            => $::hostname,
    'reserved'                                            => false,
    'system.jdk.openjdk-6-jdk'                            => '/usr/lib/jvm/java-6-openjdk-amd64',
    'system.jdk.openjdk-7-jdk'                            => '/usr/lib/jvm/java-7-openjdk-amd64',
    'system.builder.mvn3.Maven3'                          => '/usr/share/maven3',
    'system.builder.mvn2.Maven\ 2'                        => '/usr/share/maven2',
    "system.builder.grailsBuilder.Grails\ $GrailsVersion" => '/opt/grails',
    'system.builder.node.Node.js'                         => '/usr/bin/nodejs',
  }
}
