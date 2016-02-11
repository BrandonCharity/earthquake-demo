//
//  GeoJsonMetaData.m
//  geo-monitor-demo
//
//  Created by Brandon Charity on 1/19/16.
//  Copyright © 2016 bac.fresh. All rights reserved.
//

#import "GeoJsonMetaData.h"
#import "GeoJsonKeys.h"

@implementation GeoJsonMetaData
- (instancetype)initWithInfo:(NSDictionary *)info
{
    self = [super init];
    if (self) {
        if ([info valueForKey:GeoJsonTitleKey] != nil && [info valueForKey:GeoJsonTitleKey] != [NSNull null] && ![[info valueForKey:GeoJsonTitleKey] isEqualToString:@""]) {
            _title = [info valueForKey:GeoJsonTitleKey];
        }
    }
    return self;
}
@end
