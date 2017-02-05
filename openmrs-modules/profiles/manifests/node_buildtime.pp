class profiles::node_buildtime {
  class { 'nodejs':
    repo_url_suffix => '6.x',
    nodejs_package_ensure     => 'latest',
  }
  
  package { 'bower':
    provider => 'npm',
  }
}
