# Logic for setting up a private tmp directory for the agent
# *** This type should be considered private to this module ***
define bamboo_agent::private_tmp(
  $path       = $title,
  $user,
  $group,
){

  file { $path:
    ensure => directory,
    owner  => $user,
    group  => $group,
    mode   => '0755', # Only used by Bamboo user, no need for sticky
  }
  
	$package_name = $osfamily ? {
	    'debian' => 'tmpreaper',
	    default  => 'tmpwatch',
	}
  
  unless defined(Package[$package_name]){
    package { $package_name: 
      ensure => installed 
    }
  }

  cron { "${path}-tmp-cleanup":
    minute  => 0,
    hour    => 4,
    command => "/usr/sbin/${package_name} 1d ${path} -a -T 120",
    require => [Package[$package_name],
                File[$path]],
  }
}
