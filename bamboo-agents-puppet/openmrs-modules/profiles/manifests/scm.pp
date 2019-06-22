class profiles::scm {
  package { 'git':
    ensure  => latest,
  }

  bamboo_agent_home::file { '.gitconfig':
    content => template('profiles/scm/gitconfig'),
  }
}
