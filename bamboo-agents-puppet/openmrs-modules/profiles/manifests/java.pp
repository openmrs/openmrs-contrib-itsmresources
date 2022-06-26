class profiles::java {

  package { ['openjdk-11-jdk', 'openjdk-8-jdk']: 
    ensure  => present,
    require => Exec['apt_update']
  }
}
