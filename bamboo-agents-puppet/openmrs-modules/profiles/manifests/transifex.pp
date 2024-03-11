class profiles::transifex (
  $transifex_token,
){
  exec { 'make tx dir' :
    command => "mkdir -p /opt/tx",
    cwd     => '/opt',
    creates => "/opt/tx",
  } ~>
  archive { '/tmp/tx.tar.gz':
    ensure => present,
    source => "https://github.com/transifex/cli/releases/download/1.6.5/tx-linux-amd64.tar.gz",
    user   => 0,
    group  => 0,
    require => Package['unzip']
  } ~>
  exec { 'extract tx cli' :
    command => "/usr/bin/tar xvzf /tmp/tx.tar.gz",
    cwd     => '/opt/tx',
    creates => "/opt/tx",
  } ~>
  exec { 'link tx cli' :
    command => "/usr/bin/ln -s /opt/tx/tx /usr/local/bin/tx".
    creates => "/usr/local/bin/tx",
  } ~>
  exec { 'remove tx archive' :
    command => "rm /tmp/tx.tar.gx"
  }
  bamboo_agent_home::file { '.transifexrc':
    content => template('profiles/transifex/dot-transifexrc.erb'),
  }
}
