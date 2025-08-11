node default {
  # this tree/puppet-control only have one role; hence we are skipping roles and using only profiles.

  Package <| name == 'python-pip' |> -> Package <| provider == 'pip' |>

  include profiles::basic_configuration
  include profiles::java
  include profiles::scm
  include profiles::node_buildtime
  include profiles::ruby_buildtime
  include profiles::java_buildtime
  include profiles::python_buildtime
  include profiles::browsers
  include profiles::transifex
  include profiles::ssh_client
  include profiles::build_helper_scripts
}
