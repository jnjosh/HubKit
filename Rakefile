require_relative 'Scripts/RakeHelper.rb'
require "xcoder"

task :default => 'tools:setup'
task :test => 'test:all'

namespace :tools do
  
  desc "Setup For Development"
  task :setup do
    puts 'Cloning Git Submodules...'.cyan
    `git submodule update --init --recursive`
    puts 'Copying example RPGitHubAPIKeys into place...'.cyan
    `cp OctoKit/OKGitHubAPIKeysExample.h OctoKit/OKGitHubAPIKeys.h`
    `cp OctoKit/OKGitHubAPIKeysExample.m OctoKit/OKGitHubAPIKeys.m`

    puts 'Done! You\'re ready to get started!'.green  
  end

end

namespace :test do

  desc "iOS Unit Tests"
  task :ios do
    puts 'Running Unit Tests for iOS'.green
    config = Xcode.project("OctoKit-iOS-Sample").target("OctoKit-iOS-UnitTests").config(:Debug)
    builder = config.builder
    builder.clean
    builder.test(:sdk => 'iphonesimulator')
  end

  desc "All Unit Tests"
  task :all => [:ios] do
    puts 'Completed running all unit tests'.green    
  end

end