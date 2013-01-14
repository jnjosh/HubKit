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
