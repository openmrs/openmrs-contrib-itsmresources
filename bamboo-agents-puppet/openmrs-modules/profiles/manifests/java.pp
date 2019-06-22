class profiles::java {
  apt::ppa { 'ppa:openjdk-r/ppa' : }
  ->
  package { 'openjdk-11-jdk': # java 11
    ensure  => present,
    require => Exec['apt_update'],
  }

  # Force default of JDK 8
  exec{ "update-java-alternatives -s java-1.8.0-openjdk":
    path         => ["/usr/bin", "/usr/sbin"],
    subscribe    => [
                  Package['openjdk-11-jdk'],
                  Package['java'],
               ],
    refreshonly => true,
  }
}
