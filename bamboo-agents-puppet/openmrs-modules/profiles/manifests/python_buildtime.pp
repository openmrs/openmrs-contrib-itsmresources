class profiles::python_buildtime {
  package { 'python-virtualenv':
    ensure  => present,
  }
}
