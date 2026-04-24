#!/usr/bin/env ruby

require 'bundler'

ENV['BUNDLE_AUTO_INSTALL'] = '1'

Dir.chdir(__dir__) do
  Bundler.auto_install
  Bundler.require
end

class App < Thor
  desc :hello, 'Hello'
  def hello
    puts 'Hello, World!'
  end
end

App.start
