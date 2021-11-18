define bamboo_agent_home::link (
  $bamboo_user = lookup('bamboo_agent_home::bamboo_user'),
  $destination = $name,
  $mode   = '700',
){
  include ::bamboo_agent_home

  file { "/data/${destination}":
    ensure  => directory,
    mode    => $mode,
    recurse => true,
    purge   => true,
    force   => $force,
    source  => 'file:///home/${bamboo_user}/destination',
    owner   => $bamboo_user,
    group   => $bamboo_user,
    require => User[$bamboo_user],
  }
  
  file { "/home/${bamboo_user}/${destination}":
    ensure => 'link',
    target => '/data/${destination}',
    force  => true,
  }
}
