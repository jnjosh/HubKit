/*
 Copyright (c) 2013 Rhys Powell and Josh Johnson
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of
 this software and associated documentation files (the "Software"), to deal in
 the Software without restriction, including without limitation the rights to
 use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
 of the Software, and to permit persons to whom the Software is furnished to do
 so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
 */

#import "HubKit.h"
#import "HKUser.h"
#import "HKKeychain.h"

static HKUser *__currentUser = nil;

@implementation HKUser

@dynamic login;
@dynamic avatarURL;
@dynamic name;
@dynamic company;
@dynamic blog;
@dynamic location;
@dynamic email;
@dynamic hireable;
@dynamic bio;
@dynamic repoCount;
@dynamic gistCount;
@dynamic followerCount;
@dynamic followingCount;
@dynamic type;
@synthesize token;

+ (NSString *)entityName
{
    return @"User";
}

+ (instancetype)currentUser
{
    if (!__currentUser) {
        NSNumber *remoteID = [[NSUserDefaults standardUserDefaults] objectForKey:kHKCurrentUserIDKey];
        if (remoteID) {
            __currentUser = [HKUser objectWithRemoteID:remoteID];
            __currentUser.token = [HKKeychain authenticationTokenForAccount:__currentUser.login];
        }
    }
    
    return __currentUser;
}

+ (void)setCurrentUser:(HKUser *)user
{
    __currentUser = user;
    [[NSUserDefaults standardUserDefaults] setObject:user.remoteID forKey:kHKCurrentUserIDKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [HKKeychain storeAuthenticationToken:user.token userAccount:user.login];
}

- (void)unpackDictionary:(NSDictionary *)dictionary
{
    [super unpackDictionary:dictionary];
    
    self.login          = [dictionary safeObjectForKey:@"login"];
    self.avatarURL      = [dictionary safeObjectForKey:@"avatar_url"];
    self.name           = [dictionary safeObjectForKey:@"url"];
    self.company        = [dictionary safeObjectForKey:@"company"];
    self.blog           = [dictionary safeObjectForKey:@"blog"];
    self.location       = [dictionary safeObjectForKey:@"location"];
    self.email          = [dictionary safeObjectForKey:@"email"];
    self.hireable       = [dictionary safeObjectForKey:@"hireable"];
    self.bio            = [dictionary safeObjectForKey:@"bio"];
    self.repoCount      = [dictionary safeObjectForKey:@"public_repos"];
    self.gistCount      = [dictionary safeObjectForKey:@"public_gists"];
    self.followerCount  = [dictionary safeObjectForKey:@"followers"];
    self.followingCount = [dictionary safeObjectForKey:@"following"];
    self.type           = [dictionary safeObjectForKey:@"type"];
    
    NSLog(@"Created user: %@", self);
}

@end
