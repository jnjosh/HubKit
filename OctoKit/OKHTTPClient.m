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

#import "OKHTTPClient.h"
#import "OKGitHubAPIKeys.h"
#import "SSKeychain.h"
#import "OKUser.h"
#import "OKRepo.h"
#import "OKDefines.h"

@implementation OKHTTPClient

+ (instancetype)sharedClient
{
    static OKHTTPClient *sharedClient;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedClient = [[OKHTTPClient alloc] init];
    });
    
    return sharedClient;
}

- (id)init
{
    NSURL *base = [NSURL URLWithString:@"https://api.github.com/"];
    
    if (self = [super initWithBaseURL:base]) {
        // Use JSON
        [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
        [self setDefaultHeader:@"Accept" value:@"application/json"];
        [self setParameterEncoding:AFJSONParameterEncoding];
        [self setAuthorizationHeaderWithToken:[[OKUser currentUser] accessToken]];
		[self setAuthorizationScopes:@[OKGithubAuthorizationScopes.user, OKGithubAuthorizationScopes.repo]];
    }
    
    return self;
}

- (void)setAuthorizationHeaderWithToken:(NSString *)token
{
    [self setDefaultHeader:@"Authorization" value:[NSString stringWithFormat:@"bearer %@", token]];
}

- (void)logInUserWithUsername:(NSString *)username
                     password:(NSString *)password
                      success:(OKHTTPClientSuccess)success
                      failure:(OKHTTPClientFailure)failure
{
    NSString *authPath = @"authorizations";
    NSDictionary *params = @{
        @"client_id"     : kOKGtHubClientID,
        @"client_secret" : kOKGtHubClientSecret,
        @"scopes"        : self.authorizationScopes
    };
    
    [self setAuthorizationHeaderWithUsername:username password:password];
    [self postPath:authPath parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *responseDict = (NSDictionary *)responseObject;
        if ([SSKeychain setPassword:responseDict[@"token"] forService:kOKKeychainServiceName account:@"GitHub"]) {
            NSLog(@"Saved token %@", responseDict[@"token"]);
            [self setAuthorizationHeaderWithToken:responseDict[@"token"]];
        }
        
        if (success) {
            success((AFJSONRequestOperation *)operation, responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure((AFJSONRequestOperation *)operation, error);
        }
    }];
    [self clearAuthorizationHeader];
}

- (void)logInUserWithAccessToken:(NSString *)accessToken success:(OKHTTPClientSuccess)success failure:(OKHTTPClientFailure)failure
{
    [self setAuthorizationHeaderWithToken:accessToken];
    [self getPath:@"user" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        OKUser *user = [OKUser objectWithDictionary:responseObject];
        user.accessToken = accessToken;
        [OKUser setCurrentUser:user];
        [user save];
        
        if (success) {
            success((AFJSONRequestOperation *)operation, responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure((AFJSONRequestOperation *)operation, error);
        }
    }];
}

#pragma mark - Repos

- (void)getRepoWithName:(NSString *)name user:(NSString *)user success:(OKHTTPClientSuccess)success failure:(OKHTTPClientFailure)failure
{
    NSString *repoPath = [NSString stringWithFormat:@"/repos/%@/%@", user, name];
    [self getPath:repoPath parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success((AFJSONRequestOperation *)operation, responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure((AFJSONRequestOperation *)operation, error);
        }
    }];
}

- (void)getStarredReposWithSuccess:(OKHTTPClientSuccess)success failure:(OKHTTPClientFailure)failure
{
    [self getPath:@"/user/starred" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success((AFJSONRequestOperation *)operation, responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure((AFJSONRequestOperation *)operation, error);
        }
    }];
}


- (void)getUserReposWithSuccess:(OKHTTPClientSuccess)success failure:(OKHTTPClientFailure)failure
{
    [self getPath:@"/user/repos" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success((AFJSONRequestOperation *)operation, responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure((AFJSONRequestOperation *)operation, error);
        }
    }];
}

- (void)getIssuesForRepo:(OKRepo *)repo success:(OKHTTPClientSuccess)success failure:(OKHTTPClientFailure)failure
{
    NSString *path = [NSString stringWithFormat:@"/repos/%@/%@/issues", repo.owner.login, repo.name];
    
    [self getPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success((AFJSONRequestOperation *)operation, responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure((AFJSONRequestOperation *)operation, error);
        }
    }];
}

@end
