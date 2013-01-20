//
//  HKUser.m
//  HubKit-iOS-Sample
//
//  Created by Josh Johnson on 1/16/13.
//  Copyright (c) 2013 HubKit. All rights reserved.
//

#import "HKUser.h"
#import "HKDefines.h"

static HKUser *hk_sharedUser = nil;

@interface HKUser ()

@property (nonatomic, strong) NSDictionary *remoteRepresentation;

@end

@implementation HKUser

#pragma mark - Class Methods

+ (void)setCurrentUser:(HKUser *)user
{
    hk_sharedUser = user;
}

+ (HKUser *)currentUser
{
    if (! hk_sharedUser) {
        NSString *login = [[NSUserDefaults standardUserDefaults] objectForKey:kHKCurrentUserIDKey];
        if (login) {
            hk_sharedUser = [HKUser userWithDictionaryRepresentation:@{ @"login" : login }];
        }
    }
    return hk_sharedUser;
}

+ (instancetype)userWithDictionaryRepresentation:(NSDictionary *)dictionary
{
    HKUser *user = [HKUser new];
    [user setRemoteRepresentation:dictionary];
    return user;
}

#pragma mark - Properties

- (NSString *)login
{
    return [self.remoteRepresentation objectForKey:@"login"];
}

@end
