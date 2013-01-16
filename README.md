# HubKit

*A GitHub API wrapper from [rpwll](http://github.com/rpwll) and [jnjosh](http://github.com/jnjosh).*

HubKit is a GitHub API client written in Objective-C, intended for use on iOS. It provides a native wrapper around the GitHub API based on [AFNetworking][afn] as well as offline data persistence using Core Data.

## Setting up for Develompent / Contributing

HubKit uses Ruby's Rakefile to perform command line setup of the project and therefore requires Ruby. If you don't already have Bundler, install it via RubyGems:

    gem install bundler

Once you have bundler installed, you can continue to run the tools to setup your development environment:

Clone the repository from Github:
    
    https://github.com/HubKit/HubKit.git

Install all the gems required.

    bundle install

Install all submodules and prepare for development:

    rake setup

### Be sure to open the project from the workspace file: OctoKit-Sample.xcworkspace

Additional Rake task:

    rake test:all     # All Unit Tests
    rake test:ios     # iOS Unit Tests
    rake tools:setup  # Setup For Development

## Testing

Testing can be performed in Xcode using the ⌘U keyboard shortcut from within Xcode or using the `rake test` script from the project directory

## Setting up OctoKit

First you're going to need AFNetworking, so visit [their repo's page][afn] and follow the setup instructions.

With that done, you'll need to clone HubKit into your project's directory, I recommend using git submodules for this, keeping the code in a *Vendor* directory:

```
$ mkdir Vendor
$ git submodule add git://github.com/HubKit/HubKit.git Vendor/HubKit
```

With the repository cloned, `cd` into HubKit's directory and run the included Rakefile to setup dummy API key files:

```
$ cd Vendor/HubKit
$ rake
```

**Note:** These next few steps are a little convoluted, we're working to improve HubKit's setup process.

With those files generated, you can add OctoKit to your project. You'll want to add every file in the *HubKit* directory to your project **except** for `HKGitHubAPIKeysExample.h` and `HKGitHubAPIKeysExample.m`. Also ensure that you add these files to the desired build target.

Finally, you'll need to open `HubKit.xcdatamodeld` in Xcode, open the File inspector (⌥⌘1) and under *Target Membership*, check your project's build target.

With that all done, you should be ready to use HubKit.

[afn]: https://github.com/AFNetworking/AFNetworking
