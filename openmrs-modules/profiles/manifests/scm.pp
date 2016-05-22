class profiles::scm {
  package { ['git', 'subversion' ]: 
    ensure  => latest,
  }
  
  bamboo_agent_home::file { '.gitconfig':
    content => template('profiles/scm/gitconfig'),
  }
}