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

#import "HubKit.h"
#import "HKHTTPClient.h"
#import "HKKeychain.h"
#import "HKAuthorization.h"

@interface HubKit ()

@property (nonatomic, strong, readwrite) HKHTTPClient *httpClient;

@end

@implementation HubKit {}

#pragma mark - Properties

- (HKHTTPClient *)httpClient
{
    if (! _httpClient) {
        _httpClient = [[HKHTTPClient alloc] init];
    }
    return _httpClient;
}

#pragma mark - Authorization

- (void)setAuthorizationClientId:(NSString *)clientId
                          secret:(NSString *)clientSecret
                 requestedScopes:(NSArray *)scopes
{
    HKAuthorization *authorization = [HKAuthorization new];
    [authorization setClientId:clientId];
    [authorization setClientSecret:clientSecret];
    [authorization setScopes:scopes];
    [self.httpClient setAuthorization:authorization];
}

- (void)setAuthorizationHeaderWithToken:(NSString *)token
{
    [self.httpClient setDefaultHeader:@"Authorization" value:[NSString stringWithFormat:@"bearer %@", token]];
}

- (void)verifyAuthorizationHeader;
{
    if (! [self.httpClient defaultValueForHeader:@"Authorization"]) {
        NSString *token = [HKKeychain authenticationTokenForAccount:kHKHubKitKeychainDefaultAccount];
        [self setAuthorizationHeaderWithToken:token];
    }
}

#pragma mark - GitHub API Authorization

- (void)loginWithUser:(NSString *)username
             password:(NSString *)password
           completion:(HKGenericCompletionHandler)completion
{
    [self.httpClient setAuthorizationHeaderWithUsername:username password:password];
    [self.httpClient postPath:@"authorizations" parameters:[self.httpClient.authorization dictionaryRepresentation] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *responseDict = (NSDictionary *)responseObject;
        NSString *token = responseDict[@"token"];
        
        if (token) {
            [HKKeychain storeAuthenticationToken:token userAccount:username];
            [self setAuthorizationHeaderWithToken:token];
            [self getAuthenticatedUserWithToken:token completion:^(id object, NSError *error) {
                if (completion) {
                    completion(error);
                }
            }];
        } else {
            NSError *error = [NSError errorWithDomain:kHKHubKitErrorDomain
                                                 code:100
                                             userInfo:@{ NSLocalizedDescriptionKey : @"Could not find token" }];
            if (completion) {
                completion(error);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (completion) {
            completion(error);
        }
    }];
    [self.httpClient clearAuthorizationHeader];
}

#pragma mark - GitHub API User

- (void)getAuthenticatedUserWithToken:(NSString *)token
                           completion:(HKObjectCompletionHandler)completion
{
    [self setAuthorizationHeaderWithToken:token];
    [self.httpClient getPath:@"user" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        HKUser *user = [HKUser userWithDictionaryRepresentation:responseObject];
        user.accessToken = token;
        [HKUser setCurrentUser:user];

        if (completion) {
            completion(user, nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (completion) {   
            completion(nil, error);
        }
    }];
}

- (void)getAuthenticatedUserWithCompletion:(HKObjectCompletionHandler)completion
{
    NSString *token = [HKKeychain authenticationTokenForAccount:kHKHubKitKeychainDefaultAccount];
    [self getAuthenticatedUserWithToken:token completion:completion];
}

#pragma mark - GitHub API Repos

- (void)getAuthenticatedUserReposWithCompletion:(HKArrayCompletionHandler)completion
{
    [self verifyAuthorizationHeader];
    [self.httpClient getPath:@"user/repos" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
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
    NSString *repoPath = [NSString stringWithFormat:@"repos/%@/%@", userName, repositoryName];
    [self.httpClient getPath:repoPath parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
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
    [self.httpClient getPath:@"user/starred" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (completion) {
            completion(responseObject, nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (completion) {
            completion(nil, error);
        }
    }];
}

#pragma mark - TODO

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
