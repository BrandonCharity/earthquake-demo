//
//  MagnitudeColorCoder.m
//  geo-monitor-demo
//
//  Created by Brandon Charity on 1/17/16.
//  Copyright © 2016 bac.fresh. All rights reserved.
//

#import "ColorInterpolator.h"
#import "MagnitudeColorCoder.h"

@interface MagnitudeColorCoder ()
@property (nonatomic) UIColor *firstColor;
@property (nonatomic) UIColor *secondColor;
@property (nonatomic) ColorInterpolator *interpolator;
@end

@implementation MagnitudeColorCoder

- (instancetype)initWithFirstColor:(UIColor *)firstColor andSecondColor:(UIColor *)secondColor {
    self = [super init];
    if (self != nil) {
        self.firstColor = firstColor;
        self.secondColor = secondColor;
        self.interpolator = [[ColorInterpolator alloc] initWithFirstColor:firstColor andSecondColor:secondColor withStepNumber:@10];
    }
    return self;
}

- (UIColor *)getColorForMagnitude:(NSNumber *)magnitude {
    NSNumber *step = [self getStepFromMagnitude:magnitude];
    return [self.interpolator getColorForStep:step];
}

- (NSNumber *)getStepFromMagnitude:(NSNumber *)magnitude {
    return [NSNumber numberWithDouble:floor([magnitude doubleValue]) + 1.0];
}

@end
