require_relative 'spec_helper'

describe 'java builder machine' do
  it 'should have java 8 command' do
    expect(command('java -version').stderr).to include('1.8.0')
  end
  it 'should have java 7 installed' do
    expect(command('/usr/lib/jvm/java-1.7.0-openjdk-amd64/jre/bin/java -version').stderr).to include('1.7.0')
  end
  it 'should have mvn command' do
    expect(command('mvn3 --version').stdout).to include('3.3.9')
  end
  it 'should have mvn creds' do
    expect(command('fgrep "<password>" /home/bamboo-agent/.m2/settings.xml | uniq -c').stdout).to include('4       <password>amazingMavenTestPassword</password>')
  end
end
