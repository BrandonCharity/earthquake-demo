//
//  Position+CoreDataProperties.h
//  geo-monitor-demo
//
//  Created by Brandon Charity on 1/18/16.
//  Copyright © 2016 bac.fresh. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Position.h"

NS_ASSUME_NONNULL_BEGIN

@interface Position (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *longitude;
@property (nullable, nonatomic, retain) NSNumber *latitude;
@property (nullable, nonatomic, retain) NSNumber *depth;
@property (nullable, nonatomic, retain) Earthquake *earthquake;

@end

NS_ASSUME_NONNULL_END
