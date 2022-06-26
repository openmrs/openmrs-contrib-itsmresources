class profiles::python_buildtime {
  package { ['python3-pip', 'python3-virtualenv']:
    ensure  => present,
  }
}
