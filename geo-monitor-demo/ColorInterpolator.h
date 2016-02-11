//
//  ColorInterpolator.h
//  geo-monitor-demo
//
//  Created by Brandon Charity on 1/17/16.
//  Copyright © 2016 bac.fresh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ColorInterpolator : NSObject
- (instancetype)initWithFirstColor:(UIColor *)firstColor andSecondColor:(UIColor *)secondColor withStepNumber:(NSNumber *)stepNumber;
- (UIColor *)getColorForStep:(NSNumber *)step;
@end
