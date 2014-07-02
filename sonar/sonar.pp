# Sonar puppet manifest for ci.openmrs.org
# REQUIRES: maestrodev-sonarqube from puppetforge

# DB settings (Set this up before running this manifest)
$jdbc = {
  url               => 'jdbc:mysql://localhost:3306/sonar?useUnicode=true&characterEncoding=utf8&rewriteBatchedStatements=true',
  username          => 'sonar',
  password          => 'gElktJf21lAo0Vf8R6JZdhoSawqf',
}

class { 'maven::maven' : } ->
class { 'sonarqube' :
  arch         => 'linux-x86-64',
  version      => '4.3.2',
  user         => 'sonar',
  group        => 'sonar',
  service      => 'sonar',
  installroot  => '/opt',
  home         => '/home/sonar-home',
  download_url => 'http://dist.sonar.codehaus.org',
  jdbc         => $jdbc,
  log_folder   => '/var/log/sonar',
  updatecenter => 'true',
  context_path  => '/sonar',
}
