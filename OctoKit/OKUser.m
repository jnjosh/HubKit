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

#import "OKUser.h"
#import "OKIssue.h"
#import "OKRepo.h"
#import "SSKeychain.h"
#import "OKDefines.h"
#import "NSDictionary+OKExtensions.h"

NSString *const kOKCurrentUserChangedNotificationName = @"RPCurrentUserChangedNotification";
static OKUser *__currentUser = nil;

@implementation OKUser

@dynamic avatarURL;
@dynamic blogURL;
@dynamic company;
@dynamic email;
@dynamic hireable;
@dynamic location;
@dynamic login;
@dynamic name;
@dynamic repos;
@dynamic issues;
@dynamic assignedIssues;

@synthesize accessToken = _accessToken;

+ (NSString *)entityName
{
    return @"User";
}

+ (OKUser *)currentUser
{
    if (__currentUser) {
        return __currentUser;
    }
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSNumber *userID = [userDefaults objectForKey:kOKCurrentUserIDKey];
    if (!userID) {
        return nil;
    }
    
    __currentUser = [self existingObjectWithRemoteID:userID];
    
    NSError *error = nil;
    NSString *accessToken = [SSKeychain passwordForService:kOKKeychainServiceName account:__currentUser.login error:&error];
    if (!accessToken) {
        NSLog(@"Unable to get access token: %@", error.localizedDescription);
    }
    
    __currentUser.accessToken = accessToken;
    
    return __currentUser;
}

+ (void)setCurrentUser:(OKUser *)user
{
    if (__currentUser) {
        [SSKeychain deletePasswordForService:kOKKeychainServiceName account:__currentUser.login];
    }
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    if (!user.remoteID || !user.accessToken) {
		__currentUser = nil;
		[userDefaults removeObjectForKey:kOKCurrentUserIDKey];
	} else {
        NSError *error = nil;
        [SSKeychain setPassword:user.accessToken forService:kOKKeychainServiceName account:user.login error:&error];
        if (error) {
            NSLog(@"Failed to save access token: %@", error.localizedDescription);
        }
        
        __currentUser = user;
        [userDefaults setObject:user.remoteID forKey:kOKCurrentUserIDKey];
    }
    
    [userDefaults synchronize];
    [[NSNotificationCenter defaultCenter] postNotificationName:kOKCurrentUserChangedNotificationName object:user];
}

- (void)unpackDictionary:(NSDictionary *)dictionary
{
    [super unpackDictionary:dictionary];
    
    self.avatarURL = [dictionary safeObjectForKey:@"avatar_url"];
    self.blogURL = [dictionary safeObjectForKey:@"blog"];
    self.company = [dictionary safeObjectForKey:@"company"];
    self.email = [dictionary safeObjectForKey:@"email"];
    self.hireable = [dictionary safeObjectForKey:@"hireable"];
    self.location = [dictionary safeObjectForKey:@"location"];
    self.login = [dictionary safeObjectForKey:@"login"];
    self.name = [dictionary safeObjectForKey:@"name"];
}

@end
