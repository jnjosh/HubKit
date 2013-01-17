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

#import "Specta.h"
#define EXP_SHORTHAND
#import "Expecta.h"
#import <OCMock/OCMock.h>
#import "HubKit+HKExtensions.h"
#import "HKFixtures.h"

SpecBegin(HubKitRepository)

describe(@"HubKit Repository", ^{
   
    context(@"when getting the authenticated user's repository", ^{
       
        __block id client = nil;
        
        beforeEach(^{
            client = [OCMockObject mockForClass:[HKHTTPClient class]];
            [[client stub] defaultValueForHeader:OCMOCK_ANY];
            [[client stub] setDefaultHeader:OCMOCK_ANY value:OCMOCK_ANY];
        });
		
        it(@"should send request for user's repositories to user/repos", ^{
            [[client expect] getPath:[OCMArg checkWithBlock:^BOOL(id argument) {
                return [argument isEqualToString:@"user/repos"];
            }] parameters:OCMOCK_ANY success:OCMOCK_ANY failure:OCMOCK_ANY];
            
            HubKit *github = [HKFixtures hubKit];
            [github setHttpClient:client];
            
            [github getAuthenticatedUserReposWithCompletion:nil];
            [client verify];
        });
        
        pending(@"should get a collection of dictionaries when requesting user's repos");
        
        it(@"should send request for starred repositories", ^{
            [[client expect] getPath:[OCMArg checkWithBlock:^BOOL(id argument) {
                return [argument isEqualToString:@"user/starred"];
            }] parameters:OCMOCK_ANY success:OCMOCK_ANY failure:OCMOCK_ANY];
            
            HubKit *github = [HKFixtures hubKit];
            [github setHttpClient:client];
            
            [github getAuthenticatedUserStarredReposWithCompletion:nil];
            [client verify];
        });
        
        pending(@"should get a collection of dictionaries when requesting user's starred repos");
        
        it(@"should send request for named repositories properly", ^{
            NSString *sampleRepoName = @"HubKit";
            NSString *sampleUserName = @"jnjosh";
            
            [[client expect] getPath:[OCMArg checkWithBlock:^BOOL(id argument) {
                NSString *expectedPath = [NSString stringWithFormat:@"repos/%@/%@", sampleUserName, sampleRepoName];
                return [argument isEqualToString:expectedPath];
            }] parameters:OCMOCK_ANY success:OCMOCK_ANY failure:OCMOCK_ANY];
            
            HubKit *github = [HKFixtures hubKit];
            [github setHttpClient:client];
            
            [github getRepositoryWithName:sampleRepoName user:sampleUserName completion:nil];
            [client verify];
        });
        
        pending(@"should get a single dictionary when requesting a specific repo");

    });
    
});

SpecEnd