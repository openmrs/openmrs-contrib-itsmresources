class profiles::transifex {
  package { 'transifex-client':
    ensure  => latest,
  }
  bamboo_agent_home::file { '.transifexrc':
    content => template('profiles/transifex/dot-transifexrc.erb'),
  }
}