class profiles::node_buildtime (
  $bamboo_user = lookup('bamboo_agent_home::bamboo_user'),
){
  class { 'nodejs':
    repo_url_suffix           => '6.x',
    nodejs_package_ensure     => 'latest',
    npm_package_name          => false,
  }
  ->
  package { 'bower':
    provider => 'npm',
  }
  ->
  package { 'npm':
    ensure   => '5.5.1',
    provider => 'npm',
  }

  class { 'nvm':
    user => $bamboo_user,
  }
}
