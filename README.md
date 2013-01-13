# OctoKit

OctoKit is a GitHub API client written in Objective-C, intended for use on iOS. It provides a native wrapper around the GitHub API based on [AFNetworking][afn] as well as offline data persistence using Core Data.

## Setting up OctoKit

First you're going to need AFNetworking, so visit [their repo's page][afn] and follow the setup instructions.

With that done, you'll need to clone OctoKit into your project's directory, I recommend using git submodules for this, keeping the code in a *Vendor* directory:

```
$ mkdir Vendor
$ git submodule add git://github.com/OctoKit/OctoKit.git Vendor/OctoKit
```

With the repository cloned, `cd` into OctoKit's directory and run the included Rakefile to setup dummy API key files:

```
$ cd Vendor/OctoKit
$ rake
```

**Note:** These next few steps are a little convoluted, we're working to improve OctoKit's setup process.

With those files generated, you can add OctoKit to your project. You'll want to add every file in the *OctoKit* directory to your project **except** for `OKGitHubAPIKeysExample.h` and `OKGitHubAPIKeysExample.m`. Also ensure that you add these files to the desired build target.

Finally, you'll need to open `OctoKit.xcdatamodeld` in Xcode, open the File inspector (⌥⌘1) and under *Target Membership*, check your project's build target.

With that all done, you should be ready to use OctoKit.

[afn]: https://github.com/AFNetworking/AFNetworking