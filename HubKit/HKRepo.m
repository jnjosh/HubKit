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

#import "HKRepo.h"
#import "HKIssue.h"
#import "HKRepo.h"
#import "HKUser.h"
#import "NSDictionary+HKExtensions.h"


@implementation HKRepo

@dynamic byline;
@dynamic cloneURL;
@dynamic fork;
@dynamic forks;
@dynamic fullName;
@dynamic gitURL;
@dynamic hasDownloads;
@dynamic hasIssues;
@dynamic hasWiki;
@dynamic homepageURL;
@dynamic htmlURL;
@dynamic isPrivate;
@dynamic language;
@dynamic masterBranch;
@dynamic mirrorURL;
@dynamic name;
@dynamic openIssues;
@dynamic size;
@dynamic sshURL;
@dynamic stargazers;
@dynamic svnURL;
@dynamic watchers;
@dynamic child;
@dynamic owner;
@dynamic parent;
@dynamic issues;

+ (NSString *)entityName
{
    return @"Repo";
}

- (void)unpackDictionary:(NSDictionary *)dictionary
{
    [super unpackDictionary:dictionary];
    
    self.name = [dictionary safeObjectForKey:@"name"];
    self.fullName = [dictionary safeObjectForKey:@"full_name"];
    self.byline = [dictionary safeObjectForKey:@"description"];
    self.isPrivate = [dictionary safeObjectForKey:@"private"];
    self.fork = [dictionary safeObjectForKey:@"fork"];
    self.htmlURL = [dictionary safeObjectForKey:@"html_url"];
    self.gitURL = [dictionary safeObjectForKey:@"git_url"];
    self.cloneURL = [dictionary safeObjectForKey:@"clone_url"];
    self.sshURL = [dictionary safeObjectForKey:@"ssh_url"];
    self.svnURL = [dictionary safeObjectForKey:@"svn_url"];
    self.mirrorURL = [dictionary safeObjectForKey:@"mirror_url"];
    self.homepageURL = [dictionary safeObjectForKey:@"homepage"];
    self.language = [dictionary safeObjectForKey:@"language"];
    self.forks = [dictionary safeObjectForKey:@"forks"];
    self.watchers = [dictionary safeObjectForKey:@"watchers"];
    self.stargazers = [dictionary safeObjectForKey:@"watchers"];
    self.size = [dictionary safeObjectForKey:@"size"];
    self.masterBranch = [dictionary safeObjectForKey:@"master_branch"];
    self.openIssues = [dictionary safeObjectForKey:@"open_issues"];
    self.hasIssues = [dictionary safeObjectForKey:@"has_issues"];
    self.hasWiki = [dictionary safeObjectForKey:@"has_wiki"];
    self.hasDownloads = [dictionary safeObjectForKey:@"has_downloads"];
    
    self.owner = [HKUser objectWithDictionary:dictionary[@"owner"]];
    self.parent = [HKRepo objectWithDictionary:dictionary[@"parent"]];
}

@end
