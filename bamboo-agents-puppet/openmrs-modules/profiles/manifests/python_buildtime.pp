class profiles::python_buildtime {
  package { ['python-pip', 'python-virtualenv']:
    ensure  => present,
  }
}
