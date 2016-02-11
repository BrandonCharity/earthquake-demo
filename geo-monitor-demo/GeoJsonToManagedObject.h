//
//  GeoJsonToManagedObject.h
//  geo-monitor-demo
//
//  Created by Brandon Charity on 1/17/16.
//  Copyright © 2016 bac.fresh. All rights reserved.
//

@class GeoJsonFeature;

@interface GeoJsonToManagedObject : NSObject
+ (Earthquake*)featureToEarthquake:(GeoJsonFeature *)feature;
@end
