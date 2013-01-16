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

#import "HKHTTPClient.h"
#import "HKDefines.h"
#import "HKKeychain.h"

@interface HKHTTPClient ()

@end

@implementation HKHTTPClient {}

#pragma mark - Shared Instance

+ (instancetype)sharedClient
{
    static HKHTTPClient *sharedClient;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedClient = [[HKHTTPClient alloc] init];
    });
    
    return sharedClient;
}

#pragma mark - Life Cycle

- (id)init
{
    NSURL *base = [NSURL URLWithString:kHKGithubAPIBaseURLString];
    
    if (self = [super initWithBaseURL:base]) {
        [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
        [self setDefaultHeader:@"Accept" value:@"application/json"];
        [self setParameterEncoding:AFJSONParameterEncoding];
    }
    return self;
}

#pragma mark - Authorization

- (void)setAuthorizationHeaderWithToken:(NSString *)token
{
    [self setDefaultHeader:@"Authorization" value:[NSString stringWithFormat:@"bearer %@", token]];
}

- (void)logInUserWithUsername:(NSString *)username
                     password:(NSString *)password
                      success:(HKHTTPClientSuccess)success
                      failure:(HKHTTPClientFailure)failure
{
    NSString *authPath = @"authorizations";
    NSDictionary *params = @{
        @"client_id"     : self.authorizationClientId,
        @"client_secret" : self.authorizationClientSecret,
        @"scopes"        : self.authorizationScopes
    };
    
    [self setAuthorizationHeaderWithUsername:username password:password];
    [self postPath:authPath parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *responseDict = (NSDictionary *)responseObject;

        NSString *token = responseDict[@"token"];
        if ([HKKeychain storeAuthenticationToken:token userAccount:username]) {
            [self setAuthorizationHeaderWithToken:token];
        }
        [self logInUserWithAccessToken:token success:success failure:failure];

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure((AFJSONRequestOperation *)operation, error);
        }
    }];
    [self clearAuthorizationHeader];
}

- (void)logInUserWithAccessToken:(NSString *)accessToken success:(HKHTTPClientSuccess)success failure:(HKHTTPClientFailure)failure
{
    [self setAuthorizationHeaderWithToken:accessToken];
    [self getPath:@"user" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        HKUser *user = [HKUser objectWithDictionary:responseObject];
//        user.accessToken = accessToken;
//        [HKUser setCurrentUser:user];
//        [user save];
        
        NSLog(@"%@", responseObject);
        
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

- (void)getRepoWithName:(NSString *)name user:(NSString *)user success:(HKHTTPClientSuccess)success failure:(HKHTTPClientFailure)failure
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

- (void)getStarredReposWithSuccess:(HKHTTPClientSuccess)success failure:(HKHTTPClientFailure)failure
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


- (void)getUserReposWithSuccess:(HKHTTPClientSuccess)success failure:(HKHTTPClientFailure)failure
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

//- (void)getIssuesForRepo:(HKRepo *)repo success:(HKHTTPClientSuccess)success failure:(HKHTTPClientFailure)failure
//{
//    NSString *path = [NSString stringWithFormat:@"/repos/%@/%@/issues", repo.owner.login, repo.name];
//    
//    [self getPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        if (success) {
//            success((AFJSONRequestOperation *)operation, responseObject);
//        }
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        if (failure) {
//            failure((AFJSONRequestOperation *)operation, error);
//        }
//    }];
//}

@end
