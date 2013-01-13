//
//  RPDefines.h
//  Repos
//
//  Created by Rhys Powell on 11/01/13.
//  Copyright (c) 2013 Rhys Powell. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef OKDEFINES
#define OKDEFINES

#pragma mark - User Defaults Keys

extern NSString *const kOKCurrentUserIDKey;

#pragma mark - Keychain

extern NSString *const kOKKeychainServiceName;

#pragma mark - Authorization Scopes

/** Authorization Scope Types
 @see: http://developer.github.com/v3/oauth/#scopes
 */
extern const struct OKGithubAuthorizationScopes {
	__unsafe_unretained NSString *user; // Read/write access to profile info only. Note: this scope includes user:email and user:follow.
	__unsafe_unretained NSString *userEmail; // Read access to a user’s email addresses.
	__unsafe_unretained NSString *userFollow; // Access to follow or unfollow other users.
	__unsafe_unretained NSString *publicRepo; // Read/write access to public repos and organizations.
	__unsafe_unretained NSString *repo; // Read/write access to public and private repos and organizations.
	__unsafe_unretained NSString *repoStatus; // Read/write access to public and private repo statuses. Does not include access to code - use repo for that.
	__unsafe_unretained NSString *deleteRepo; // Delete access to adminable repositories.
	__unsafe_unretained NSString *notifications; // Read access to a user’s notifications. repo is accepted too.
	__unsafe_unretained NSString *gist; // Write access to gists.
} OKGithubAuthorizationScopes;


#endif