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

@interface OKHTTPClient : AFHTTPClient

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

@end
