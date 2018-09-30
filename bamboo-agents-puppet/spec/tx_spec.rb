require_relative 'spec_helper'

describe 'transifex client' do
  it 'should have java 8 command' do
    expect(command('tx --version').stdout).to include('0.12')
  end
end
