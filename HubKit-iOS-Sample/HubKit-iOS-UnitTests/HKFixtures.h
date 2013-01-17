//
//  HKFixtures.h
//  HubKit-iOS-Sample
//
//  Created by Josh Johnson on 1/17/13.
//  Copyright (c) 2013 HubKit. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HubKit;

@interface HKFixtures : NSObject

+ (HubKit *)hubKit;

+ (HubKit *)hubKitWithEmptyAuthorization;

@end
