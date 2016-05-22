class profiles::node_buildtime {
  apt::ppa { 'ppa:chris-lea/node.js' : }  
  -> 
  package { 'nodejs':
    ensure => latest,
  }  
  ->   
  exec { 'install bower':
    command => "/usr/bin/npm install bower -g",
    creates => "/usr/bin/bower",
  }
}