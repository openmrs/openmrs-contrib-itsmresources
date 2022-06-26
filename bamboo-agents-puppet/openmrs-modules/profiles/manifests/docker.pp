class profiles::docker (
  $users,
){
  file { '/data/docker' :
    ensure  => directory,
    mode    => '0711',
    owner   => 'root',
    group   => 'root',
    links   => follow,
  } ->
  file { '/var/lib/docker':
    ensure => 'link',
    target => '/data/docker',
    force  => true,
    backup => false,
  }
  

  #Enable multi-arch builds (not working until kernel upgraded to 4.8 or newer)
  #exec { "docker run --rm --privileged multiarch/qemu-user-static --reset -p yes":
  #  path         => ["/usr/bin", "/usr/sbin"],
  #  subscribe    => [
  #                Class['::docker'],
  #             ],
  #  refreshonly => true,
  #}
  #exec { "docker buildx create --name custom && docker buildx use custom":
  #  path         => ["/usr/bin", "/usr/sbin"],
  #  subscribe    => [
  #                Class['::docker'],
  #             ],
  #  refreshonly => true,
  #}
}