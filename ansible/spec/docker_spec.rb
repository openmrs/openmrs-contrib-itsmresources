require_relative 'spec_helper'

describe 'docker machine' do
  it "should have docker command" do
      expect(command('docker version').stdout).to include('1.12')
  end
end
