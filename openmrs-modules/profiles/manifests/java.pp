class profiles::java {
  apt::ppa { 'ppa:openjdk-r/ppa' : }
  ->
  package { ['openjdk-7-jre','openjdk-6-jdk', 'openjdk-8-jdk']:
    ensure  => present,
  }
  exec{ "update-java-alternatives -s java-1.7.0-openjdk":
    path         => ["/usr/bin", "/usr/sbin"],
    subscribe    => [
                  Package['openjdk-7-jre'],
                  Package['openjdk-6-jdk'],
                  Package['openjdk-8-jdk']
               ],
    refreshonly => true,
  }
}
