class bamboo_agent_home (
  $bamboo_user = lookup('bamboo_agent_home::bamboo_user'),
  $bamboo_user_home = lookup('bamboo_agent_home::bamboo_user_home'),
){
  user { $bamboo_user:
    ensure     => 'present',
    managehome => true,
    home       => $bamboo_user_home,
  }
}
