require_relative 'spec_helper'

describe 'node builder machine' do
  it 'should have node command' do
    expect(command('node --version').stdout).to include('6.14.4')
  end
  it 'should have npm installed' do
    expect(command('npm --version').stdout).to include('5.5.1')
  end
  it 'should have bower command' do
    expect(command('bower --version').stdout).to include('1.8.4')
  end
  it 'should have nvm command' do
    expect(command('nvm --help').stdout).to include('Node Version Manager')
  end
end
