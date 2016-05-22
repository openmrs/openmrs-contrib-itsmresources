class profiles::browsers {
    package { [ 'chromium-browser','firefox','xvfb' ]:
    ensure  => present,
  }
}