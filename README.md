# HubKit

*A GitHub API wrapper from [rpwll](http://github.com/rpwll) and [jnjosh](http://github.com/jnjosh).*

HubKit is a GitHub API client written in Objective-C, intended for use on iOS. It provides a native wrapper around the GitHub API based on [AFNetworking][afn].

## Setting up for Development / Contributing

HubKit uses several RubyGems an Rakefiles to perform command line setup of the project, automated unit testing, and tools for building and installing documentation. To run these scripts, you'll need to have several tools installed. 

### I've heard of Ruby, but haven't used it. How do I get these tools setup? ###

If you identify yourself as a Rubyist or already have Ruby configured feel free to skip ahead to the [next section](#rubyist).

Luckily, you already have Ruby installed on your Mac.

You should also have [Homebrew](http://mxcl.github.com/homebrew) installed. It is good for you and we'll be using it to install some tools later. It is a package manager for OS X and will help get you setup. To install run the following command in terminal:

    $> ruby -e "$(curl -fsSkL raw.github.com/mxcl/homebrew/go)"

You will now be able to install and manage many great packages. You'll have a good time. Check out the [Homebrew website](http://mxcl.github.com/homebrew/) for more.

<a name="#rubyist" /a>
### Configure for Contributing, Testing, or Development

If you don't already have Bundler, install it via RubyGems:

    $> gem install bundler

Bundler will allow make sure you have all the required libraries used so you don't have to. Once you have bundler installed, you can continue to run the tools to setup your development environment.

First, you need the code! Clone the HubKit repository from Github:
    
    $> git clone https://github.com/HubKit/HubKit.git

Next, tell bundler to install all the gems required. If you are curious which we are using, check out `Gemfile` in the project directory. Paste this in your Terminal:

    $> bundle install

Next, we'll use the `rake` to setup you project for Xcode. This will install all the required git submodules, configure the testing environment and more. To begin, paste this in your Terminal:

    $> rake setup

Finally, to create and install documentation you'll need the appledoc tool installed. To install, run this command:

    $> brew install appledoc

__Congrats! You are all ready to go. A couple things to keep in mind:__

Be sure to open the project from the workspace file: 

    HubKit.xcworkspace

Rake isn't there just to setup, you can use it to do more. Here are all the additional Rake tasks:

    rake docs:generate  # Generate and install Xcode documentation
    rake test:all     # All Unit Tests
    rake test:ios     # iOS Unit Tests
    rake tools:setup  # Setup For Development

## Testing

Testing can be performed in Xcode using the ⌘U keyboard shortcut from within Xcode or using the `rake test` script from the project directory

## Setting up HubKit for your project

You'll need to have [AFNetworking](http://afnetworking.com) installed in your project. To set that up, you can add it as a submodule from the [github repository][afn] or by using [CocoaPods](http://cocoapods.org).

### Setting up via Git Submodule

Clone the project as a submodule with git. The following command will install HubKit in the `Vendor/HubKit` directory.

    $> git submodule add git://github.com/HubKit/HubKit.git Vendor/HubKit

After cloning the submodule, you'll need to add HubKit's project files to your Xcode project. You can find these files under the 'HubKit' directory.

With that all done, you should be ready to use HubKit, see the [usage](#usage) section to see how to use it.

### Setting up via CocoaPods

TODO - We are still in development so adding to CocoaPods right now doesn't make sense. 

## Usage

Create an instance of HubKit, setup the required fields for authorization:

```objective-c
HubKit *github = [HubKit new];
[github setApplicationClientId:<# Client ID #> secret:<# Client Secret #> requestedScopes:@[ 
    HKGithubAuthorizationScopes.user, 
    HKGithubAuthorizationScopes.repo
]];
```

When logging in, send the `-[HubKit loginWithUser:password:completion:]` message to the github client:

```objective-c
[github loginWithUser:@"user" password:@"password" completion:^(NSError *error) {
    // Logged in and ready to ask for GitHub resources. The error argument is sent if something goes wrong, otherwise it is nil.
}];
```

Now that you are logged in, you can access resources on GitHub:

```objective-c
[github getCurrentUserReposWithCompletion:^(NSArray *collection, NSError *error) {
    // Access the repos via collections
}];
```

## Contact

- [Rhys Powell](http://github.com/rpwll)
- [Josh Johnson](http://github.com/jnjosh)

## License

HubKit is MIT Licensed. See the LICENSE file for more information.

[afn]: https://github.com/AFNetworking/AFNetworking
