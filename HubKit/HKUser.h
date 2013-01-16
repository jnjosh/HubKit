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
#import <CoreData/CoreData.h>
#import "HKRemoteManagedObject.h"

@class HKIssue, HKRepo;

extern NSString *const kHKCurrentUserChangedNotificationName;

@interface HKUser : HKRemoteManagedObject

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

+ (HKUser *)currentUser;
+ (void)setCurrentUser:(HKUser *)user;

@end

@interface HKUser (CoreDataGeneratedAccessors)

- (void)addReposObject:(HKRepo *)value;
- (void)removeReposObject:(HKRepo *)value;
- (void)addRepos:(NSSet *)values;
- (void)removeRepos:(NSSet *)values;

- (void)addIssuesObject:(HKIssue *)value;
- (void)removeIssuesObject:(HKIssue *)value;
- (void)addIssues:(NSSet *)values;
- (void)removeIssues:(NSSet *)values;

- (void)addAssignedIssuesObject:(HKIssue *)value;
- (void)removeAssignedIssuesObject:(HKIssue *)value;
- (void)addAssignedIssues:(NSSet *)values;
- (void)removeAssignedIssues:(NSSet *)values;

@end
