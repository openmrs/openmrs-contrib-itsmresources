class bamboo_agent_home (
  $bamboo_user_1 = hiera('bamboo_agent_home::bamboo_user_1'),
  $bamboo_user_2 = hiera('bamboo_agent_home::bamboo_user_2'),
  $bamboo_user_home_1 = hiera('bamboo_agent_home::bamboo_user_home_1'),
  $bamboo_user_home_2 = hiera('bamboo_agent_home::bamboo_user_home_2'),
){
  user { $bamboo_user_1:
    ensure     => 'present',
    managehome => true,
    home       => $bamboo_user_home_1,
  }

  user { $bamboo_user_2:
    ensure     => 'present',
    managehome => true,
    home       => $bamboo_user_home_2,
  }
}
