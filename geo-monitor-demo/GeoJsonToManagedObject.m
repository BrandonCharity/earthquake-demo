//
//  GeoJsonToManagedObject.m
//  geo-monitor-demo
//
//  Created by Brandon Charity on 1/17/16.
//  Copyright © 2016 bac.fresh. All rights reserved.
//

#import "CoreDataManager.h"
#import "Earthquake.h"
#import "GeoJsonFeature.h"
#import "GeoJsonGeometry.h"
#import "GeoJsonKeys.h"
#import "GeoJsonUsgsProperties.h"
#import "GeoJsonToManagedObject.h"
#import "Position.h"

@implementation GeoJsonToManagedObject

+ (Earthquake *)featureToEarthquake:(GeoJsonFeature *)feature {
    Earthquake *eq = [NSEntityDescription insertNewObjectForEntityForName:@"Earthquake" inManagedObjectContext:[[CoreDataManager sharedInstance] mainUIContext]];
    if ([feature.properties.magnitude doubleValue] < 0) {
        eq.magnitude = @0;
    }
    else {
        eq.magnitude = feature.properties.magnitude;
    }
    eq.location = feature.properties.place;
    eq.occurrenceDate = feature.properties.time;
    eq.updated = feature.properties.updated;
    eq.usgsId = feature.geoJsonId;
    if ([feature.geometry.geometryType isEqualToString:GeoJsonPointKey]) {
        Position *pos = [NSEntityDescription insertNewObjectForEntityForName:@"Position" inManagedObjectContext:[[CoreDataManager sharedInstance] mainUIContext]];
        pos.longitude = feature.geometry.coordinates[0];
        pos.latitude = feature.geometry.coordinates[1];
        pos.depth = feature.geometry.coordinates[2];
        [eq addCoordinatesObject:pos];
    }
    return eq;
}

@end
