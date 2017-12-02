class profiles::ssh_client {
  bamboo_agent_home::directory { '.ssh' :
    mode    => '600',
    recurse => true,
    purge   => true, # remove unmanaged files
    force   => true, # remove unmanaged subdirectories and files
    source  => 'puppet:///modules/profiles/ssh_client/dot-ssh',
  }
}