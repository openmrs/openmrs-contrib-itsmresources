class profiles::node_buildtime {
  class { 'nodejs':
    repo_url_suffix => '9.x',
    nodejs_package_ensure     => 'latest',
    nodejs_dev_package_ensure => 'latest',
    npm_package_ensure        => 'latest',
  }
  ->
  exec { 'install bower':
    command => "/usr/bin/npm install bower -g",
    creates => "/usr/bin/bower",
  }
}
