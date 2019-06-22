class profiles::bamboo_agent (
  $bamboo_server,
  $bamboo_user_home,
  $bamboo_user,
  $maven3_version,
  $grails_version,
) {
  class { '::bamboo_agent':
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
          'wrapper_conf_properties' => {
              'wrapper.java.command' => '/usr/lib/jvm/java-8-openjdk-amd64/jre/bin/java',
           },
	        'home'            => "$bamboo_user_home/bamboo-agent",
	        'user_name'       => $bamboo_user,
	        'group'           => $bamboo_user,
	        'private_tmp_dir' => true,
	    }
	  },
	  default_capabilities                                      => {
	    'system.builder.command.Bash'                           => '/bin/bash',
        'system.jdk.JDK\ 7'                                     => '/usr/lib/jvm/java-7-openjdk-amd64',
	    'system.jdk.openjdk-7-jdk'                              => '/usr/lib/jvm/java-7-openjdk-amd64',
	    'system.jdk.openjdk-8-jdk'                              => '/usr/lib/jvm/java-8-openjdk-amd64',
        'system.jdk.JDK\ 8'                                     => '/usr/lib/jvm/java-8-openjdk-amd64',
        'system.jdk.openjdk-11-jdk'                             => '/usr/lib/jvm/java-11-openjdk-amd64',
	    'system.jdk.JDK\ 11'                                    => '/usr/lib/jvm/java-11-openjdk-amd64',
	    'system.builder.mvn3.Maven\ 3'                          => "/usr/share/apache-maven-${maven3_version}",
	    "system.builder.grailsBuilder.Grails\\ $grails_version" => '/opt/grails',
	    'system.builder.node.Node.js'                           => '/usr/bin/nodejs',
	    'system.builder.grailsBuilder.Grails\ 2'                => '/opt/grails',
	    'system.git.executable'                                 => '/usr/bin/git',
	    'system.builder.command.transifex'                      => '/usr/bin/tx',
      'system.builder.command.nvm'                            => 'nvm',
	  },
	  require => Class['profiles::java'],
	}
}
