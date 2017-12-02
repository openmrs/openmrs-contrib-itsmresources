define bamboo_agent_home::file (
  $bamboo_user = hiera('bamboo_agent_home::bamboo_user'),
  $content,
  $destination = $name,
  $mode   = '600',
){
  include ::bamboo_agent_home

  file { "/home/${bamboo_user}/${destination}":
    mode    => $mode,
    owner   => $bamboo_user,
    group   => $bamboo_user,
    content => $content,
    require => User[$bamboo_user],
  }
}
