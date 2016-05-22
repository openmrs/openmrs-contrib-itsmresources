define bamboo_agent_home::file (
  $bamboo_user_1 = hiera('bamboo_agent_home::bamboo_user_1'),
  $bamboo_user_2 = hiera('bamboo_agent_home::bamboo_user_2'),
  $content,
  $destination = $name,
  $mode   = '600',
){ 
  include ::bamboo_agent_home
  
  file { "/home/${bamboo_user_1}/${destination}":
    mode    => $mode,
    owner   => $bamboo_user_1,
    group   => $bamboo_user_1,
    content => $content,
    require => User[$bamboo_user_1],
  }

  file { "/home/${bamboo_user_2}/${destination}":
    mode    => $mode,
    owner   => $bamboo_user_2,
    group   => $bamboo_user_2,
    content => $content,
    require => User[$bamboo_user_2],
  }
}