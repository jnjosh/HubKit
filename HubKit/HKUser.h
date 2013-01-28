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

@interface HKUser : HKRemoteManagedObject

@property (nonatomic, retain) NSString *login;
@property (nonatomic, retain) NSString *avatarURL;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *company;
@property (nonatomic, retain) NSString *blog;
@property (nonatomic, retain) NSString *location;
@property (nonatomic, retain) NSString *email;
@property (nonatomic, retain) NSNumber *hireable;
@property (nonatomic, retain) NSString *bio;
@property (nonatomic, retain) NSNumber *repoCount;
@property (nonatomic, retain) NSNumber *gistCount;
@property (nonatomic, retain) NSNumber *followerCount;
@property (nonatomic, retain) NSNumber *followingCount;
@property (nonatomic, retain) NSString *type;
@property (nonatomic, strong) NSString *token;

+ (void)setCurrentUser:(HKUser *)user;
+ (instancetype)currentUser;

@end
