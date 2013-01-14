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

#import "OKRemoteManagedObject.h"

@implementation OKRemoteManagedObject

@dynamic remoteID;
@dynamic createdAt;
@dynamic updatedAt;

+ (instancetype)objectWithRemoteID:(NSNumber *)remoteID
{
    return [self objectWithRemoteID:remoteID context:nil];
}

+ (instancetype)objectWithRemoteID:(NSNumber *)remoteID context:(NSManagedObjectContext *)context
{
    OKRemoteManagedObject *object = [self existingObjectWithRemoteID:remoteID context:context];
    
    if (object == nil) {
        object = [[self alloc] initWithContext:context];
        object.remoteID = remoteID;
    }
    
    return object;
}

+ (instancetype)existingObjectWithRemoteID:(NSNumber *)remoteID
{
    return [self existingObjectWithRemoteID:remoteID context:nil];
}

+ (instancetype)existingObjectWithRemoteID:(NSNumber *)remoteID context:(NSManagedObjectContext *)context
{
    if (context == nil) {
        context = [self mainContext];
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = [self entityWithContext:context];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"remoteID = %@", remoteID];
    fetchRequest.fetchLimit = 1;
    
    NSArray *results = [context executeFetchRequest:fetchRequest error:nil];
    
    if ([results count] == 0) {
        return nil;
    }
    
    return results[0];
}

+ (instancetype)objectWithDictionary:(NSDictionary *)dictionary
{
    return [self objectWithDictionary:dictionary context:[self mainContext]];
}

+ (instancetype)objectWithDictionary:(NSDictionary *)dictionary context:(NSManagedObjectContext *)context
{
    if (dictionary == nil) {
        return nil;
    }
    
    NSNumber *remoteID = dictionary[@"id"];
    
    if (remoteID == nil || [remoteID integerValue] == 0) {
        return nil;
    }
    
    if (context == nil) {
        context = [self mainContext];
    }
    
    OKRemoteManagedObject *object = [self objectWithRemoteID:remoteID context:context];
    
    if ([object shouldUnpackDictionary:dictionary]) {
        [object unpackDictionary:dictionary];
    }
    
    return object;
}

+ (instancetype)existingObjectWithDictionary:(NSDictionary *)dictionary
{
    return [self existingObjectWithDictionary:dictionary context:[self mainContext]];
}

+ (instancetype)existingObjectWithDictionary:(NSDictionary *)dictionary context:(NSManagedObjectContext *)context
{
    if (dictionary == nil) {
        return nil;
    }
    
    NSNumber *remoteID = dictionary[@"id"];
    
    if (remoteID == nil || [remoteID integerValue] == 0) {
        return nil;
    }
    
    if (context == nil) {
        context = [self mainContext];
    }
    
    OKRemoteManagedObject *object = [self existingObjectWithRemoteID:remoteID context:context];
    
    
    if (object == nil) {
        return nil;
    }
    
    if ([object shouldUnpackDictionary:dictionary]) {
        [object unpackDictionary:dictionary];
    }
    
    return object;
}

- (void)unpackDictionary:(NSDictionary *)dictionary
{
    self.remoteID = dictionary[@"id"];
    self.createdAt = [[self class] parseDate:dictionary[@"created_at"]];
    self.updatedAt = [[self class] parseDate:dictionary[@"updated_at"]];
}

- (BOOL)shouldUnpackDictionary:(NSDictionary *)dictionary
{
    return self.updatedAt == nil || [self.updatedAt isEqualToDate:[[self class] parseDate:dictionary[@"updated_at"]]] == NO;
}

+ (NSDate *)parseDate:(id)dateStringOrDateNumber {
	// Return nil if nil is given
	if (!dateStringOrDateNumber || dateStringOrDateNumber == [NSNull null]) {
		return nil;
	}
	
	// Parse number
	if ([dateStringOrDateNumber isKindOfClass:[NSNumber class]]) {
		return [NSDate dateWithTimeIntervalSince1970:[dateStringOrDateNumber doubleValue]];
	}
	
	// Parse string
	else if ([dateStringOrDateNumber isKindOfClass:[NSString class]]) {
		// ISO8601 Parser borrowed from SSToolkit. http://sstoolk.it
		NSString *iso8601 = dateStringOrDateNumber;
		if (!iso8601) {
			return nil;
		}
		
		const char *str = [iso8601 cStringUsingEncoding:NSUTF8StringEncoding];
		char newStr[25];
		
		struct tm tm;
		size_t len = strlen(str);
		if (len == 0) {
			return nil;
		}
		
		// UTC
		if (len == 20 && str[len - 1] == 'Z') {
			strncpy(newStr, str, len - 1);
			strncpy(newStr + len - 1, "+0000", 5);
		}
		
		// Timezone
		else if (len == 24 && str[22] == ':') {
			strncpy(newStr, str, 22);
			strncpy(newStr + 22, str + 23, 2);
		}
		
		// Poorly formatted timezone
		else {
			strncpy(newStr, str, len > 24 ? 24 : len);
		}
		
		// Add null terminator
		newStr[sizeof(newStr) - 1] = 0;
		
		if (strptime(newStr, "%FT%T%z", &tm) == NULL) {
			return nil;
		}
		
		time_t t;
		t = mktime(&tm);
		
		return [NSDate dateWithTimeIntervalSince1970:t];
	}
	
	NSAssert1(NO, @"Failed to parse date: %@", dateStringOrDateNumber);
	return nil;
}

@end
