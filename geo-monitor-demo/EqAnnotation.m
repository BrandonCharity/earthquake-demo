//
//  EqAnnotation.m
//  geo-monitor-demo
//
//  Created by Brandon Charity on 1/18/16.
//  Copyright © 2016 bac.fresh. All rights reserved.
//

#import "EqAnnotation.h"

@implementation EqAnnotation

- (instancetype)initWithLocation:(NSString *)location andCoordinate:(CLLocationCoordinate2D)coordinate {
    self = [super init];
    if (self != nil) {
        _location = location;
        _title = location;
        _coordinate = coordinate;
    }
    return self;
}

@end
