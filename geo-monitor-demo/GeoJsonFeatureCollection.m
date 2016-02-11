//
//  GeoJsonFeatureCollection.m
//  geo-monitor-demo
//
//  Created by Brandon Charity on 1/17/16.
//  Copyright © 2016 bac.fresh. All rights reserved.
//

#import "GeoJsonFeatureCollection.h"
#import "GeoJsonFeature.h"
#import "GeoJsonKeys.h"
#import "GeoJsonMetaData.h"

@implementation GeoJsonFeatureCollection

- (instancetype)initWithInfo:(NSDictionary *)info
{
    self = [super init];
    if (self) {
        if ([info valueForKey:GeoJsonIdKey] != nil && [info valueForKey:GeoJsonIdKey] != [NSNull null] && ![[info valueForKey:GeoJsonIdKey] isEqualToString:@""]) {
            _geoJsonId = [info valueForKey:GeoJsonIdKey];
        }
        if ([info valueForKey:GeoJsonMetaDataKey] != nil && [info valueForKey:GeoJsonMetaDataKey] != [NSNull null]) {
            _metadata = [[GeoJsonMetaData alloc] initWithInfo:[info valueForKey:GeoJsonMetaDataKey]];
        }
        if ([info valueForKey:GeoJsonFeaturesKey] != nil && [info valueForKey:GeoJsonFeaturesKey] != [NSNull null]) {
            NSArray *features = [info valueForKey:GeoJsonFeaturesKey];
            NSMutableArray *featureCollection = [[NSMutableArray alloc] initWithCapacity:[features count]];
            for (int i = 0; i < [features count]; i++) {
                [featureCollection addObject:[[GeoJsonFeature alloc] initWithInfo:[features objectAtIndex:i]]];
            }
            _features = featureCollection;
        }
    }
    return self;
}

@end
