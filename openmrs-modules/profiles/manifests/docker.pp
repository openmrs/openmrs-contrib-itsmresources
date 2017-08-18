class profiles::docker (
  $users,
){
  class { '::docker':
    docker_users    => $users,
    dns             => ['8.8.8.8','8.8.4.4'],
    iptables        => true,
    version         => '1.13.0-0~ubuntu-xenial',
  }
  class { 'docker::compose':
    ensure  => 'present',
    version => '1.10.1',
  }
}
