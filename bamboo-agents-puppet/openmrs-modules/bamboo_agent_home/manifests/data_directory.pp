define bamboo_agent_home::data_directory (
  $bamboo_user = lookup('bamboo_agent_home::bamboo_user'),
  $destination = $name,
  $mode   = '770',
  $recurse = false,
  $purge = false,
  $force = false,
  $source = undef,
) {
  file { "/data/${destination}":
    ensure  => directory,
    mode    => $mode,
    recurse => $recurse,
    purge   => $purge,
    force   => $force,
    source  => $source,
    owner   => $bamboo_user,
    group   => $bamboo_user,
    require => User[$bamboo_user],
  }
}
