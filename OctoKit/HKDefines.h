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

#ifndef HKDEFINES
#define HKDEFINES

#pragma mark - User Defaults Keys

extern NSString *const kHKCurrentUserIDKey;

#pragma mark - Keychain

extern NSString *const kHKKeychainServiceName;

#pragma mark - Authorization Scopes

/** Authorization Scope Types
 @see: http://developer.github.com/v3/oauth/#scopes
 */
extern const struct HKGithubAuthorizationScopes {
	__unsafe_unretained NSString *user; // Read/write access to profile info only. Note: this scope includes user:email and user:follow.
	__unsafe_unretained NSString *userEmail; // Read access to a user’s email addresses.
	__unsafe_unretained NSString *userFollow; // Access to follow or unfollow other users.
	__unsafe_unretained NSString *publicRepo; // Read/write access to public repos and organizations.
	__unsafe_unretained NSString *repo; // Read/write access to public and private repos and organizations.
	__unsafe_unretained NSString *repoStatus; // Read/write access to public and private repo statuses. Does not include access to code - use repo for that.
	__unsafe_unretained NSString *deleteRepo; // Delete access to adminable repositories.
	__unsafe_unretained NSString *notifications; // Read access to a user’s notifications. repo is accepted too.
	__unsafe_unretained NSString *gist; // Write access to gists.
} HKGithubAuthorizationScopes;


#endif
