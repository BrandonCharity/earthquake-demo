//
//  EqAnnotation.h
//  geo-monitor-demo
//
//  Created by Brandon Charity on 1/18/16.
//  Copyright © 2016 bac.fresh. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface EqAnnotation : NSObject <MKAnnotation>
@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic, readonly, copy) NSString *title;
@property (nonatomic, readonly, copy) NSString *location;
- (instancetype)initWithLocation:(NSString *)location andCoordinate:(CLLocationCoordinate2D)coordinate;
@end
