//
//  RPGitHubAPIClient.m
//  Repos
//
//  Created by Rhys Powell on 10/12/12.
//  Copyright (c) 2012 Rhys Powell. All rights reserved.
//

#import "OKHTTPClient.h"
#import "OKGitHubAPIKeys.h"
#import "SSKeychain.h"
#import "OKUser.h"

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
        @"client_id"     : kRPGtHubClientID,
        @"client_secret" : kRPGtHubClientSecret,
        @"scopes"        : @[@"user", @"repo"]
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

@end
