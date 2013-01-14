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
#import "OKRemoteManagedObject.h"

@class OKIssue, OKRepo, OKUser;

@interface OKRepo : OKRemoteManagedObject

@property (nonatomic, retain) NSString * byline;
@property (nonatomic, retain) NSString * cloneURL;
@property (nonatomic, retain) NSNumber * fork;
@property (nonatomic, retain) NSNumber * forks;
@property (nonatomic, retain) NSString * fullName;
@property (nonatomic, retain) NSString * gitURL;
@property (nonatomic, retain) NSNumber * hasDownloads;
@property (nonatomic, retain) NSNumber * hasIssues;
@property (nonatomic, retain) NSNumber * hasWiki;
@property (nonatomic, retain) NSString * homepageURL;
@property (nonatomic, retain) NSString * htmlURL;
@property (nonatomic, retain) NSNumber * isPrivate;
@property (nonatomic, retain) NSString * language;
@property (nonatomic, retain) NSString * masterBranch;
@property (nonatomic, retain) NSString * mirrorURL;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * openIssues;
@property (nonatomic, retain) NSNumber * size;
@property (nonatomic, retain) NSString * sshURL;
@property (nonatomic, retain) NSNumber * stargazers;
@property (nonatomic, retain) NSString * svnURL;
@property (nonatomic, retain) NSNumber * watchers;
@property (nonatomic, retain) OKRepo *child;
@property (nonatomic, retain) OKUser *owner;
@property (nonatomic, retain) OKRepo *parent;
@property (nonatomic, retain) NSSet *issues;
@end

@interface OKRepo (CoreDataGeneratedAccessors)

- (void)addIssuesObject:(OKIssue *)value;
- (void)removeIssuesObject:(OKIssue *)value;
- (void)addIssues:(NSSet *)values;
- (void)removeIssues:(NSSet *)values;

@end
