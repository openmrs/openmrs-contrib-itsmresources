require_relative 'spec_helper'

describe 'node builder machine' do
  it 'should have node command' do
    expect(command('node --version').stdout).to include('6.')
  end
  it 'should have npm installed' do
    expect(command('npm --version').stdout).to include('5.5.1')
  end
  it 'should have bower command' do
    expect(command('bower --version').stdout).to include('1.8.')
  end
  it 'should have nvm command for bamboo agent user' do
    expect(command('su - bamboo-agent -c \'nvm --help\'').stderr).to include('Node Version Manager')
  end
end
