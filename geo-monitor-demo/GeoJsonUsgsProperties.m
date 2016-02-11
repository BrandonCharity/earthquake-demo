//
//  GeoJsonUsgsProperties.m
//  geo-monitor-demo
//
//  Created by Brandon Charity on 1/17/16.
//  Copyright © 2016 bac.fresh. All rights reserved.
//

#import "GeoJsonUsgsProperties.h"
#import "GeoJsonKeys.h"
#import "UsgsKeys.h"

@implementation GeoJsonUsgsProperties
- (instancetype)initWithInfo:(NSDictionary *)info
{
    self = [super init];
    if (self) {
        if ([info valueForKey:UsgsMagnitudeKey] != nil && [info valueForKey:UsgsMagnitudeKey] != [NSNull null]) {
            _magnitude = [info valueForKey:UsgsMagnitudeKey];
        }
        if ([info valueForKey:UsgsPlaceKey] != nil && [info valueForKey:UsgsPlaceKey] != [NSNull null] && ![[info valueForKey:UsgsPlaceKey] isEqualToString:@""]) {
            _place = [info valueForKey:UsgsPlaceKey];
        }
        if ([info valueForKey:UsgsUpdatedKey] != nil && [info valueForKey:UsgsUpdatedKey] != [NSNull null]) {
            NSTimeInterval timeInterval = [[info valueForKey:UsgsUpdatedKey] longLongValue] / 1000;
            NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
            _updated = date;
        }
        if ([info valueForKey:UsgsTimeKey] != nil && [info valueForKey:UsgsTimeKey] != [NSNull null]) {
            NSTimeInterval timeInterval = [[info valueForKey:UsgsTimeKey] longLongValue] / 1000;
            NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
            _time = date;
        }
        if ([info valueForKey:UsgsDetailKey] != nil && [info valueForKey:UsgsDetailKey] != [NSNull null] && ![[info valueForKey:UsgsDetailKey] isEqualToString:@""]) {
            _detail = [NSURL URLWithString:[info valueForKey:UsgsDetailKey]];
        }
    }
    return self;
}
@end
