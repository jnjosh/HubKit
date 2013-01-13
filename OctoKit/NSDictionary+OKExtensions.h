//
//  NSDictionary+OKExtensions.h
//  OctoKit-iOS-Sample
//
//  Created by Josh Johnson on 1/13/13.
//  Copyright (c) 2013 OctoKit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (OKExtensions)

- (id)safeObjectForKey:(NSString *)key;

@end
