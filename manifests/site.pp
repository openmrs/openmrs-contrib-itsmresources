node default {
  # this tree/puppet-control only have one role; hence we are skipping roles and using only profiles.

  include profiles::basic_configuration
  include profiles::java
  include profiles::scm
  include profiles::docker
  include profiles::node_buildtime
  include profiles::ruby_buildtime
  include profiles::java_buildtime
  include profiles::browsers
  include profiles::transifex
  include profiles::ssh_client
  include profiles::build_helper_scripts
  include profiles::bamboo_agent
}
