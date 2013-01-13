//
//  NSDictionary+OKExtensions.m
//  OctoKit-iOS-Sample
//
//  Created by Josh Johnson on 1/13/13.
//  Copyright (c) 2013 OctoKit. All rights reserved.
//

#import "NSDictionary+OKExtensions.h"

@implementation NSDictionary (OKExtensions)

- (id)safeObjectForKey:(NSString *)key
{
	id obj = [self objectForKey:key];
	if ([obj isEqual:[NSNull null]]) {
		obj = nil;
	}
	return obj;
}

@end
