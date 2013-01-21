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
#import "HKFixtures.h"

SpecBegin(HKHTTPClient)

describe(@"HKHTTPClient", ^{
    
    __block HKURLTestProtocol *sharedProtocol = nil;
    __block HKHTTPClient *client = nil;
    
    beforeAll(^{
        sharedProtocol = [HKURLTestProtocol sharedInstance];
        [NSURLProtocol registerClass:[HKURLTestProtocol class]];
        
        client = [[HKHTTPClient alloc] init];
    });
    
    context(@"when connecting to the authorizations api", ^{
        
        it(@"should get authorization object when creating new authorization", ^{
            HKCannedDataSource *dataSource = [HKCannedDataSource new];
            dataSource.responseObject = [HKFixtures cannedAuthorizationResponse];
            sharedProtocol.dataSource = dataSource;

            __block id actualObject = nil;
            __block id actualError = nil;
            [client createAuthorizationWithUsername:@"USER" password:@"PASSWORD" completion:^(id object, NSError *error) {
                actualObject = object;
                actualError = error;
            }];
            
            expect(actualObject).willNot.beNil();
            expect(actualError).will.beNil();
            expect(actualObject).will.beKindOf([NSDictionary class]);
            
            NSString *checkKey = @"token";
            expect([actualObject objectForKey:checkKey]).will.equal([dataSource.responseObject objectForKey:checkKey]);
        });
        
        it(@"should get an error object when failing to create a new authorization", ^{
            HKCannedDataSource *dataSource = [HKCannedDataSource new];
            dataSource.error = [HKFixtures cannedError];
            sharedProtocol.dataSource = dataSource;
            
            __block id actualObject = nil;
            __block id actualError = nil;
            [client createAuthorizationWithUsername:@"USER" password:@"PASSWORD" completion:^(id object, NSError *error) {
                actualObject = object;
                actualError = error;
            }];
            
            expect(actualObject).will.beNil();
            expect(actualError).willNot.beNil();
        });
        
    });
    
    context(@"when connecting to the currently authenticated user", ^{

        it(@"should get the authenticated user object", ^{
            HKCannedDataSource *dataSource = [HKCannedDataSource new];
            dataSource.responseObject = [HKFixtures cannedUserResponse];
            sharedProtocol.dataSource = dataSource;
            
            __block id actualObject = nil;
            __block id actualError = nil;
            [client getAuthenticatedUserWithCompletion:^(id object, NSError *error) {
                actualObject = object;
                actualError = error;
            }];
            
            expect(actualObject).willNot.beNil();
            expect(actualObject).will.beKindOf([NSDictionary class]);
            expect(actualError).will.beNil();

            NSString *checkKey = @"login";
            expect([actualObject objectForKey:checkKey]).will.equal([dataSource.responseObject objectForKey:checkKey]);
        });
        
        it(@"should get an error object when failing to get user object", ^{
            HKCannedDataSource *dataSource = [HKCannedDataSource new];
            dataSource.error = [HKFixtures cannedError];
            sharedProtocol.dataSource = dataSource;

            __block id actualObject = nil;
            __block id actualError = nil;
            [client getAuthenticatedUserWithCompletion:^(id object, NSError *error) {
                actualObject = object;
                actualError = error;
            }];
            
            expect(actualObject).will.beNil();
            expect(actualError).willNot.beNil();
        });
    
        it(@"should get repositories of the authenticated user", ^{
            HKCannedDataSource *dataSource = [HKCannedDataSource new];
            dataSource.responseObject = [HKFixtures cannedRepositoryCollectionResponse];
            sharedProtocol.dataSource = dataSource;
            
            __block id actualObject = nil;
            __block id actualError = nil;
            [client getAuthenticatedUserReposWithCompletion:^(id object, NSError *error) {
                actualObject = object;
                actualError = error;
            }];
            
            expect(actualObject).willNot.beNil();
            expect(actualObject).will.beKindOf([NSArray class]);
            expect(actualError).will.beNil();
        });

        it(@"should get starred repositories of the authenticated user", ^{
            HKCannedDataSource *dataSource = [HKCannedDataSource new];
            dataSource.responseObject = [HKFixtures cannedRepositoryCollectionResponse];
            sharedProtocol.dataSource = dataSource;
            
            __block id actualObject = nil;
            __block id actualError = nil;
            [client getAuthenticatedUserStarredReposWithCompletion:^(id object, NSError *error) {
                actualObject = object;
                actualError = error;
            }];
            
            expect(actualObject).willNot.beNil();
            expect(actualObject).will.beKindOf([NSArray class]);
            expect(actualError).will.beNil();
        });

    });
    
    context(@"when connecting to repositories", ^{

        it(@"should get a repository with name and user", ^{
            HKCannedDataSource *dataSource = [HKCannedDataSource new];
            dataSource.responseObject = [HKFixtures cannedRepositoryResponse];
            sharedProtocol.dataSource = dataSource;
            
            __block id actualObject = nil;
            __block id actualError = nil;
            [client getRepositoryWithName:@"REPO" user:@"USER" completion:^(id object, NSError *error) {
                actualObject = object;
                actualError = error;
            }];
            
            expect(actualObject).willNot.beNil();
            expect(actualObject).will.beKindOf([NSDictionary class]);
            expect(actualError).will.beNil();
            
            NSString *checkKey = @"name";
            expect([actualObject objectForKey:checkKey]).will.equal([dataSource.responseObject objectForKey:checkKey]);
        });
        
        it(@"should get an error object when failing to get user object", ^{
            HKCannedDataSource *dataSource = [HKCannedDataSource new];
            dataSource.error = [HKFixtures cannedError];
            sharedProtocol.dataSource = dataSource;
            
            __block id actualObject = nil;
            __block id actualError = nil;
            [client getRepositoryWithName:@"REPO" user:@"USER" completion:^(id object, NSError *error) {
                actualObject = object;
                actualError = error;
            }];
            
            expect(actualObject).will.beNil();
            expect(actualError).willNot.beNil();
        });

    });
    
    afterAll(^{
        [NSURLProtocol unregisterClass:[HKURLTestProtocol class]];
    });
    
});

SpecEnd