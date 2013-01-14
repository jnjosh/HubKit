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
