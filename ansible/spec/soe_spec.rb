require_relative 'spec_helper'

describe 'soe machine' do
  it 'should be in UTC' do
    expect(command('date +"%Z"').stdout).to include('UTC')
  end
end
