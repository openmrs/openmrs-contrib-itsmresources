# Declares the agent a Puppet service and ensures it is running and enabled,
# after rendering an init script that delegates to the agent's bamboo-agent.sh
# script.
# *** This type should be considered private to this module ***
define bamboo_agent::service(
  $home,
  $id = $title,
  $user,
){

  $service = "bamboo-agent${id}"
  $script  = "${home}/bin/bamboo-agent.sh"
  $agent_id = $id

  file { "/etc/init.d/${service}":
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    content => template('bamboo_agent/init-script.erb'),
  }
  ->
  service { $service:
    ensure    => running,
    enable    => true,
  }
}
