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

desc 'Setup with example files and submodules'
task :setup do
  # Update and initialize the submodules in case they forget
  puts 'Updating submodules...'.cyan
  `git submodule update --init --recursive`

  # Copy examples defines
  puts 'Copying example RPGitHubAPIKeys into place...'.cyan
  `cp OKGitHubAPIKeysExample.h OKGitHubAPIKeys.h`
  `cp OKGitHubAPIKeysExample.m OKGitHubAPIKeys.m`

  # Done!
  puts 'Done! You\'re ready to get started!'.green
end

# Run setup by default
task :default => :setup

