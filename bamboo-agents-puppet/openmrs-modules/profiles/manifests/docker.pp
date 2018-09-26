class profiles::docker (
  $users,
){
  class { '::docker':
    docker_users    => $users,
    dns             => ['8.8.8.8','8.8.4.4'],
    iptables        => true,
    version         => '18.06.1~ce~3-0~ubuntu',
  }
  class { 'docker::compose':
    ensure  => 'present',
    version => '1.21.2',
  }
}
