//
//  GeoJsonFeatureCollection.h
//  geo-monitor-demo
//
//  Created by Brandon Charity on 1/17/16.
//  Copyright © 2016 bac.fresh. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GeoJsonMetaData;
@class GeoJsonFeature;

@interface GeoJsonFeatureCollection : NSObject
@property (nonatomic, readonly, copy) NSString *geoJsonId;
@property (nonatomic, readonly) GeoJsonMetaData *metadata;
@property (nonatomic, readonly, copy) NSArray<GeoJsonFeature *> *features;
- (instancetype)initWithInfo:(NSDictionary *)info;
@end
