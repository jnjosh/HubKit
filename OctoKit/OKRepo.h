//
//  Repo.h
//  Repos
//
//  Created by Rhys Powell on 29/12/12.
//  Copyright (c) 2012 Rhys Powell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "OKRemoteManagedObject.h"

@class OKRepo, OKUser;

@interface OKRepo : OKRemoteManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * fullName;
@property (nonatomic, retain) NSString * byline;
@property (nonatomic, retain) NSNumber * isPrivate;
@property (nonatomic, retain) NSNumber * fork;
@property (nonatomic, retain) NSString * htmlURL;
@property (nonatomic, retain) NSString * gitURL;
@property (nonatomic, retain) NSString * cloneURL;
@property (nonatomic, retain) NSString * sshURL;
@property (nonatomic, retain) NSString * svnURL;
@property (nonatomic, retain) NSString * mirrorURL;
@property (nonatomic, retain) NSString * homepageURL;
@property (nonatomic, retain) NSString * language;
@property (nonatomic, retain) NSNumber * forks;
@property (nonatomic, retain) NSNumber * watchers;
@property (nonatomic, strong) NSNumber * stargazers;
@property (nonatomic, retain) NSNumber * size;
@property (nonatomic, retain) NSString * masterBranch;
@property (nonatomic, retain) NSNumber * openIssues;
@property (nonatomic, retain) NSNumber * hasIssues;
@property (nonatomic, retain) NSNumber * hasWiki;
@property (nonatomic, retain) NSNumber * hasDownloads;
@property (nonatomic, retain) OKUser *owner;
@property (nonatomic, retain) OKRepo *parent;
@property (nonatomic, retain) OKRepo *child;
@property (nonatomic, retain) OKRepo *source;

@end
