class profiles::docker (
  $users,
){
  class { '::docker':
    docker_users => $users,
  }
}