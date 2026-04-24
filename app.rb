#!/usr/bin/env -S BUNDLE_AUTO_INSTALL=1 bundle exec ruby

Dir.chdir(__dir__) do
  Bundler.require
end

class App < Thor
  desc :hello, 'Hello'
  def hello
    puts 'Hello, World!'
  end
end

App.start
