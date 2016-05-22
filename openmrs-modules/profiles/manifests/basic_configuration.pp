class profiles::basic_configuration {
  class { 'apt':
    always_apt_update    => true,
  }
  
  package { ['unzip', 'curl', 'wget', 'tmpreaper'] :
    ensure  => latest,
  }
  
  cron { '/tmp':
    minute  => 15,
    hour    => 4,
    command => "/usr/sbin/tmpreaper 1d /tmp -a -T 120",
    require => Package['tmpreaper'],
  }
}