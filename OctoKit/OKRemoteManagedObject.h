//
//  RPRemoteManagedObject.h
//  Repos
//
//  Created by Rhys Powell on 19/12/12.
//  Copyright (c) 2012 Rhys Powell. All rights reserved.
//

#import "OKManagedObject.h"

@interface OKRemoteManagedObject : OKManagedObject

@property (nonatomic, strong) NSNumber *remoteID;
@property (nonatomic, strong) NSDate *createdAt;
@property (nonatomic, strong) NSDate *updatedAt;

+ (instancetype)objectWithRemoteID:(NSNumber *)remoteID;
+ (instancetype)objectWithRemoteID:(NSNumber *)remoteID context:(NSManagedObjectContext *)context;

+ (instancetype)existingObjectWithRemoteID:(NSNumber *)remoteID;
+ (instancetype)existingObjectWithRemoteID:(NSNumber *)remoteID context:(NSManagedObjectContext *)context;

+ (instancetype)objectWithDictionary:(NSDictionary *)dictionary;
+ (instancetype)objectWithDictionary:(NSDictionary *)dictionary context:(NSManagedObjectContext *)context;

+ (instancetype)existingObjectWithDictionary:(NSDictionary *)dictionary;
+ (instancetype)existingObjectWithDictionary:(NSDictionary *)dictionary context:(NSManagedObjectContext *)context;

// Override these in your subclass
- (void)unpackDictionary:(NSDictionary *)dictionary;
- (BOOL)shouldUnpackDictionary:(NSDictionary *)dictionary;

+ (NSDate *)parseDate:(id)dateStringOrDateNumber;

@end
