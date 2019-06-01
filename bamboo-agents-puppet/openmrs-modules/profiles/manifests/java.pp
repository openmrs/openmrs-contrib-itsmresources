class profiles::java {
  apt::ppa { 'ppa:openjdk-r/ppa' : }
  ->
  package { ['openjdk-7-jdk', 'openjdk-11-jdk']: # java 7 and 11
    ensure  => present,
    require => Exec['apt_update'],
  }

  # The latest available version of openjdk 7 doesn't support letsencrypt certs like our maven repo
  # Unfortunately the repo doesn't provide updates
  file { '/usr/lib/jvm/java-7-openjdk-amd64/jre/lib/security/letsencrypt-chain.pem':
    ensure  => file,
    mode    => '0744',
    owner   => 'root',
    group   => 'root',
    source  => 'puppet:///modules/profiles/letsencrypt/chain.pem',
    require => Package['openjdk-7-jdk'],
  }

  exec { "letsencrypt-certs":
    path        => ["/usr/lib/jvm/java-7-openjdk-amd64/bin/"],
    cwd         => "/usr/lib/jvm/java-7-openjdk-amd64/",
    command     => "keytool -trustcacerts -keystore jre/lib/security/cacerts -storepass changeit \
                    -noprompt -importcert -file jre/lib/security/letsencrypt-chain.pem",
    subscribe   => Package['openjdk-7-jdk'],
    refreshonly => true,
  }

  # Force default of JDK 8
  exec{ "update-java-alternatives -s java-1.8.0-openjdk":
    path         => ["/usr/bin", "/usr/sbin"],
    subscribe    => [
                  Package['openjdk-7-jdk'],
                  Package['openjdk-11-jdk'],
                  Package['java'],
               ],
    refreshonly => true,
  }
}
