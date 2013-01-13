//
//  OKUser.h
//  Repos
//
//  Created by Rhys Powell on 13/01/13.
//  Copyright (c) 2013 Rhys Powell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "OKRemoteManagedObject.h"

@class OKIssue, OKRepo;

extern NSString *const kOKCurrentUserChangedNotificationName;

@interface OKUser : OKRemoteManagedObject

@property (nonatomic, retain) NSString * avatarURL;
@property (nonatomic, retain) NSString * blogURL;
@property (nonatomic, retain) NSString * company;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSNumber * hireable;
@property (nonatomic, retain) NSString * location;
@property (nonatomic, retain) NSString * login;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *repos;
@property (nonatomic, retain) NSSet *issues;
@property (nonatomic, retain) NSSet *assignedIssues;
@property (nonatomic, strong) NSString *accessToken;

+ (OKUser *)currentUser;
+ (void)setCurrentUser:(OKUser *)user;

@end

@interface OKUser (CoreDataGeneratedAccessors)

- (void)addReposObject:(OKRepo *)value;
- (void)removeReposObject:(OKRepo *)value;
- (void)addRepos:(NSSet *)values;
- (void)removeRepos:(NSSet *)values;

- (void)addIssuesObject:(OKIssue *)value;
- (void)removeIssuesObject:(OKIssue *)value;
- (void)addIssues:(NSSet *)values;
- (void)removeIssues:(NSSet *)values;

- (void)addAssignedIssuesObject:(OKIssue *)value;
- (void)removeAssignedIssuesObject:(OKIssue *)value;
- (void)addAssignedIssues:(NSSet *)values;
- (void)removeAssignedIssues:(NSSet *)values;

@end
