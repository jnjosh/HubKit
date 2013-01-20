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
#import "HKKeychain.h"
#import "HKAuthorization.h"

@implementation HKHTTPClient {}

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

#pragma mark - Headers

- (void)setAuthorizationHeaderWithToken:(NSString *)token
{
    [self setDefaultHeader:@"Authorization" value:[NSString stringWithFormat:@"bearer %@", token]];
}

- (void)verifyAuthorizationHeader;
{
    if (! [self defaultValueForHeader:@"Authorization"]) {
        NSString *username = [[NSUserDefaults standardUserDefaults] objectForKey:kHKCurrentUserIDKey];
        NSString *token = [HKKeychain authenticationTokenForAccount:username];
        [self setAuthorizationHeaderWithToken:token];
    }
}

#pragma mark - GitHub Authorizations API

- (void)createAuthorizationWithUsername:(NSString *)username
                               password:(NSString *)password
                             completion:(HKObjectCompletionHandler)completion
{
    [self setAuthorizationHeaderWithUsername:username password:password];
    [self postPath:@"authorizations" parameters:[self.authorization dictionaryRepresentation] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (completion) {
            completion(responseObject, nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (completion) {
            completion(nil, error);
        }
    }];
    [self clearAuthorizationHeader];
}

#pragma mark - GitHub User API

- (void)getAuthenticatedUserWithCompletion:(HKObjectCompletionHandler)completion
{
    [self verifyAuthorizationHeader];
    [self getPath:@"user" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (completion) {
            completion(responseObject, nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (completion) {
            completion(nil, error);
        }
    }];
}

#pragma mark - GitHub Repository API

- (void)getAuthenticatedUserReposWithCompletion:(HKArrayCompletionHandler)completion
{
    [self verifyAuthorizationHeader];
    [self getPath:@"user/repos" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (completion) {
            completion(responseObject, nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (completion) {
            completion(nil, error);
        }
    }];
}

- (void)getRepositoryWithName:(NSString *)repositoryName user:(NSString *)userName completion:(HKObjectCompletionHandler)completion
{
    [self verifyAuthorizationHeader];
    NSString *repoPath = [NSString stringWithFormat:@"repos/%@/%@", userName, repositoryName];
    [self getPath:repoPath parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (completion) {
            completion(responseObject, nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (completion) {
            completion(nil, error);
        }
    }];
}

- (void)getAuthenticatedUserStarredReposWithCompletion:(HKArrayCompletionHandler)completion
{
    [self verifyAuthorizationHeader];
    [self getPath:@"user/starred" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (completion) {
            completion(responseObject, nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (completion) {
            completion(nil, error);
        }
    }];
}

// TODO (JNJ): Hidden until we add repos model object back

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
