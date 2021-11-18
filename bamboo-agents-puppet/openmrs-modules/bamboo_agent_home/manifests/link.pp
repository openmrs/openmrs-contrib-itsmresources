define bamboo_agent_home::link (
  $bamboo_user = lookup('bamboo_agent_home::bamboo_user'),
  $destination = $name,
  $mode   = '700',
  $recurse = false,
  $purge = false,
  $force = false,
  $source = undef,
){
  include ::bamboo_agent_home

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
  
  file { "/home/${bamboo_user}/${destination}":
    ensure => 'link',
    target => '/data/${destination}',
  }
}
