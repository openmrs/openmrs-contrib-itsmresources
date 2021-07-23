class profiles::docker (
  $users,
){
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
  #Enable multi-arch builds
  package { ['qemu', 'qemu-user-static']:
    ensure  => present,
    require => Exec['apt_update'],
  }
  exec { "docker run --privileged --rm tonistiigi/binfmt --install all":
    path         => ["/usr/bin", "/usr/sbin"],
    subscribe    => [
                  Class['::docker'],
                  Package['qemu'],
                  Package['qemu-user-static'],
               ],
    refreshonly => true,
  }
  exec { "docker buildx create --name custom && docker buildx use custom":
    path         => ["/usr/bin", "/usr/sbin"],
    subscribe    => [
                  Class['::docker'],
                  Package['qemu'],
                  Package['qemu-user-static'],
               ],
    refreshonly => true,
  }
}
