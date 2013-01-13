//
//  User.h
//  Repos
//
//  Created by Rhys Powell on 29/12/12.
//  Copyright (c) 2012 Rhys Powell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "OKRemoteManagedObject.h"

@class OKRepo;

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
@property (nonatomic, strong) NSString *accessToken;

+ (OKUser *)currentUser;
+ (void)setCurrentUser:(OKUser *)user;

@end

@interface OKUser (CoreDataGeneratedAccessors)

- (void)addReposObject:(OKRepo *)value;
- (void)removeReposObject:(OKRepo *)value;
- (void)addRepos:(NSSet *)values;
- (void)removeRepos:(NSSet *)values;

@end
