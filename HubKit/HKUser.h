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

/**
 A `HKUser` object represents a user record returned by the remote API.
 It provides persistence and a clean Objective-C interface to the response's
 properties.
 */

@interface HKUser : HKRemoteManagedObject

/**The user's GitHub login
 
 This maps to the API response's `login` */
@property (nonatomic, retain) NSString *login;

/**The URL of the user's avatar
 
 This maps to the API response's `avatar_url` */
@property (nonatomic, retain) NSString *avatarURL;

/**The user's actual name
 
 This maps to the API response's `name` */
@property (nonatomic, retain) NSString *name;

/**The company the user is employed at
 
 This maps to the API response's `company` */
@property (nonatomic, retain) NSString *company;

/**The URL of the user's blog
 
 This maps to the API response's `blog` */
@property (nonatomic, retain) NSString *blog;

/**The name of the user's geographical location
 
 This maps to the API response's `location` */
@property (nonatomic, retain) NSString *location;

/**The user's email
 
 This maps to the API response's `email` */
@property (nonatomic, retain) NSString *email;

/**Whether or not the user is available for hire
 
 This maps to the API response's `hireable`
 
 This property is a boolean value */
@property (nonatomic, retain) NSNumber *hireable;

/**A short bio of the user
 
 This maps to the API response's `bio` */
@property (nonatomic, retain) NSString *bio;

/**The number of public repositories the user has
 
 This maps to the API response's `repos` */
@property (nonatomic, retain) NSNumber *repoCount;

/**The number of public gists the user has
 
 This maps to the API response's `gists` */
@property (nonatomic, retain) NSNumber *gistCount;

/**The number of users following this user
 
 This maps to the API response's `followers`  */
@property (nonatomic, retain) NSNumber *followerCount;

/**The number of users this user is following
 
 This maps to the API response's `following`  */
@property (nonatomic, retain) NSNumber *followingCount;

/**The type of user, "User" or "Organisation"
 
 This maps to the API response's `type` */
@property (nonatomic, retain) NSString *type;

/**A non-persistent variable to store the user's OAuth token */
@property (nonatomic, strong) NSString *token;

/**@name Manage the current user */

/**Sets the current user
 
 This sets a given user object as the current user, a status that
 persists through application restarts
 
 @param user the `HKUser` to make current
 */
+ (void)setCurrentUser:(HKUser *)user;

/**Gets the current user
 
 If there is no current user, thsi returns `nil`
 
 @return the current `HKUser`
 */
+ (instancetype)currentUser;

@end
