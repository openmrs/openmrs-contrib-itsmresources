# A module for installing multiple Bamboo agents on a node.
#
# === Parameters
#
# [server_url] URL of the web interface of your Bamboo server. Required.
#
# [agents] A list of agent names, or hash of agent names and
#   parameters, describing the agents that should be installed. See
#   the examples, and the agent type, for more information.
#
# [agent_defaults] Default parameters for the agent type.
#
# [install_dir] The parent directory where agents should be installed.
#
# [user_name] Name of the bamboo system user.
#
# [manage_user] Whether this module should declare the bamboo user.
#
# [user_options] Advanced user parameters. Only applies if manage_user
#   is true. See the r9utils::system_user type for more details.
#
# [java_classname] The name of a Java class that should be applied
#   before installing agents.
#
# [java_command] Java command to use when installing agents.
#
# [default_capabilities] Set of default agent capabilities.
#
# ******* DEPRECATED DEPRECATED DEPRECATED ********
# The following params are deprecated, do not use!
#
# [server] Hostname of your Bamboo server.
#
# [server_port] Port where Bamboo server is listening. Default 8085
#
# [server_protocol] Protocol to use for bamboo server. Default "http"
#
#
# === Examples
#
# Install a single Bamboo agent in /usr/local/bamboo:
#
# class { 'bamboo_agent':
#   server_url => 'http://your.bamboo.server:8085',
# }
#
# Install two Bamboo agents, named "1" and "2", in /home/bamboo:
#
# class { 'bamboo_agent':
#   server_url  => 'http://your.bamboo.server:8085',
#   agents      => [1,2],
#   install_dir => '/home/bamboo',
# }
#
# Install two Bamboo agents. Give agent 1 extra heap space and give
# agent 2 some custom capabilities.
#
# class { 'bamboo_agent':
#   server_url => 'http://your.bamboo.server:8085',
#   agents => {
#     '1' => {
#       'wrapper_conf_properties' => {
#          'wrapper.java.maxmemory' => '2048',
#       }
#     },
#     '2' => {
#       'manage_capabilities' => true,
#       'capabilities' => {
#          'system.builder.command.Bash' => '/bin/bash',
#          'hostname' => $::hostname,
#          'os' => $::operatingsystem,
#       }
#     }
#   },
# }
#
# Ensure that your preferred Java class has been applied before
# attempting to install any Bamboo agents.
#
# class { 'bamboo_agent':
#   server_url     => 'http://your.bamboo.server:8085',
#   java_classname => 'my_favorite_java',
# }
#
class bamboo_agent(
  $server_url      = 'UNSET',

  $agents         = [1],
  $agent_defaults = {},
  $install_dir    = '/usr/local/bamboo',

  $user_name      = 'bamboo',
  $manage_user    = true,
  $user_options   = {
    'shell' => '/bin/bash',
  },

  $java_classname = 'java',
  $java_command   = 'java',

  $default_capabilities = {},

  # Deprecated! Please use $server_url instead.
  $server          = 'UNSET',
  $server_port     = 8085,
  $server_protocol = 'http',
){

  $user_group = pick($user_options['group'],$user_name)

  # Workaround for http://projects.puppetlabs.com/issues/16178
  $real_manage_user = str2bool("${manage_user}")

  if $real_manage_user {
    create_resources('r9util::system_user',
                      { "${user_name}" => $user_options })
  }

  file { $install_dir:
    ensure => directory,
    owner  => $user_name,
    group  => $user_group,
    mode   => '0755',
  }

  if $server_url == 'UNSET' {
    if $server == 'UNSET' {
      fail('Parameter $server_url is required!')

    } else {
      $dep_msg = 'Parameters $server, $server_port, and $server_protocol are deprecated in the bamboo_agent module, please use $server_url instead'

      notify { 'bamboo-module-deprecation-warning':
        message  => $dep_msg,
        loglevel => 'warning',
      }
    }

    $final_server_url = "${server_protocol}://${server}:${server_port}"
  } else {
    $final_server_url = $server_url
  }

  $installer_jar = "${install_dir}/bamboo-agent-installer.jar"

  r9util::download { 'bamboo-agent-installer':
    url  => "${final_server_url}/agentServer/agentInstaller",
    path => $installer_jar,
  }
  ->
  file { $installer_jar:
    mode  => '0644',
    owner => $user_name,
    group => $user_group,
  }

  $agent_list = normalize_agents_arg($agents)
  create_resources(bamboo_agent::agent,
                    $agent_list,
                    $agent_defaults)
}
