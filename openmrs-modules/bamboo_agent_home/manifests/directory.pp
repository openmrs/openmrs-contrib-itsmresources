define bamboo_agent_home::directory (
  $bamboo_user_1 = hiera('bamboo_agent_home::bamboo_user_1'),
  $bamboo_user_2 = hiera('bamboo_agent_home::bamboo_user_2'),
  $destination = $name,
  $mode   = '750',
  $recurse = false,
  $purge = false,
  $force = false,
  $source = undef,
){ 
  include ::bamboo_agent_home
  
  file { "/home/${bamboo_user_1}/${destination}":
    ensure  => directory,
    mode    => $mode,
    recurse => $recurse,
    purge   => $purge, 
    force   => $force,
    source  => $source,
    owner   => $bamboo_user_1,
    group   => $bamboo_user_1,
    require => User[$bamboo_user_1],
  }

  file { "/home/${bamboo_user_2}/${destination}":
    ensure  => directory,
    mode    => $mode,
    recurse => $recurse,
    purge   => $purge, 
    force   => $force,
    source  => $source,
    owner   => $bamboo_user_2,
    group   => $bamboo_user_2,
    require => User[$bamboo_user_2],
  }
}