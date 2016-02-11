//
//  MagnitudeColorCoder.h
//  geo-monitor-demo
//
//  Created by Brandon Charity on 1/17/16.
//  Copyright © 2016 bac.fresh. All rights reserved.
//

@interface MagnitudeColorCoder : NSObject
- (instancetype)initWithFirstColor:(UIColor *)firstColor andSecondColor:(UIColor *)secondColor;
- (UIColor *)getColorForMagnitude:(NSNumber *)magnitude;
@end
