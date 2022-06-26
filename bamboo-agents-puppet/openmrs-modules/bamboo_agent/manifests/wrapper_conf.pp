# Set individual property values in wrapper.conf
# *** This type should be considered private to this module ***
define bamboo_agent::wrapper_conf(
  $home       = $title,
  $properties = {},
  $user       ,
  $group      ,
){

  $path = "${home}/conf/wrapper.conf"

  file { $path:
    owner => $user,
    group => $group,
  }
  ->
  r9util::java_properties { $path:
    properties => $properties,
  }

}
