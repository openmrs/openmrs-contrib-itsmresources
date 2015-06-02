#!/usr/bin/env ruby

forge "https://forgeapi.puppetlabs.com"

mod 'puppetlabs/apt', '1.8.0'
mod 'puppetlabs/stdlib', '4.4.0'
mod 'puppetlabs/java', '1.2.0'
mod 'kayak/r9util', '0.0.4'
mod 'maestrodev/wget', '1.5.6'
mod 'garethr/docker', '4.0.2'

# this module is a fork of kayak-bamboo_agent
# to handle one user per bamboo agent
# https://github.com/kayakco/puppet-bamboo_agent/pull/4
mod 'puppet/bamboo_agent',
  :git => 'https://github.com/cintiadr/puppet-bamboo_agent',
  :ref => '01a38f4a5c943098d8b17bd946f7009a8ed481a9'

