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

SpecBegin(HubKitAuthorization)

describe(@"HubKit", ^{
	
	context(@"when using authorizing users", ^{

        __block id client = nil;
        
        beforeEach(^{
            client = [OCMockObject mockForClass:[HKHTTPClient class]];
            [[client stub] setAuthorizationHeaderWithUsername:[OCMArg any] password:[OCMArg any]];
            [[client stub] clearAuthorizationHeader];
        });
        
        it(@"should send request to authorizations", ^{
            
            [[client expect] postPath:[OCMArg checkWithBlock:^BOOL(id argument) {
                return [argument isEqualToString:@"authorizations"];
            }] parameters:OCMOCK_ANY success:OCMOCK_ANY failure:OCMOCK_ANY];
            
            HubKit *github = [HKFixtures hubKit];
            [github setHttpClient:client];
            
            [github loginWithUser:@"user" password:@"password" completion:nil];
            [client verify];
        });
		
		it(@"should send request to github", ^{
            
            [[client expect] postPath:OCMOCK_ANY parameters:OCMOCK_ANY success:OCMOCK_ANY failure:OCMOCK_ANY];

            HubKit *github = [HKFixtures hubKit];
            [github setHttpClient:client];
            
            [github loginWithUser:@"user" password:@"password" completion:nil];
            [client verify];
            
		});
        
        it(@"should not send to github if empty client id or secret is available", ^{
           
            [[client reject] postPath:OCMOCK_ANY parameters:OCMOCK_ANY success:OCMOCK_ANY failure:OCMOCK_ANY];
 
            HubKit *github = [HKFixtures hubKitWithEmptyAuthorization];
            [github setHttpClient:client];
            
            [github loginWithUser:@"user" password:@"password" completion:nil];
            [client verify];
            
        });
		
	});
	
});

SpecEnd