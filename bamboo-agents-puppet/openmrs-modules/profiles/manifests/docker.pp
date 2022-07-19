class profiles::docker (
  $users,
  $bamboo_user      = lookup('bamboo_agent_home::bamboo_user'),
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
  } ->
  #Enable multi-arch builds
  archive { '/usr/local/lib/docker/cli-plugins/docker-buildx':
    ensure => present,
    source => 'https://github.com/docker/buildx/releases/download/v0.8.2/buildx-v0.8.2.linux-amd64',
    user   => 'root',
  } ->
  file { '/usr/local/lib/docker/cli-plugins/docker-buildx':
    ensure  => file,
    mode    => '0755'
  } ->
  exec { "docker run --rm --privileged multiarch/qemu-user-static --reset -p yes":
    path         => ["/usr/bin", "/usr/sbin"],
    user         => $bamboo_user,
  } ->
  exec { "docker buildx create --name cibuilder --use":
    path         => ["/usr/bin", "/usr/sbin"],
    user        => $bamboo_user,
  }
}