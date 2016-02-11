//
//  EqSummaryTableViewCell.m
//  geo-monitor-demo
//
//  Created by Brandon Charity on 1/17/16.
//  Copyright © 2016 bac.fresh. All rights reserved.
//

#import "EqSummaryTableViewCell.h"

@implementation EqSummaryTableViewCell

- (void)prepareForReuse {
    [super prepareForReuse];
    self.locationLbl.text = @"";
    self.magnitudeLbl.text = @"";
    self.detailImgView = nil;
}

@end
