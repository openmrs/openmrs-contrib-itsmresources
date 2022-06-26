# Configures a single agent on the node.
#
# === Parameters
#
# [id] A unique-to-this-node name for this agent. Eg: "1","A","jimmy"
#
# [home] Path to agent's home directory (will be created)
#
# [wrapper_conf_properties] List of properties that should be
#   overridden in the agent's wrapper.conf with Augeas.
#
# [manage_capabilities] Whether to manage this agent's capabilities
#   using the bamboo-capabilities.properties file (search the Bamboo
#   docs for "bamboo-capabilities.properties" for information about
#   configuring agents this way)
#
# [capabilities] Hash of capabilities to set for this agent. Only
#   applies if $manage_capabilities is true.
#
# [expand_id_macros] When true, any occurrences of the string "!ID!"
#   in the capabilities hash will be replaced with $id
#
# [private_tmp_dir] Whether to configure this agent to use a private
#   tmp directory, instead of the system tmp directory.
#
# [refresh_service] Whether to restart the agent after a change to
#   bamboo-capabilities.properties or wrapper.conf.
#
# [user_name] The username to be the owner of agent-specific folders
#   By default, it's the same as configured in the bamboo_agent
#   This user is not managed by this module, so it needs to be previously created
#
# [group] The group to be the owner of agent-specific folders
#   By default, it's the same as configured in the bamboo_agent, in the user_options
#
# === Examples
#
# Suppose an agent on the node "somehost" is defined with the
# following capabilities:
#
# bamboo_agent::agent { '1':
#   ...
#   manage_capabilities => true,
#   capabilities => {
#     'agentkey' => "${::hostname}-!ID!",
#   },
#   expand_id_macros => true,
# }
#
# The agent would have the custom capability "agentkey" set to
# "somehost-1".
#
define bamboo_agent::agent(
  $id           = $title,
  $home         = "${bamboo_agent::install_dir}/agent${title}-home",
  $wrapper_conf_properties = {},
  $manage_capabilities     = false,
  $capabilities            = {},
  $expand_id_macros        = true,
  $private_tmp_dir         = false,
  $refresh_service         = false,
  $user_name               = $bamboo_agent::user_name,
  $group                   = $bamboo_agent::user_group,
){

  validate_hash($wrapper_conf_properties)
  validate_hash($capabilities)

  if $id !~ /\A[-\w]+\z/ {
    fail("${id} is not a valid agent id")
  }

  file { $home:
    ensure => directory,
    owner  => $user_name,
    group  => $group,
    mode   => '0755',
  }
  ->
  bamboo_agent::install { "install-agent-${id}":
    id     => $id,
    home   => $home,
    user   => $user_name,
    group  => $group,
  }

  $install = Bamboo_Agent::Install["install-agent-${id}"]

  bamboo_agent::service { $id:
    home    => $home,
    require => $install,
    user    => $user_name,
  }

  if $manage_capabilities {
    bamboo_agent::capabilities { $id:
      home             => $home,
      capabilities     => merge($bamboo_agent::default_capabilities,
                                $capabilities),
      expand_id_macros => $expand_id_macros,
      before           => Bamboo_Agent::Service[$id],
      require          => $install,
      user             => $user_name,
      group            => $group,
    }

    if $refresh_service {
       Bamboo_Agent::Capabilities[$id] ~> Bamboo_Agent::Service[$id]
    }
  }

  if $private_tmp_dir {
    $agent_tmp    = "${home}/.agent_tmp"
    $tmp_dir_props = {
      'set.TMP'                   => $agent_tmp,
      'wrapper.java.additional.3' => "-Djava.io.tmpdir=${agent_tmp}",
    }
    bamboo_agent::private_tmp { 
      $agent_tmp: require => $install, 
                  user    => $user_name,
                  group   => $group,
    }
  }else{
    $tmp_dir_props = {}
  }

  bamboo_agent::wrapper_conf { $id:
    home       => $home,
    properties => merge($tmp_dir_props,
                        $wrapper_conf_properties),
    before     => Bamboo_Agent::Service[$id],
    require    => $install,
    user       => $user_name,
    group      => $group,
  }

  if $refresh_service {
    Bamboo_Agent::Wrapper_Conf[$id] ~> Bamboo_Agent::Service[$id]
  }
}
