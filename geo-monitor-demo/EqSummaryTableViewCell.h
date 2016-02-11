//
//  EqSummaryTableViewCell.h
//  geo-monitor-demo
//
//  Created by Brandon Charity on 1/17/16.
//  Copyright © 2016 bac.fresh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EqSummaryTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *locationLbl;
@property (weak, nonatomic) IBOutlet UILabel *magnitudeLbl;
@property (weak, nonatomic) IBOutlet UIImageView *detailImgView;
@end
