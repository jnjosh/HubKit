//
//  OKIssue.h
//  Repos
//
//  Created by Rhys Powell on 13/01/13.
//  Copyright (c) 2013 Rhys Powell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "OKRemoteManagedObject.h"

@class OKRepo, OKUser;

@interface OKIssue : OKRemoteManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * rawBody;
@property (nonatomic, retain) NSString * state;
@property (nonatomic, retain) NSNumber * number;
@property (nonatomic, retain) NSNumber * commentCount;
@property (nonatomic, retain) OKUser *user;
@property (nonatomic, retain) OKUser *assignee;
@property (nonatomic, retain) OKRepo *repo;

@end
