//
//  LayoutConstraintManager.m
//  geo-monitor-demo
//
//  Created by Brandon Charity on 1/18/16.
//  Copyright © 2016 bac.fresh. All rights reserved.
//

#import "LayoutConstraintManager.h"

//iOS 9.0 supports anchors and dimensions, but want to still support iOS 8.0
@implementation LayoutConstraintManager

+ (void)matchChild:(UIView *)childView withParent:(UIView *)parentView {
    if (childView != nil && parentView != nil) {
        NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:childView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:parentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0];
        NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:childView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:parentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0];
        NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:childView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:parentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.0];
        NSLayoutConstraint *right = [NSLayoutConstraint constraintWithItem:childView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:parentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.0];
        [parentView addConstraints:@[top, bottom, left, right]];
    }
}

+ (void)setView:(UIView *)view belowView:(UIView *)otherView withParentView:(UIView *)parentView {
    if (view != nil && otherView != nil && parentView != nil) {
        NSLayoutConstraint *below = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:otherView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0];
        [parentView addConstraint:below];
    }
}

+ (void)setView:(UIView *)view aboveView:(UIView *)otherView withParentView:(UIView *)parentView {
    if (view != nil && otherView != nil && parentView != nil) {
        NSLayoutConstraint *above = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:otherView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0];
        [parentView addConstraint:above];
    }
}

+ (void)setView:(UIView *)view leftOfView:(UIView *)otherView withParentView:(UIView *)parentView {
    if (view != nil && otherView != nil && parentView != nil) {
        NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:otherView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.0];
        [parentView addConstraint:left];
    }
}

+ (void)setView:(UIView *)view rightOfView:(UIView *)otherView withParentView:(UIView *)parentView {
    if (view != nil && otherView != nil && parentView != nil) {
        NSLayoutConstraint *right = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:otherView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.0];
        [parentView addConstraint:right];
    }
}

+ (void)stickView:(UIView *)childView toParentViewBottom:(UIView *)parentView {
    if (childView != nil && parentView != nil) {
        NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:childView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:parentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0];
        NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:childView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:parentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.0];
        NSLayoutConstraint *right = [NSLayoutConstraint constraintWithItem:childView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:parentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.0];
        [parentView addConstraints:@[bottom, left, right]];
    }
}

+ (void)stickView:(UIView *)childView toParentViewTop:(UIView *)parentView {
    if (childView != nil && parentView != nil) {
        NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:childView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:parentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0];
        NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:childView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:parentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.0];
        NSLayoutConstraint *right = [NSLayoutConstraint constraintWithItem:childView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:parentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.0];
        [parentView addConstraints:@[top, left, right]];
    }
}

+ (void)stickView:(UIView *)childView toParentViewLeft:(UIView *)parentView {
    if (childView != nil && parentView != nil) {
        NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:childView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:parentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0];
        NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:childView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:parentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.0];
        NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:childView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:parentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0];
        [parentView addConstraints:@[top, left, bottom]];
    }
}

+ (void)stickView:(UIView *)childView toParentViewRight:(UIView *)parentView {
    if (childView != nil && parentView != nil) {
        NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:childView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:parentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0];
        NSLayoutConstraint *right = [NSLayoutConstraint constraintWithItem:childView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:parentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.0];
        NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:childView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:parentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0];
        [parentView addConstraints:@[top, right, bottom]];
    }
}

+ (void)setHeight:(double)height ofView:(UIView *)view {
    if (view != nil && height > 0) {
        NSLayoutConstraint *heightCon = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
        [view addConstraint:heightCon];
    }
}

+ (void)setWidth:(double)width ofView:(UIView *)view {
    if (view != nil && width > 0) {
        NSLayoutConstraint *widthCon = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width];
        [view addConstraint:widthCon];
    }
}

@end
