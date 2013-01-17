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

typedef void(^HKGenericCompletionHandler)(NSError *error);
typedef void(^HKObjectCompletionHandler)(id object, NSError *error);
typedef void(^HKArrayCompletionHandler)(NSArray *collection, NSError *error);

@class AFHTTPClient;

@interface HubKit : NSObject

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

/** HTTP Client for connecting to web resources */
@property (nonatomic, strong, readonly) AFHTTPClient *httpClient;

/** Use Basic Authorization to obtain a scoped access token from the GitHub authorization API
 * @discussion This method is part of the non-web authorization flow discussed in the GitHub
 *             API documentation.
 * @endpoint /authorizations
 */
- (void)loginWithUser:(NSString *)username
             password:(NSString *)password
           completion:(HKGenericCompletionHandler)completion;

/** Use an access token to get the currently authenticated user
 * @param token The token retrieved from loginWithUser:password:completion:
 * @param completion A single object style completion block that is sent an instance of class HKUser on completion
 * @endpoint /user
 */
- (void)getAuthenticatedUserWithToken:(NSString *)token
                           completion:(HKObjectCompletionHandler)completion;

/** Use an the access token in the keychain to get the currently authenticated user
 * @param completion A single object style completion block that is sent an instance of class HKUser on completion
 * @endpoint /user
 */
- (void)getAuthenticatedUserWithCompletion:(HKObjectCompletionHandler)completion;

/** Get all repositories for the currently authenticated user
 * @param completion An array style completion block that is sent a collection of repository dictionaries
 * @endpoint /user/repos
 */
- (void)getAuthenticatedUserReposWithCompletion:(HKArrayCompletionHandler)completion;

@end
