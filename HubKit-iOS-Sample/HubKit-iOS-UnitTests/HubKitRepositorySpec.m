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

#define EXP_SHORTHAND
#import "Specta.h"
#import "Expecta.h"
#import <OCMock/OCMock.h>
#import "HubKit+HKExtensions.h"
#import "HKFixtures.h"

SpecBegin(HubKitRepository)

describe(@"HubKit Repository", ^{
   
    context(@"when getting the authenticated user's repository", ^{
       
        __block id client = nil;
        
        beforeEach(^{
            client = [OCMockObject niceMockForClass:[HKHTTPClient class]];
        });
		
        it(@"should send request for user's repositories to user/repos", ^{
            [[client expect] getAuthenticatedUserReposWithCompletion:OCMOCK_ANY];
            
            HubKit *github = [HKFixtures hubKit];
            [github setHttpClient:client];
            
            [github getCurrentUserReposWithCompletion:nil];

            expect([^{ [client verify]; } copy]).notTo.raiseAny();
        });
        
        pending(@"should get a collection of dictionaries when requesting user's repos");
        
        it(@"should send request for starred repositories", ^{
            [[client expect] getAuthenticatedUserStarredReposWithCompletion:OCMOCK_ANY];
            
            HubKit *github = [HKFixtures hubKit];
            [github setHttpClient:client];
            
            [github getCurrentUserStarredReposWithCompletion:nil];
            
            expect([^{ [client verify]; } copy]).notTo.raiseAny();
        });
        
        pending(@"should get a collection of dictionaries when requesting user's starred repos");
        
        it(@"should send request for named repositories properly", ^{
            NSString *sampleRepoName = @"HubKit";
            NSString *sampleUserName = @"jnjosh";
            id expectedRepoArgument = [OCMArg checkWithBlock:^BOOL(id argument) {
                return [argument isEqualToString:sampleRepoName];
            }];
            id expectedUserArgument = [OCMArg checkWithBlock:^BOOL(id argument) {
                return [argument isEqualToString:sampleUserName];
            }];
            
            [[client expect] getRepositoryWithName:expectedRepoArgument
                                              user:expectedUserArgument
                                        completion:OCMOCK_ANY];
            
            HubKit *github = [HKFixtures hubKit];
            [github setHttpClient:client];
            [github getRepositoryWithName:sampleRepoName user:sampleUserName completion:nil];

            expect([^{ [client verify]; } copy]).notTo.raiseAny();

        });
        
        pending(@"should get a single dictionary when requesting a specific repo");

    });
    
});

SpecEnd
