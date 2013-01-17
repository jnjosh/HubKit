require_relative 'Scripts/RakeHelper.rb'
require "xcoder"

task :default => :setup
task :setup => 'tools:setup'
task :test => 'test:all'

namespace :tools do

  desc "Setup For Development"
  task :setup do
    puts '* Cloning Git Submodules...'.cyan
    `git submodule update --init --recursive`

    puts '* Copying example HKGitHubAPIKeys into place...'.cyan
    `cp HubKit/HKGitHubAPIKeysExample.h HubKit/HKGitHubAPIKeys.h`
    `cp HubKit/HKGitHubAPIKeysExample.m HubKit/HKGitHubAPIKeys.m`

    puts '* Configuring Testing Libraries (Specta/Expecta)'.cyan
    `cd \"Vendor/Specta\" ; rake`
    `cd \"Vendor/Expecta\" ; rake`

    puts
    puts 'Done! You\'re ready to get started!'.green
  end

end

namespace :test do

  desc "iOS Unit Tests"
  task :ios do
    puts 'Running Unit Tests for iOS'.cyan
    config = Xcode.project("HubKit-iOS-Sample").target("HubKit-iOS-UnitTests").config(:Debug)
    builder = config.builder
    builder.clean
    builder.test(:sdk => 'iphonesimulator')
  end

  desc "All Unit Tests"
  task :all => [:ios] do
    puts 'Completed running all unit tests'.green
  end

end

namespace :docs do
  desc "Generate and install Xcode documentation"
  task :generate do
    puts '* Generating documentation'.cyan
      `appledoc --project-name HubKit -v 0.1 --project-company HubKit -o ./Documentation -i -m -s ./HubKit ./HubKit`
  end
end