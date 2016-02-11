//
//  GeoJsonFeature.m
//  geo-monitor-demo
//
//  Created by Brandon Charity on 1/17/16.
//  Copyright © 2016 bac.fresh. All rights reserved.
//

#import "GeoJsonFeature.h"
#import "GeoJsonGeometry.h"
#import "GeoJsonUsgsProperties.h"
#import "GeoJsonKeys.h"

@implementation GeoJsonFeature

- (instancetype)initWithInfo:(NSDictionary *)info
{
    self = [super init];
    if (self) {
        if ([info valueForKey:GeoJsonIdKey] != nil && [info valueForKey:GeoJsonIdKey] != [NSNull null] && ![[info valueForKey:GeoJsonIdKey] isEqualToString:@""]) {
            _geoJsonId = [info valueForKey:GeoJsonIdKey];
        }
        if ([info valueForKey:GeoJsonGeometryKey] != nil && [info valueForKey:GeoJsonGeometryKey] != [NSNull null]) {
            NSDictionary *geometryInfo = [info valueForKey:GeoJsonGeometryKey];
            _geometry = [[GeoJsonGeometry alloc] initWithInfo:geometryInfo];
            
        }
        if ([info valueForKey:GeoJsonPropertiesKey] != nil && [info valueForKey:GeoJsonPropertiesKey] != [NSNull null]) {
            NSDictionary *propertiesInfo = [info valueForKey:GeoJsonPropertiesKey];
            _properties = [[GeoJsonUsgsProperties alloc] initWithInfo:propertiesInfo];
        }
    }
    return self;
}

@end
