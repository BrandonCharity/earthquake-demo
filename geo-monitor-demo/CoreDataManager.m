//
//  CoreDataManager.h
//  geo-monitor-demo
//
//  Created by Brandon Charity on 1/17/16.
//  Copyright © 2016 bac.fresh. All rights reserved.
//

#import "CoreDataManager.h"

@implementation CoreDataManager {
    NSManagedObjectContext *storeConnectedContext;
    NSManagedObjectModel *managedObjectModel;
    NSPersistentStoreCoordinator *persistentStoreCoordinator;
}

@synthesize mainUIContext;

+ (instancetype)sharedInstance {
    static CoreDataManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init {
    if (self = [super init]) {
        //managed object model
        NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"geo_monitor_demo" withExtension:@"momd"];
        managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
        
        //persistent store coordinator
        persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:managedObjectModel];
        NSURL *url = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
        NSURL *storeURL = [url URLByAppendingPathComponent:@"geo_monitor_demo.sqlite"];
        NSError *error = nil;
        NSString *failureReason = @"There was an error creating or loading the application's saved data.";
        
        error = nil;
        if (![self progressivelyMigrate:storeURL
                                    ofType:NSSQLiteStoreType
                                   toModel:[persistentStoreCoordinator managedObjectModel]
                                     error:&error]) {
            NSLog(@"Error performing migration: %@\n%@\n Trying lightweight migration...", [error localizedDescription], [error userInfo]);
            
            //Try the light weight migration
            NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
            
            if (![persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:options error:&error]) {
                // Report any error we got.
                NSMutableDictionary *dict = [NSMutableDictionary dictionary];
                dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
                dict[NSLocalizedFailureReasonErrorKey] = failureReason;
                dict[NSUnderlyingErrorKey] = error;
                error = [NSError errorWithDomain:@"Migration" code:9999 userInfo:dict];
                // Replace this with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
                abort();
            }
        }
        else {
            if (![persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
                // Report any error we got.
                NSMutableDictionary *dict = [NSMutableDictionary dictionary];
                dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
                dict[NSLocalizedFailureReasonErrorKey] = failureReason;
                dict[NSUnderlyingErrorKey] = error;
                error = [NSError errorWithDomain:@"Migration" code:9999 userInfo:dict];
                // Replace this with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
                abort();
            }
        }
        
        //managed object contexts
        storeConnectedContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
        [storeConnectedContext setPersistentStoreCoordinator:persistentStoreCoordinator];
        mainUIContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        [mainUIContext setParentContext:storeConnectedContext];
    }
    return self;
}

- (BOOL)progressivelyMigrate:(NSURL*)sourceStoreURL
                      ofType:(NSString*)type
                     toModel:(NSManagedObjectModel*)finalModel
                       error:(NSError**)error {
    
    NSDictionary *sourceMetadata = [NSPersistentStoreCoordinator metadataForPersistentStoreOfType:type URL:sourceStoreURL error:error];
    if (!sourceMetadata) {
        return NO;
    }
    if ([finalModel isConfiguration:nil compatibleWithStoreMetadata:sourceMetadata]) {
        *error = nil;
        return YES;
    }
    
    NSManagedObjectModel *sourceModel = [NSManagedObjectModel mergedModelFromBundles:nil forStoreMetadata:sourceMetadata];
    NSAssert(sourceModel != nil, ([NSString stringWithFormat:@"Failed to find source model\n%@", sourceMetadata]));
    //Find all of the mom and momd files in the Resources directory
    NSMutableArray *modelPaths = [NSMutableArray array];
    NSArray *momdArray = [[NSBundle mainBundle] pathsForResourcesOfType:@"momd" inDirectory:nil];
    for (NSString *momdPath in momdArray) {
        NSString *resourceSubpath = [momdPath lastPathComponent];
        NSArray *array = [[NSBundle mainBundle] pathsForResourcesOfType:@"mom" inDirectory:resourceSubpath];
        [modelPaths addObjectsFromArray:array];
    }
    NSArray* otherModels = [[NSBundle mainBundle] pathsForResourcesOfType:@"mom" inDirectory:nil];
    [modelPaths addObjectsFromArray:otherModels];
    if (!modelPaths || ![modelPaths count]) {
        //Throw an error if there are no models
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setValue:@"No models found in bundle" forKey:NSLocalizedDescriptionKey];
        //Populate the error
        *error = [NSError errorWithDomain:@"Migration" code:8001 userInfo:dict];
        return NO;
    }
    
    //See if we can find a matching destination model
    NSMappingModel *mappingModel = nil;
    NSManagedObjectModel *targetModel = nil;
    NSString *modelPath = nil;
    for (modelPath in modelPaths) {
        targetModel = [[NSManagedObjectModel alloc]
                       initWithContentsOfURL:[NSURL fileURLWithPath:modelPath]];
        mappingModel = [NSMappingModel mappingModelFromBundles:nil
                                                forSourceModel:sourceModel
                                              destinationModel:targetModel];
        //If we found a mapping model then proceed
        if (mappingModel) {
            break;
        }
        
        //Release the target model and keep looking
        targetModel = nil;
    }
    
    //We have tested every model, if nil here we failed
    if (!mappingModel) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setValue:@"No mapping models found in bundle" forKey:NSLocalizedDescriptionKey];
        *error = [NSError errorWithDomain:@"Migration" code:8001 userInfo:dict];
        return NO;
    }
    
    //We have a mapping model and a destination model.  Time to migrate
    NSMigrationManager *manager = [[NSMigrationManager alloc] initWithSourceModel:sourceModel destinationModel:targetModel];
    NSString *modelName = [[modelPath lastPathComponent] stringByDeletingPathExtension];
    NSString *storeExtension = [[sourceStoreURL path] pathExtension];
    NSString *storePath = [[sourceStoreURL path] stringByDeletingPathExtension];
    
    //Build a path to write the new store
    storePath = [NSString stringWithFormat:@"%@.%@.%@", storePath, modelName, storeExtension];
    NSURL *destinationStoreURL = [NSURL fileURLWithPath:storePath];
    if (![manager migrateStoreFromURL:sourceStoreURL
                                 type:type
                              options:nil
                     withMappingModel:mappingModel
                     toDestinationURL:destinationStoreURL
                      destinationType:type
                   destinationOptions:nil
                                error:error]) {
        return NO;
    }
    
    //Migration was successful, move the files around to preserve the source
    NSString *guid = [[NSProcessInfo processInfo] globallyUniqueString];
    guid = [guid stringByAppendingPathExtension:modelName];
    guid = [guid stringByAppendingPathExtension:storeExtension];
    NSString *appSupportPath = [storePath stringByDeletingLastPathComponent];
    NSString *backupPath = [appSupportPath stringByAppendingPathComponent:guid];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager moveItemAtPath:[sourceStoreURL path]
                              toPath:backupPath
                               error:error]) {
        //Failed to copy the file
        return NO;
    }
    //Move the destination to the source path
    if (![fileManager moveItemAtPath:storePath
                              toPath:[sourceStoreURL path]
                               error:error]) {
        //Try to back out the source move first, no point in checking it for errors
        [fileManager moveItemAtPath:backupPath
                             toPath:[sourceStoreURL path]
                              error:nil];
        return NO;
    }
    //We may not be at the "current" model yet, so recurse
    return [self progressivelyMigrate:sourceStoreURL
                                  ofType:type
                                 toModel:finalModel
                                   error:error];
}

