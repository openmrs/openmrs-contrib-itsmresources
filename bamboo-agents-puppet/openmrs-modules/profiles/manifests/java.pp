class profiles::java {
  apt::ppa { 'ppa:openjdk-r/ppa' : }
  ->
  package { 'openjdk-7-jdk': # java 7
    ensure  => present,
    require => Exec['apt_update'],
  }

  exec{ "update-java-alternatives -s java-1.8.0-openjdk":
    path         => ["/usr/bin", "/usr/sbin"],
    subscribe    => [
                  Package['openjdk-7-jdk'],
                  Package['java'],
               ],
    refreshonly => true,
  }
}
