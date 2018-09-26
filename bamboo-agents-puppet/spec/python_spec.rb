require_relative 'spec_helper'

describe 'python builder machine' do
  it 'should have python command' do
    expect(command('python --version').stderr).to include('2.7.')
  end
  it 'should have pip installed' do
    expect(command('pip --version').stdout).to include('8.1.1')
  end
end