- (NSManagedObjectContext*)getTempManagedObjectContext {
    NSManagedObjectContext *childMoc = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    [childMoc setParentContext:[self mainUIContext]];
    return childMoc;
}

- (NSArray*)getManagedObjectsByIDsForContext:(NSManagedObjectContext*)moc entityName:(NSString*)entity managedObjectsIDs:(NSArray*)moIDs {
    NSPredicate *mainPredicate = [NSPredicate predicateWithFormat:@"self IN %@", moIDs];
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:entity];
    request.predicate = mainPredicate;
    NSError *error;
    NSArray *finalResults = [moc executeFetchRequest:request error:&error];
    if (error)
    {
        NSLog(@"Unresolved error when fetching managed objects: %@, %@", error, [error userInfo]);
    }
    return finalResults;
}

- (NSArray*)getManagedObjectIDs:(NSArray*)managedObjects {
    NSMutableArray *managedObjectIDs = [[NSMutableArray alloc] initWithCapacity:[managedObjects count]];
    for (int i = 0; i < [managedObjects count]; i++) {
        NSManagedObject *mo = managedObjects[i];
        [managedObjectIDs addObject:[mo objectID]];
    }
    return [managedObjectIDs copy];
}

- (void)saveToDiskAsync:(NSManagedObjectContext*)managedObjectContext completionBlock:(completion)completion {
    if (![managedObjectContext isEqual:mainUIContext]) {
        [managedObjectContext performBlock:^{
            NSError *error;
            if ([managedObjectContext save:&error])
            {
                [self saveMainUIContext:managedObjectContext completion:completion];
            }
            else
            {
                NSLog(@"Unresolved error for child context: %@, %@", error, [error userInfo]);
                [managedObjectContext performBlock:^{
                    if (completion != nil) {
                        completion(NO);
                    }
                }];
            }
        }];
    }
    else
    {
        [self saveMainUIContext:managedObjectContext completion:completion];
    }
}

- (void)saveMainUIContext:(NSManagedObjectContext*)moc completion:(completion)completion {
    [mainUIContext performBlock:^{
        NSError *error;
        if ([mainUIContext save:&error])
        {
            [storeConnectedContext performBlock:^{
                NSError *error;
                if (![storeConnectedContext save:&error])
                {
                    NSLog(@"Unresolved error for store connected context: %@, %@", error, [error userInfo]);
                    [moc performBlock:^{
                        if (completion != nil) {
                            completion(NO);
                        }
                    }];
                }
                else
                {
                    [moc performBlock:^{
                        if (completion != nil) {
                            completion(YES);
                        }
                    }];
                }
            }];
        }
        else
        {
            NSLog(@"Unresolved error for main ui context: %@, %@", error, [error userInfo]);
            [moc performBlock:^{
                if (completion != nil) {
                    completion(NO);
                }
            }];
        }
    }];
}

- (NSDictionary*)convertManagedObjectToDictionary:(NSManagedObject*)mo {
    NSArray *keys = [[[mo entity] attributesByName] allKeys];
    NSDictionary *dict = [mo dictionaryWithValuesForKeys:keys];
    return dict;
}

@end
