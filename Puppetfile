#!/usr/bin/env ruby

forge "https://forgeapi.puppetlabs.com"

mod 'puppetlabs/apt'
mod 'puppetlabs/stdlib'
mod 'puppetlabs/java'
mod 'kayak/r9util'
mod 'maestrodev/wget'

# this module is a fork of kayak-bamboo_agent
# to handle one user per bamboo agent
# https://github.com/kayakco/puppet-bamboo_agent/pull/4
mod 'puppet/bamboo_agent',
  :git => 'https://github.com/cintiadr/puppet-bamboo_agent',
  :ref => 'a6896831686ab67fcb115f81f85bd38e8b050c56'

