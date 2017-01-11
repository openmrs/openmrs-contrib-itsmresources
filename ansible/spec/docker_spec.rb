require_relative 'spec_helper'

describe 'docker machine' do
  it 'should have docker command' do
    expect(command('docker version').stdout).to include('1.12.5')
  end
  it 'should have docker on overlay2' do
    expect(command('docker info').stdout).to include('Storage Driver: overlay2')
  end
  it 'should have docker-compose command' do
    expect(command('docker-compose version').stdout).to include('1.9.0')
  end
  it 'should have demo running' do
    expect(command('cd /root/demo && docker-compose ps').stdout).to include('Up')
  end
end
