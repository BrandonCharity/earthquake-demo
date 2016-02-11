//
//  GeoJsonUsgsProperties.h
//  geo-monitor-demo
//
//  Created by Brandon Charity on 1/17/16.
//  Copyright © 2016 bac.fresh. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface GeoJsonUsgsProperties : NSObject
@property (nonatomic, readonly) NSNumber *magnitude;
@property (nonatomic, readonly, copy) NSString *place;
@property (nonatomic, readonly) NSDate *time;
@property (nonatomic, readonly) NSDate *updated;
@property (nonatomic, readonly) NSURL *detail;
- (instancetype)initWithInfo:(NSDictionary *)info;
@end
