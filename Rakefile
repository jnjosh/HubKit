class String
  def self.colorize(text, color_code)
    "\e[#{color_code}m#{text}\e[0m"
  end

  def cyan
    self.class.colorize(self, 36)
  end

  def green
    self.class.colorize(self, 32)
  end
end

desc 'Setup with example files'
task :setup do
  # Copy examples defines
  puts 'Cloning Git Submodules...'.cyan
  `git submodule update --init --recursive`
  puts 'Copying example RPGitHubAPIKeys into place...'.cyan
  `cp OctoKit/OKGitHubAPIKeysExample.h OctoKit/OKGitHubAPIKeys.h`
  `cp OctoKit/OKGitHubAPIKeysExample.m OctoKit/OKGitHubAPIKeys.m`

  # Done!
  puts 'Done! You\'re ready to get started!'.green
end

# Run setup by default
task :default => :setup

