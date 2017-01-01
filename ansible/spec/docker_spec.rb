require_relative 'spec_helper'

describe 'docker machine' do
  it "should have docker command" do
      expect(command('docker version').stdout).to include('1.12')
  end
  it "should have docker on aufs" do
      expect(command('docker info').stdout).to include('Storage Driver: aufs')
  end
  it "should have docker-compose command" do
      expect(command('docker-compose version').stdout).to include('1.9')
  end
end
