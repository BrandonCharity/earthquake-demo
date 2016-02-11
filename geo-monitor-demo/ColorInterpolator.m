//
//  ColorInterpolator.m
//  geo-monitor-demo
//
//  Created by Brandon Charity on 1/17/16.
//  Copyright © 2016 bac.fresh. All rights reserved.
//

#import "ColorInterpolator.h"

@interface ColorInterpolator ()
@property (nonatomic) NSMutableDictionary *firstColorDic;
@property (nonatomic) NSMutableDictionary *secondColorDic;
@property (nonatomic, assign) double numberOfSteps;
@end

@implementation ColorInterpolator

NSString * const RedKey = @"red";
NSString * const GreenKey = @"green";
NSString * const BlueKey = @"blue";
NSString * const AlphaKey = @"alpha";

- (instancetype)initWithFirstColor:(UIColor *)firstColor andSecondColor:(UIColor *)secondColor withStepNumber:(NSNumber *)stepNumber {
    self = [super init];
    if (self != nil) {
        self.firstColorDic = [NSMutableDictionary dictionary];
        self.secondColorDic = [NSMutableDictionary dictionary];
        CGFloat red = 0.0;
        CGFloat green = 0.0;
        CGFloat blue = 0.0;
        CGFloat alpha = 0.0;
        [firstColor getRed:&red green:&green blue:&blue alpha:&alpha];
        [self.firstColorDic setValue:[NSNumber numberWithDouble:red] forKey:RedKey];
        [self.firstColorDic setValue:[NSNumber numberWithDouble:green] forKey:GreenKey];
        [self.firstColorDic setValue:[NSNumber numberWithDouble:blue] forKey:BlueKey];
        [self.firstColorDic setValue:[NSNumber numberWithDouble:alpha] forKey:AlphaKey];
        [secondColor getRed:&red green:&green blue:&blue alpha:&alpha];
        [self.secondColorDic setValue:[NSNumber numberWithDouble:red] forKey:RedKey];
        [self.secondColorDic setValue:[NSNumber numberWithDouble:green] forKey:GreenKey];
        [self.secondColorDic setValue:[NSNumber numberWithDouble:blue] forKey:BlueKey];
        [self.secondColorDic setValue:[NSNumber numberWithDouble:alpha] forKey:AlphaKey];
        self.numberOfSteps = [stepNumber doubleValue];
    }
    return self;
}

- (UIColor *)getColorForStep:(NSNumber *)step {
    if ([step doubleValue] <= self.numberOfSteps && [step doubleValue] > 0.0) {
        double red = [[self getInterpolatedValueFromFirstValue:[self.firstColorDic valueForKey:RedKey] andSecondValue:[self.secondColorDic valueForKey:RedKey] atStep:step] doubleValue];
        double blue = [[self getInterpolatedValueFromFirstValue:[self.firstColorDic valueForKey:BlueKey] andSecondValue:[self.secondColorDic valueForKey:BlueKey] atStep:step] doubleValue];
        double green = [[self getInterpolatedValueFromFirstValue:[self.firstColorDic valueForKey:GreenKey] andSecondValue:[self.secondColorDic valueForKey:GreenKey] atStep:step] doubleValue];
        double alpha = [[self getInterpolatedValueFromFirstValue:[self.firstColorDic valueForKey:AlphaKey] andSecondValue:[self.secondColorDic valueForKey:AlphaKey] atStep:step] doubleValue];
        UIColor *interpolatedColor = [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
        return interpolatedColor;
    }
    else {
        return nil;
    }
}

- (NSNumber *)getInterpolatedValueFromFirstValue:(NSNumber *)firstValue andSecondValue:(NSNumber *)secondValue atStep:(NSNumber *)step {
    double stepVal = [step doubleValue] - 1.0;
    double adjustedNumberOfSteps = self.numberOfSteps - 1.0;
    double firstVal = [firstValue doubleValue];
    double secondVal = [secondValue doubleValue];
    double firstResult = firstVal * (1 - (stepVal / adjustedNumberOfSteps));
    double secondResult = secondVal * (stepVal / adjustedNumberOfSteps);
    double result = firstResult + secondResult;
    return [NSNumber numberWithDouble:result];
}

@end
