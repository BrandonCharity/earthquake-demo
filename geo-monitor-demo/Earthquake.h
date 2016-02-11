//
//  Earthquake.h
//  geo-monitor-demo
//
//  Created by Brandon Charity on 1/17/16.
//  Copyright © 2016 bac.fresh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Position;

NS_ASSUME_NONNULL_BEGIN

@interface Earthquake : NSManagedObject

// Insert code here to declare functionality of your managed object subclass
+ (NSArray<Earthquake *> *)getEarthquakes:(NSManagedObjectContext *)moc;
+ (void)removeAllEarthquakes:(NSManagedObjectContext *)moc;
- (Position *)getPointPosition;
@end

NS_ASSUME_NONNULL_END

#import "Earthquake+CoreDataProperties.h"
