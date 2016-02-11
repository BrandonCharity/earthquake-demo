//
//  EqInfoViewController.h
//  geo-monitor-demo
//
//  Created by Brandon Charity on 1/17/16.
//  Copyright © 2016 bac.fresh. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Earthquake;

@interface EqInfoViewController : UIViewController
- (instancetype)initWithEarthquake:(Earthquake *)eq;
@end
