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
#import "HKDefines.h"

@class HKAuthorization;

@interface HKHTTPClient : AFHTTPClient

@property (nonatomic, strong) HKAuthorization *authorization;

+ (instancetype)sharedClient;

/** Use Basic Authorization to obtain a scoped access token from the GitHub authorization API
 * @discussion This method is part of the non-web authorization flow discussed in the GitHub
 *             API documentation.
 * @see http://developer.github.com/v3/oauth/#create-a-new-authorization
 */
- (void)createAuthorizationWithUsername:(NSString *)username
                               password:(NSString *)password
                             completion:(HKObjectCompletionHandler)completion;

/** Use current token to obtain the currently authenticated user.
 * @see http://developer.github.com/v3/users/#get-the-authenticated-user
 */
- (void)getAuthenticatedUserWithCompletion:(HKObjectCompletionHandler)completion;

/** Use current token to obtain the currently authenticated user's repos 
 * @see http://developer.github.com/v3/repos/#list-your-repositories
 */
- (void)getAuthenticatedUserReposWithCompletion:(HKArrayCompletionHandler)completion;

/** Get all starred repositories for the currently authenticated user
 * @param completion An array style completion block that is sent a collection of repository dictionaries
 * @see http://developer.github.com/v3/repos/#list-all-repositories
 */
- (void)getAuthenticatedUserStarredReposWithCompletion:(HKArrayCompletionHandler)completion;

/** Get the specified repository for the specified user
 * @param completion An single object style completion block that is sent the repository dictionary
 * @see http://developer.github.com/v3/repos/#list-all-repositories
 */
- (void)getRepositoryWithName:(NSString *)repositoryName
                         user:(NSString *)userName
                   completion:(HKObjectCompletionHandler)completion;

@end
