//
//  GeoJsonGeometry.m
//  geo-monitor-demo
//
//  Created by Brandon Charity on 1/17/16.
//  Copyright © 2016 bac.fresh. All rights reserved.
//

#import "GeoJsonGeometry.h"
#import "GeoJsonKeys.h"

@implementation GeoJsonGeometry

- (instancetype)initWithInfo:(NSDictionary *)info
{
    self = [super init];
    if (self) {
        if ([info valueForKey:GeoJsonTypeKey] != nil && [info valueForKey:GeoJsonTypeKey] != [NSNull null] && ![[info valueForKey:GeoJsonTypeKey] isEqualToString:@""] && [self isValidGeometryType:[info valueForKey:GeoJsonTypeKey]]) {
            _geometryType = [info valueForKey:GeoJsonTypeKey];
        }
        if ([info valueForKey:GeoJsonIdKey] != nil && [info valueForKey:GeoJsonIdKey] != [NSNull null] && ![[info valueForKey:GeoJsonIdKey] isEqualToString:@""]) {
            _geoJsonId = [info valueForKey:GeoJsonIdKey];
        }
        if ([info valueForKey:GeoJsonCoordinatesKey] != nil && [info valueForKey:GeoJsonCoordinatesKey] != [NSNull null]) {
            NSArray *coordinates = [info valueForKey:GeoJsonCoordinatesKey];
            _coordinates = coordinates;
        }
    }
    return self;
}

- (BOOL)isValidGeometryType:(NSString*)type {
    if ([@[
           GeoJsonPointKey,
           GeoJsonMultiPointKey,
           GeoJsonLineKey,
           GeoJsonMultiLineKey,
           GeoJsonPolygonKey,
           GeoJsonMultiPolygonKey
           ] containsObject:type]) {
        return YES;
    }
    else {
        return NO;
    }
}

@end
