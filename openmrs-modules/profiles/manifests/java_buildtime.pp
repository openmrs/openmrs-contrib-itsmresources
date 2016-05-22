class profiles::java_buildtime (
  $maven3_version,
){
  bamboo_agent_home::directory { '.m2': }
  ->
  bamboo_agent_home::file { '.m2/settings.xml':
    content => template('profiles/java_buildtime/settings.xml')
  }

  package { [ 'maven2', 'ant']:
    ensure  => present,
    require => Class['profiles::java']
  }

  # install maven 3. Forcing some very specific version, the apt repos only keep the latest one
  wget::fetch { 'fetch maven 3':
    source      => "http://apache.mirrors.pair.com/maven/maven-3/${maven3_version}/binaries/apache-maven-${maven3_version}-bin.zip",
    destination => '/tmp/mvn3.zip',
    require => Package['unzip']
  }
  ~>
  exec { 'extract maven 3':
    command => "/usr/bin/unzip -o /tmp/mvn3.zip",
    cwd     => "/usr/share/",
    creates => "/usr/share/apache-maven-${maven3_version}/",
  }
  ~>
  file { 'link mvn' :
    path   => '/bin/mvn3',
    ensure => 'link',
    target => "/usr/share/apache-maven-${maven3_version}/bin/mvn",
  }
}
