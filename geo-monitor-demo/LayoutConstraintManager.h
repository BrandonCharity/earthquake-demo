//
//  LayoutConstraintManager.h
//  geo-monitor-demo
//
//  Created by Brandon Charity on 1/18/16.
//  Copyright © 2016 bac.fresh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LayoutConstraintManager : NSObject

//install constraints
+ (void)matchChild:(UIView *)childView withParent:(UIView *)parentView;
+ (void)stickView:(UIView *)childView toParentViewBottom:(UIView *)parentView;
+ (void)stickView:(UIView *)childView toParentViewTop:(UIView *)parentView;
+ (void)stickView:(UIView *)childView toParentViewRight:(UIView *)parentView;
+ (void)stickView:(UIView *)childView toParentViewLeft:(UIView *)parentView;
+ (void)setView:(UIView *)view belowView:(UIView *)otherView withParentView:(UIView *)parentView;
+ (void)setView:(UIView *)view aboveView:(UIView *)otherView withParentView:(UIView *)parentView;
+ (void)setView:(UIView *)view leftOfView:(UIView *)otherView withParentView:(UIView *)parentView;
+ (void)setView:(UIView *)view rightOfView:(UIView *)otherView withParentView:(UIView *)parentView;
+ (void)setHeight:(double)height ofView:(UIView *)view;
+ (void)setWidth:(double)width ofView:(UIView *)view;

@end
