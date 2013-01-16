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

typedef void (^HKHTTPClientSuccess)(AFJSONRequestOperation *operation, id responseObject);
typedef void (^HKHTTPClientFailure)(AFJSONRequestOperation *operation, NSError *error);

@class HKRepo;

@interface HKHTTPClient : AFHTTPClient

/** Application Client ID for authorizing against Github
 * @see https://github.com/settings/applications
 */
@property (nonatomic, copy) NSString *authorizationClientId;

/** Application Client Secret for authorizing against Github
 * @see https://github.com/settings/applications
 */
@property (nonatomic, copy) NSString *authorizationClientSecret;

/** Authorization Scope specifying the access you are asking for on the user's github account
 * @see http://developer.github.com/v3/oauth/#scopes
 */
@property (nonatomic, strong) NSArray *authorizationScopes;

+ (instancetype)sharedClient;

- (void)logInUserWithUsername:(NSString *)username
                     password:(NSString *)password
                      success:(HKHTTPClientSuccess)success
                      failure:(HKHTTPClientFailure)failure;

- (void)logInUserWithAccessToken:(NSString *)accessToken
                         success:(HKHTTPClientSuccess)success
                         failure:(HKHTTPClientFailure)failure;

- (void)getRepoWithName:(NSString *)name
                   user:(NSString *)user
                success:(HKHTTPClientSuccess)success
                failure:(HKHTTPClientFailure)failure;

- (void)getStarredReposWithSuccess:(HKHTTPClientSuccess)success
                           failure:(HKHTTPClientFailure)failure;


- (void)getUserReposWithSuccess:(HKHTTPClientSuccess)success
                        failure:(HKHTTPClientFailure)failure;

- (void)getIssuesForRepo:(HKRepo *)repo
                 success:(HKHTTPClientSuccess)success
                 failure:(HKHTTPClientFailure)failure;

@end
