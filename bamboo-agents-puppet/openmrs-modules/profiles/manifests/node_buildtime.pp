class profiles::node_buildtime {
  class { 'nodejs':
    repo_url_suffix           => '6.x',
    nodejs_package_ensure     => 'latest',
    legacy_debian_symlinks    => false,
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
}
