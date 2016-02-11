//
//  GeoJsonFeature.h
//  geo-monitor-demo
//
//  Created by Brandon Charity on 1/17/16.
//  Copyright © 2016 bac.fresh. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GeoJsonGeometry;
@class GeoJsonUsgsProperties;

@interface GeoJsonFeature : NSObject
@property (nonatomic, readonly, copy) NSString *geoJsonId;
@property (nonatomic, readonly) GeoJsonGeometry *geometry;
@property (nonatomic, readonly) GeoJsonUsgsProperties *properties;
- (instancetype)initWithInfo:(NSDictionary *)info;
@end
