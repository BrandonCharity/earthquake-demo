//
//  Earthquake+CoreDataProperties.h
//  geo-monitor-demo
//
//  Created by Brandon Charity on 1/18/16.
//  Copyright © 2016 bac.fresh. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Earthquake.h"

NS_ASSUME_NONNULL_BEGIN

@interface Earthquake (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *magnitude;
@property (nullable, nonatomic, retain) NSDate *occurrenceDate;
@property (nullable, nonatomic, retain) NSString *location;
@property (nullable, nonatomic, retain) NSDate *updated;
@property (nullable, nonatomic, retain) NSString *usgsId;
@property (nullable, nonatomic, retain) NSSet<Position *> *coordinates;

@end

@interface Earthquake (CoreDataGeneratedAccessors)

- (void)addCoordinatesObject:(Position *)value;
- (void)removeCoordinatesObject:(Position *)value;
- (void)addCoordinates:(NSSet<Position *> *)values;
- (void)removeCoordinates:(NSSet<Position *> *)values;

@end

NS_ASSUME_NONNULL_END
