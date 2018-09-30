class profiles::transifex (
  $transifex_username,
  $transifex_password,
){
  package { 'pyOpenSSL':
    ensure   => '17.5.0',
    provider => 'pip',
  } ->
  package { 'transifex-client':
    ensure  => '0.12.5',
    provider => 'pip',
  }
  bamboo_agent_home::file { '.transifexrc':
    content => template('profiles/transifex/dot-transifexrc.erb'),
  }
}
