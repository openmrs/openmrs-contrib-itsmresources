define bamboo_agent_home::link (
  $bamboo_user = lookup('bamboo_agent_home::bamboo_user'),
  $content,
  $destination = $name,
  $mode   = '600',
){
  include ::bamboo_agent_home

  file { "/data/${destination}":
    mode    => $mode,
    owner   => $bamboo_user,
    group   => $bamboo_user,
    content => $content,
    require => User[$bamboo_user],
  }
  
  file { "/home/${bamboo_user}/${destination}":
    ensure => 'link',
    target => '/data/${destination}',
  }
}
