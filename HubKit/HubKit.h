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

#import <Foundation/Foundation.h>
#import "HKDefines.h"
#import "HKUser.h"
#import "NSArray+HKExtensions.h"
#import "NSDictionary+HKExtensions.h"

@class HKHTTPClient;

@interface HubKit : NSObject

/** Shared Instance of HubKit */
+ (instancetype)sharedInstance;

/** HTTP Client for connecting to web resources */
@property (nonatomic, strong, readonly) HKHTTPClient *httpClient;

/** Setup HubKit with the required client configuration to make authenticated requests against GitHub
 * @discussion These values are required.
 * @param clientId the unique client ID assigned to your app by GitHub
 * @param clientSecret the unique client secret assigned to your app by GitHub
 * @param scopes and array of `HKGithubAuthorizationScopes`
 */
- (void)setApplicationClientId:(NSString *)clientId
                        secret:(NSString *)clientSecret
               requestedScopes:(NSArray *)scopes;

/** Use Basic Authorization to obtain a scoped access token from the GitHub authorization API
 * @discussion This method is part of the non-web authorization flow discussed in the GitHub
 *             API documentation.
 * @param username the user's login
 * @param password the user's password
 * @param completion A single object style completion block that is sent an instance of class HKUser on completion
 */
- (void)loginWithUser:(NSString *)username
             password:(NSString *)password
           completion:(HKGenericCompletionHandler)completion;

/** Use an the access token in the keychain to get the currently authenticated user
 * @param completion A single object style completion block that is sent an instance of class HKUser on completion
 */
- (void)getCurrentUserWithCompletion:(HKObjectCompletionHandler)completion;

/** Get all repositories for the currently authenticated user
 * @param completion An array style completion block that is sent a collection of repository dictionaries
 */
- (void)getCurrentUserReposWithCompletion:(HKArrayCompletionHandler)completion;

/** Get all starred repositories for the currently authenticated user
 * @param completion An array style completion block that is sent a collection of repository dictionaries
 */
- (void)getCurrentUserStarredReposWithCompletion:(HKArrayCompletionHandler)completion;

/** Get the specified repository for the specified user
 * @param repositoryName the name of the reposiotry to fetch
 * @param userName the login of the repo's owner
 * @param completion An single object style completion block that is sent the repository dictionary
 */
- (void)getRepositoryWithName:(NSString *)repositoryName
                         user:(NSString *)userName
                   completion:(HKObjectCompletionHandler)completion;

@end
