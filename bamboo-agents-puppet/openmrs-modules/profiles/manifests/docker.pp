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
  } ->
  #Enable multi-arch builds
  archive { "/usr/local/lib/docker/cli-plugins/docker-buildx":
    ensure => present,
    source => 'https://github.com/docker/buildx/releases/download/v0.8.2/buildx-v0.8.2.linux-amd64',
    user   => 'root',
    mode   => '0755',
  } ->
  exec { "docker buildx create --name cibuilder --use":
    path         => ["/usr/bin", "/usr/sbin"],
    subscribe    => [
                  Class['::docker'],
               ],
    refreshonly => true,
  }
}