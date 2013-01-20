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

#import "HKHTTPClient.h"
#import "HKURLTestProtocol.h"
#import "HKCannedDataSource.h"

SpecBegin(HKHTTPClient)

describe(@"HKHTTPClient", ^{
   
    beforeAll(^{
        [NSURLProtocol registerClass:[HKURLTestProtocol class]];
    });
    
    it(@"should getAuthenticatedUserWithCompletion", ^{
        HKCannedDataSource *datasource = [HKCannedDataSource new];
        datasource.responseDictionary = @{ @"somekey": @"somevalue" };
        datasource.statusCode = 200;
        [[HKURLTestProtocol sharedInstance] setDataSource:datasource];
        
        __block volatile BOOL didCall = NO;
        HKHTTPClient *client = [[HKHTTPClient alloc] init];
        [client getAuthenticatedUserWithCompletion:^(id object, NSError *error) {
            if (object) {
                didCall = ([object objectForKey:@"somekey"] != nil);
            }
        }];
        
        expect(didCall).will.equal(YES);
        
    });
    
    it(@"should error when posting a login and recieving a 400 status code", ^{
        HKCannedDataSource *datasource = [HKCannedDataSource new];
        datasource.error = [NSError errorWithDomain:kHKHubKitErrorDomain code:101 userInfo:nil];
        [[HKURLTestProtocol sharedInstance] setDataSource:datasource];
        
        __block volatile BOOL didCall = NO;
        HKHTTPClient *client = [[HKHTTPClient alloc] init];
        [client createAuthorizationWithUsername:@"josh" password:@"password" completion:^(id object, NSError *error) {
            if ([[error domain] isEqualToString:kHKHubKitErrorDomain]) {
                didCall = YES;
            }
        }];
        
        expect(didCall).will.equal(YES);
        
    });
    
    it(@"should post login", ^{
        HKCannedDataSource *datasource = [HKCannedDataSource new];
        datasource.responseDictionary = @{ @"somekey": @"somevalue" };
        datasource.statusCode = 200;
        [[HKURLTestProtocol sharedInstance] setDataSource:datasource];
        
        __block volatile BOOL didCall = NO;
        HKHTTPClient *client = [[HKHTTPClient alloc] init];
        [client createAuthorizationWithUsername:@"josh" password:@"password" completion:^(id object, NSError *error) {
            if (! error) {
                didCall = YES;
            }
        }];
        
        expect(didCall).will.equal(YES);
    });
    
    afterAll(^{
        [NSURLProtocol unregisterClass:[HKURLTestProtocol class]];
    });
    
});

SpecEnd