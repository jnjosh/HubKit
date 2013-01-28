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

#import <CoreData/CoreData.h>

/**
 `HKManagedObject` acts as a base class for all the managed objects in HubKit. It
 provides some convenience methods on top of Core Data, notably:
 
 - Simplified access to a global `NSManagedObjectContext`, `NSManagedObjectModel`,
   and `NSPersistentStoreCoordinator`
 - A more straightforward method for initialising new objects through the
   `initWithContext:` method.
 - A `save` method on all managed objects
 
 @see NSRemoteManagedObjectContext
 */

@interface HKManagedObject : NSManagedObject

/** @name Getting the Managed Object Context */

/** The main `NSManagedObjectContext` used for this class of object 
 
 @return an `NSManagedObjectContext
 */
+ (NSManagedObjectContext *)mainContext;

/** Whether this class currently has a main context
 
 @return a `BOOL` indicating whether this class currently has a main context
 */
+ (BOOL)hasMainContext;

/** @name Configuring the Persistent Store */

/** A shared persistent store coordinator for this class
 
 @return an `NSPersistentStoreCoordinator`
 */
+ (NSPersistentStoreCoordinator *)persistentStoreCoordinator;

/** Options to be used for this class's persistent store
 
 If these options haven't been set by the time the persistent store is initialised, 
 a set of defaults will be used.
 
 @return an `NSDictionary` of options for this persistent store
 */
+ (NSDictionary *)persistentStoreOptions;

/** Set options for the persistent store */
+ (void)setPersistentStoreOptions:(NSDictionary *)options;

/** The managed object model
 
 @return an `NSManagedObjectModel`
 */
+ (NSManagedObjectModel *)managedObjectModel;

/** Set the managed object model */
+ (void)setManagedObjectModel:(NSManagedObjectModel *)model;

/** The location of the persistent store
 
 @return an `NSURL` indicating the location of the store on disk
 */
+ (NSURL *)persistentStoreURL;

/** Set the persistent store's location */
+ (void)setPersistentStoreURL:(NSURL *)url;

/** @name  Getting Entity Information */

/** The entity's name in the data model
 
 It's intended that subclasses override this if they use a class prefix,
 otherwise it'll use the class's name.
 
 @return an `NSString` corresponding to the entity's name in the data model
 */
+ (NSString *)entityName;

/** The `NSEntityDescription` for this class, using the default context
 
 @return The `NSEntityDescription` for this class
 */
+ (NSEntityDescription *)entity;

/** The `NSEntityDescription` for this class, using a custom context
 
 @param context the `NSManagedObjectContext` to be used
 
 @return The `NSEntityDescription` for this class
 */
+ (NSEntityDescription *)entityWithContext:(NSManagedObjectContext *)context;

/** Default sort descriptors for use with this class 
 
 It's intended that subclasses override this to provide sensible sorting rules.
 
 @return an array of `NSSortDescriptor` objects
 */
+ (NSArray *)defaultSortDescriptors;

/** @name Creating New Objects */

/** Init a new object with a given context
 
 This method is the class's designated initialiser. Calling `init` on this class
 simply calls this method with the main context.
 
 @param context the `NSManagedObjectContext` to be used.
 
 @return a newly instantiated object
 */
- (instancetype)initWithContext:(NSManagedObjectContext *)context;

/** @name Saving Objects */

/** Save this object's managed object context */
- (void)save;

@end
