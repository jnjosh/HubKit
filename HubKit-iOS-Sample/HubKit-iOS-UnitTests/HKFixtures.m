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

#import "HKFixtures.h"
#import "HubKit.h"
#import "HKDefines.h"

@implementation HKFixtures {}

#pragma mark - HubKit Fixtures

+ (HubKit *)hubKit
{
    HubKit *github = [HubKit new];
    [github setApplicationClientId:@"testing-id" secret:@"testing-secret" requestedScopes:@[]];
    return github;
}

+ (HubKit *)hubKitWithEmptyAuthorization
{
    HubKit *github = [HubKit new];
    [github setApplicationClientId:@"" secret:@"" requestedScopes:@[]];
    return github;
}

#pragma mark - HKHTTPClient Fixtures

+ (NSDictionary *)cannedAuthorizationResponse
{
    return @{ @"token" : @"abc123", @"scopes" : @[ @"public_repo" ] };
}

+ (NSDictionary *)cannedUserResponse
{
    return @{ @"login" : @"USER" };
}

+ (NSDictionary *)cannedRepositoryResponse
{
    return @{ @"name" : @"REPO" };
}

+ (NSArray *)cannedRepositoryCollectionResponse
{
    return @[ [self cannedRepositoryResponse] ];
}

+ (NSError *)cannedError
{
    return [NSError errorWithDomain:kHKHubKitErrorDomain code:101 userInfo:@{ NSLocalizedDescriptionKey : @"Canned error" }];
}

@end
