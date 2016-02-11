//
//  CoreDataManager.h
//  geo-monitor-demo
//
//  Created by Brandon Charity on 1/17/16.
//  Copyright © 2016 bac.fresh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

typedef void(^completion)(BOOL completed);

@interface CoreDataManager : NSObject
@property (nonatomic, readonly) NSManagedObjectContext *mainUIContext;
+ (id)sharedInstance;
- (void)saveToDiskAsync:(NSManagedObjectContext*)managedObjectContext completionBlock:(completion)completion;
- (NSManagedObjectContext*)getTempManagedObjectContext;
- (NSArray*)getManagedObjectIDs:(NSArray*)managedObjects;
- (NSArray*)getManagedObjectsByIDsForContext:(NSManagedObjectContext*)moc entityName:(NSString*)entity managedObjectsIDs:(NSArray*)moIDs;
- (NSDictionary*)convertManagedObjectToDictionary:(NSManagedObject*)mo;
@end
