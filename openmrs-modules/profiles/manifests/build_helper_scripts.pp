class profiles::build_helper_scripts {
  file { '/opt/scripts' :
    ensure  => directory,
    recurse => true,
    purge   => true,
    mode    => '0755',
    owner   => 'root',
    group   => 'root',
    source  => 'puppet:///modules/profiles/build_helper_scripts/scripts',
  }
}