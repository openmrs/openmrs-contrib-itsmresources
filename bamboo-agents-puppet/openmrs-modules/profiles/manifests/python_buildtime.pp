class profiles::python_buildtime {
  package { ['python-pip', 'python-virtualenv', 'python3-pip']:
    ensure  => present,
  }
}
