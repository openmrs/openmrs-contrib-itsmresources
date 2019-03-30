require_relative 'spec_helper'

describe 'soe machine' do
  it 'should be in UTC' do
    expect(command('date +"%Z"').stdout).to include('UTC')
  end

  it 'should run logrotate' do
    expect(command('/usr/sbin/logrotate -d /etc/logrotate.d/test').stderr).to include('considering log /var/log/cloud-init-output.log')
  end
end
