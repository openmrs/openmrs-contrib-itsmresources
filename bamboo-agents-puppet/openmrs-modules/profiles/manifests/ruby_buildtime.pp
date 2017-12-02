class profiles::ruby_buildtime (
  $grails_version,
){
   wget::fetch { 'fetch grails' :
    source  => "http://dist.springframework.org.s3.amazonaws.com/release/GRAILS/grails-${grails_version}.zip",
    destination => "/opt/grails-${grails_version}.zip",
    timeout     => 1800,
    require => Package['unzip']
  }
  ->
  exec { 'extract grails' :
    command => "/usr/bin/unzip -o grails-${grails_version}.zip",
    cwd     => '/opt',
    creates => "/opt/grails-${grails_version}",
  }
  ->
  file { 'link grails' :
    path   => '/opt/grails',
    ensure => 'link',
    target => "/opt/grails-${grails_version}",
  }
}
