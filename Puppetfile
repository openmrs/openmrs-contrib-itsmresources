#!/usr/bin/env ruby

forge "http://forge.puppetlabs.com"

mod 'puppetlabs/apt'
mod 'puppetlabs/stdlib'
mod 'puppetlabs/java'
mod 'kayak/r9util'

# this module is a fork of kayak-bamboo_agent
# to handle one user per bamboo agent
# https://github.com/kayakco/puppet-bamboo_agent/pull/4
mod 'puppet/bamboo_agent',
  :git => 'https://github.com/cintiadr/puppet-bamboo_agent',
  :ref => '78bb29a'

