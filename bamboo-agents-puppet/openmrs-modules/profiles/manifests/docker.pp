class profiles::docker (
  $users,
){
  file { '/data/docker' :
    ensure  => directory,
    mode    => '0711',
    owner   => 'root',
    group   => 'root',
    recurse => true,
    purge   => true,
    source  => 'file:///var/lib/docker',
    
  }
  file { '/var/lib/docker':
    ensure => 'link',
    target => '/data/docker',
    force  => true,
  }
  class { '::docker':
    docker_users    => $users,
    dns             => ['8.8.8.8','8.8.4.4'],
    iptables        => true,
    version         => '5:20.10.7~3-0~ubuntu-xenial',
  }
  class { 'docker::compose':
    ensure  => 'present',
    version => '1.21.2',
  }
  #Enable multi-arch builds (not working until kernel upgraded to 4.8 or newer)
  exec { "docker run --rm --privileged multiarch/qemu-user-static --reset -p yes":
    path         => ["/usr/bin", "/usr/sbin"],
    subscribe    => [
                  Class['::docker'],
               ],
    refreshonly => true,
  }
  exec { "docker buildx create --name custom && docker buildx use custom":
    path         => ["/usr/bin", "/usr/sbin"],
    subscribe    => [
                  Class['::docker'],
               ],
    refreshonly => true,
  }
}
