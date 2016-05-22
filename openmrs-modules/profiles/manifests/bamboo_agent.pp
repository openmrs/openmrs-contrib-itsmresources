class profiles::bamboo_agent (
  $bamboo_server,
  $bamboo_user_home_1,
  $bamboo_user_1,
  $bamboo_user_home_2,
  $bamboo_user_2,
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
	        'home'            => "$bamboo_user_home_1/bamboo-agent",
	        'user_name'       => $bamboo_user_1,
	        'group'           => $bamboo_user_1,
	        'private_tmp_dir' => true,
	    },
	    '2' => {
	        'home'            => "$bamboo_user_home_2/bamboo-agent",
	        'user_name'       => $bamboo_user_2,
	        'group'           => $bamboo_user_2,
	        'private_tmp_dir' => true,
	    }
	  },
	  default_capabilities                                      => {
	    'system.builder.command.Bash'                           => '/bin/bash',
	    'system.jdk.openjdk-6-jdk'                              => '/usr/lib/jvm/java-6-openjdk-amd64',
	    'system.jdk.JDK\ 1.7'                                   => '/usr/lib/jvm/java-7-openjdk-amd64',
	    'system.jdk.openjdk-7-jdk'                              => '/usr/lib/jvm/java-7-openjdk-amd64',
	    'system.jdk.openjdk-8-jdk'                              => '/usr/lib/jvm/java-8-openjdk-amd64',
	    'system.jdk.JDK\ 1.8'                                   => '/usr/lib/jvm/java-8-openjdk-amd64',
	    'system.builder.mvn3.Maven\ 3'                          => "/usr/share/apache-maven-${maven3_version}",
	    'system.builder.mvn2.Maven\ 2'                          => '/usr/share/maven2',
	    "system.builder.grailsBuilder.Grails\\ $grails_version" => '/opt/grails',
	    'system.builder.node.Node.js'                           => '/usr/bin/nodejs',
	    'system.builder.grailsBuilder.Grails\ 2'                => '/opt/grails',
	    'system.git.executable'                                 => '/usr/bin/git',
	    'system.builder.command.transifex'                      => '/usr/bin/tx',
	  },
	  require => Class['profiles::java'],
	}
}
