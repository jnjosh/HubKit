//
//  HKFixtures.m
//  HubKit-iOS-Sample
//
//  Created by Josh Johnson on 1/17/13.
//  Copyright (c) 2013 HubKit. All rights reserved.
//

#import "HKFixtures.h"
#import "HubKit.h"

@implementation HKFixtures

+ (HubKit *)hubKit
{
    HubKit *github = [HubKit new];
    [github setAuthorizationClientId:@"testing-id" secret:@"testing-secret" requestedScopes:@[]];
    return github;
}

+ (HubKit *)hubKitWithEmptyAuthorization
{
    HubKit *github = [HubKit new];
    [github setAuthorizationClientId:@"" secret:@"" requestedScopes:@[]];
    return github;
}

@end
