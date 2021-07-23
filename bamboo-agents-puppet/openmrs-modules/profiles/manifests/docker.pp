class profiles::docker (
  $users,
){
  class { '::docker':
    docker_users    => $users,
    dns             => ['8.8.8.8','8.8.4.4'],
    iptables        => true,
    version         => '20.10.7~3-0~ubuntu',
  }
  class { 'docker::compose':
    ensure  => 'present',
    version => '1.21.2',
  }
}
