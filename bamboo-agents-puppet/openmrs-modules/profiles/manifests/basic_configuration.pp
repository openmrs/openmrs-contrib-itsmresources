class profiles::basic_configuration {
  class { 'apt':
    update => {
      frequency => 'always',
    },
  }

  package { ['unzip', 'tmpreaper'] :
    ensure  => latest,
  }

  cron { '/tmp':
    minute  => 15,
    hour    => 4,
    command => "/usr/sbin/tmpreaper 1d /tmp -a -T 120",
    require => Package['tmpreaper'],
  }

  bamboo_agent_home::data_dirextory { 'scratch':
    backup => false,
  }
}
