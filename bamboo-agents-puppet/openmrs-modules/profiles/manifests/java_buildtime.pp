class profiles::java_buildtime (
  $maven3_version,
  $maven_password,
  $sonar_login_token,
){

  bamboo_agent_home::directory { '.m2': }
  ->
  bamboo_agent_home::file { '.m2/settings.xml':
    content => template('profiles/java_buildtime/settings.xml')
  }

  # install maven 3. Forcing some very specific version, the apt repos only keep the latest one
  archive { '/tmp/mvn3.zip':
    ensure => present,
    source => "http://apache.mirrors.pair.com/maven/maven-3/${maven3_version}/binaries/apache-maven-${maven3_version}-bin.zip",
    user   => 0,
    group  => 0,
    require     => Package['unzip']
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
