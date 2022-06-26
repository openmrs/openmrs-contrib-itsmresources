class profiles::node_buildtime (
  $bamboo_user      = lookup('bamboo_agent_home::bamboo_user'),
  $bamboo_user_home = lookup('bamboo_agent_home::bamboo_user_home')
){
  
  bamboo_agent_home::link { '.npm': 
    backup => false,
  }
  ->
  bamboo_agent_home::link { '.nvm': 
    backup => false,
  }
  ->
  class { 'nvm': 
    user         => $bamboo_user,
    profile_path => "${bamboo_user_home}/.profile",
    nvm_dir      => '/data/.nvm',
    version      => 'v0.34.0',
  }
}
