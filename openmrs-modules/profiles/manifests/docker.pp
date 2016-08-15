class profiles::docker (
  $users,
){
  class { '::docker':
    docker_users    => $users,
    dns             => ['8.8.8.8','8.8.4.4'],
    iptables        => false,
    version         => 'latest',
  }
  class { 'docker::compose':
    ensure  => 'present',
    version => '1.8.0',
  }
}
