//
//  EqInfoTableViewCell.m
//  geo-monitor-demo
//
//  Created by Brandon Charity on 1/18/16.
//  Copyright © 2016 bac.fresh. All rights reserved.
//

#import "EqInfoTableViewCell.h"

@implementation EqInfoTableViewCell

- (void)prepareForReuse {
    self.keyLbl.text = @"";
    self.valueLbl.text = @"";
}

@end
