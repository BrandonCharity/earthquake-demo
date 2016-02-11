//
//  Earthquake.m
//  geo-monitor-demo
//
//  Created by Brandon Charity on 1/17/16.
//  Copyright © 2016 bac.fresh. All rights reserved.
//

#import "Earthquake.h"
#import "Position.h"

@implementation Earthquake

// Insert code here to add functionality to your managed object subclass
+ (NSArray<Earthquake *> *)getEarthquakes:(NSManagedObjectContext *)moc {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Earthquake"];
    NSSortDescriptor *sortDesc = [[NSSortDescriptor alloc] initWithKey:@"occurrenceDate" ascending:NO];
    [fetchRequest setSortDescriptors:@[sortDesc]];
    [fetchRequest setReturnsObjectsAsFaults:NO];
    [fetchRequest setRelationshipKeyPathsForPrefetching:@[@"coordinates"]];
    NSError *error;
    NSArray *results = [moc executeFetchRequest:fetchRequest error:&error];
    if (error != nil) {
        NSLog(@"Error occurred fetching earthquakes.  Error: %@", [error description]);
    }
    return results;
}

+ (void)removeAllEarthquakes:(NSManagedObjectContext *)moc {
    NSArray<Earthquake *> *eqs = [Earthquake getEarthquakes:moc];
    if (eqs.count > 0) {
        for (int i = 0; i < eqs.count; i++) {
            [moc deleteObject:eqs[i]];
        }
    }
}

- (Position *)getPointPosition {
    if (self.coordinates != nil && self.coordinates.count > 0) {
        return self.coordinates.allObjects[0];
    }
    else {
        return nil;
    }
}

@end
