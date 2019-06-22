require_relative 'spec_helper'

describe 'node builder machine' do
  it 'should have node command' do
    expect(command('su - bamboo-agent -c \'node --version\'').stdout).to include('6.')
  end
  it 'should have bower command' do
    expect(command('su - bamboo-agent -c \'bower --version\'').stdout).to include('1.8.')
  end
  it 'should have nvm command for bamboo agent user' do
    expect(command('su - bamboo-agent -c \'nvm --help\'').stdout).to include('Node Version Manager')
  end
end
