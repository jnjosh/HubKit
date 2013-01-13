//
//  OKIssue.m
//  Repos
//
//  Created by Rhys Powell on 13/01/13.
//  Copyright (c) 2013 Rhys Powell. All rights reserved.
//

#import "OKIssue.h"
#import "OKRepo.h"
#import "OKUser.h"
#import "NSDictionary+OKExtensions.h"

@implementation OKIssue

@dynamic title;
@dynamic rawBody;
@dynamic state;
@dynamic number;
@dynamic commentCount;
@dynamic user;
@dynamic assignee;
@dynamic repo;

+ (NSString *)entityName
{
    return @"Issue";
}

- (void)unpackDictionary:(NSDictionary *)dictionary
{
    [super unpackDictionary:dictionary];
    
    self.title = [dictionary safeObjectForKey:@"title"];
    self.rawBody = [dictionary safeObjectForKey:@"body"];
    self.state = [dictionary safeObjectForKey:@"state"];
    self.number = [dictionary safeObjectForKey:@"number"];
    self.commentCount = [dictionary safeObjectForKey:@"comments"];
    
    self.user = [OKUser objectWithDictionary:[dictionary safeObjectForKey:@"user"]];
    self.assignee = [OKUser objectWithDictionary:[dictionary safeObjectForKey:@"assignee"]];
}

@end
