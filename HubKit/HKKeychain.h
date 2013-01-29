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

extern NSString * const kHKHubKitKeychainDefaultAccount;

/**
 HKKeychain provides a simplified interface to the system keychain, making
 it work more like NSUserDefaults. It allows the easy and secure storage of
 user's OAuth tokens and other login info.
 */

@interface HKKeychain : NSObject

/** Store the Authorization Token in the keychain 
 
 @param token the token to be stored
 @param userAccount the login of the user this token belongs to
 
 @return whether or not the item was added to the keychain
 */
+ (BOOL)storeAuthenticationToken:(NSString *)token userAccount:(NSString *)userAccount;

/** Retrieve the Authorization Token from the keychain 
 
 @param account the login of the account desired
 
 @return the OAuth key for the account, or nil if the key isn't found
 */
+ (NSString *)authenticationTokenForAccount:(NSString *)account;

/** Remove the authorization token from the keychain 
 
 @param account the account who's token you wish to remove
 */
+ (void)removeAuthenticationTokenForAccount:(NSString *)account;

@end
