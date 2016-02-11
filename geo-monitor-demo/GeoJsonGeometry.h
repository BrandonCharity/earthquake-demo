//
//  GeoJsonGeometry.h
//  geo-monitor-demo
//
//  Created by Brandon Charity on 1/17/16.
//  Copyright © 2016 bac.fresh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GeoJsonGeometry : NSObject
@property (nonatomic, readonly, copy) NSString *geometryType;
@property (nonatomic, readonly, copy) NSString *geoJsonId;
@property (nonatomic, readonly, copy) NSArray<NSNumber *> *coordinates;
- (instancetype)initWithInfo:(NSDictionary *)info;
@end
