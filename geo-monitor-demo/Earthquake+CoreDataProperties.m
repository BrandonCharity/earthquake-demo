//
//  Earthquake+CoreDataProperties.m
//  geo-monitor-demo
//
//  Created by Brandon Charity on 1/18/16.
//  Copyright © 2016 bac.fresh. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Earthquake+CoreDataProperties.h"

@implementation Earthquake (CoreDataProperties)

@dynamic magnitude;
@dynamic occurrenceDate;
@dynamic location;
@dynamic updated;
@dynamic usgsId;
@dynamic coordinates;

@end
