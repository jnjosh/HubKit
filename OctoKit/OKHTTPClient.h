//
//  RPGitHubAPIClient.h
//  Repos
//
//  Created by Rhys Powell on 10/12/12.
//  Copyright (c) 2012 Rhys Powell. All rights reserved.
//

#import "AFNetworking.h"

typedef void (^OKHTTPClientSuccess)(AFJSONRequestOperation *operation, id responseObject);
typedef void (^OKHTTPClientFailure)(AFJSONRequestOperation *operation, NSError *error);

@class OKRepo;

@interface OKHTTPClient : AFHTTPClient

/** Authorization Scope specifying the access you are asking for on the user's github account
 */
@property (nonatomic, strong) NSArray *authorizationScopes;

+ (instancetype)sharedClient;

- (void)logInUserWithUsername:(NSString *)username
                     password:(NSString *)password
                      success:(OKHTTPClientSuccess)success
                      failure:(OKHTTPClientFailure)failure;

- (void)logInUserWithAccessToken:(NSString *)accessToken
                         success:(OKHTTPClientSuccess)success
                         failure:(OKHTTPClientFailure)failure;

- (void)getRepoWithName:(NSString *)name
                   user:(NSString *)user
                success:(OKHTTPClientSuccess)success
                failure:(OKHTTPClientFailure)failure;

- (void)getStarredReposWithSuccess:(OKHTTPClientSuccess)success
                           failure:(OKHTTPClientFailure)failure;


- (void)getUserReposWithSuccess:(OKHTTPClientSuccess)success
                        failure:(OKHTTPClientFailure)failure;

- (void)getIssuesForRepo:(OKRepo *)repo
                 success:(OKHTTPClientSuccess)success
                 failure:(OKHTTPClientFailure)failure;

@end
