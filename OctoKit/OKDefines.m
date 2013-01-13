//
//  RPDefines.m
//  Repos
//
//  Created by Rhys Powell on 11/01/13.
//  Copyright (c) 2013 Rhys Powell. All rights reserved.
//

#import "OKDefines.h"

#pragma mark - User Defaults Keys

NSString *const kOKCurrentUserIDKey = @"OKCurrentUserID";

#pragma mark - Keychain

NSString *const kOKKeychainServiceName = @"Repos";

#pragma mark - Authorization Scopes

const struct OKGithubAuthorizationScopes OKGithubAuthorizationScopes = {
	.user = @"user",
	.userEmail = @"user:email",
	.userFollow = @"user:follow",
	.publicRepo = @"public_repo",
	.repo = @"repo",
	.repoStatus = @"repo:status",
	.deleteRepo = @"delete_repo",
	.notifications = @"notifications",
	.gist = @"gist"
};
