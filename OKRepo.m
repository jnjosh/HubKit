//
//  Repo.m
//  Repos
//
//  Created by Rhys Powell on 29/12/12.
//  Copyright (c) 2012 Rhys Powell. All rights reserved.
//

#import "OKRepo.h"
#import "OKRepo.h"
#import "OKUser.h"

#import "NSDictionary+RPExtensions.h"


@implementation OKRepo

@dynamic name;
@dynamic fullName;
@dynamic byline;
@dynamic isPrivate;
@dynamic fork;
@dynamic htmlURL;
@dynamic gitURL;
@dynamic cloneURL;
@dynamic sshURL;
@dynamic svnURL;
@dynamic mirrorURL;
@dynamic homepageURL;
@dynamic language;
@dynamic forks;
@dynamic watchers;
@dynamic stargazers;
@dynamic size;
@dynamic masterBranch;
@dynamic openIssues;
@dynamic hasIssues;
@dynamic hasWiki;
@dynamic hasDownloads;
@dynamic owner;
@dynamic parent;
@dynamic child;
@dynamic source;

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
    
    self.owner = [OKUser objectWithDictionary:dictionary[@"owner"]];
    self.parent = [OKRepo objectWithDictionary:dictionary[@"parent"]];
}

@end
