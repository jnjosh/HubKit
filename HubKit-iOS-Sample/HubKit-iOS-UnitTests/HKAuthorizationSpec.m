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
#import "HKAuthorization.h"

SpecBegin(HKAuthorization)

describe(@"HKAuthorization", ^{
   
    context(@"when creating an authorization with no client information", ^{
       
        __block HKAuthorization *authorization = nil;
        
        beforeAll(^{
            authorization = [HKAuthorization new];
        });
        
        it(@"should not build a dictionary representation", ^{
            expect([authorization dictionaryRepresentation]).to.beNil();
        });
        
    });
    
    context(@"when creating an authorization with empty client information", ^{
       
        __block HKAuthorization *authorization = nil;
        
        beforeAll(^{
            authorization = [HKAuthorization new];
            [authorization setClientId:@""];
            [authorization setClientSecret:@""];
            [authorization setScopes:@[]];
        });
        
        it(@"should not build a dictionary representation", ^{
            expect([authorization dictionaryRepresentation]).to.beNil();
        });

    });
    
    context(@"when creating an authorization with non-empty client information", ^{
    
        __block HKAuthorization *authorization = nil;
        NSString *expectedId = @"testing-id";
        NSString *expectedSecret = @"secret";
        NSString *expectedScope = @"scope";
        
        beforeAll(^{
            authorization = [HKAuthorization new];
            [authorization setClientId:expectedId];
            [authorization setClientSecret:expectedSecret];
            [authorization setScopes:@[ expectedScope ]];
        });

        it(@"should create a dictionary representation", ^{
            expect([authorization dictionaryRepresentation]).toNot.beNil();
        });
        
        it(@"should create properly keyed dictionary representation", ^{
            NSDictionary *actualDictionary = [authorization dictionaryRepresentation];
            expect([actualDictionary objectForKey:kHKAuthorizationKeyClientId]).to.equal(expectedId);
            expect([actualDictionary objectForKey:kHKAuthorizationKeyClientSecret]).to.equal(expectedSecret);
            expect([[actualDictionary objectForKey:kHKAuthorizationKeyClientScopes] objectAtIndex:0]).to.equal(expectedScope);
        });
        
    });
    
});


SpecEnd