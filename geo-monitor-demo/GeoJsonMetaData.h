//
//  GeoJsonMetaData.h
//  geo-monitor-demo
//
//  Created by Brandon Charity on 1/19/16.
//  Copyright © 2016 bac.fresh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GeoJsonMetaData : NSObject
@property (nonatomic, readonly, copy) NSString *title;
- (instancetype)initWithInfo:(NSDictionary *)info;
@end
