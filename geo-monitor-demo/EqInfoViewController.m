//
//  EqInfoViewController.m
//  geo-monitor-demo
//
//  Created by Brandon Charity on 1/17/16.
//  Copyright © 2016 bac.fresh. All rights reserved.
//

#import "EqInfoViewController.h"
#import "Earthquake.h"
#import "EqInfoTableViewCell.h"
#import "Position.h"

@interface EqInfoViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic) UITableView *tableView;
@property (nonatomic) Earthquake *eq;
@property (nonatomic) NSMutableArray *textualInfoArray;
@end

static NSString *cellIdentifier = @"EqInfoCell";

@implementation EqInfoViewController

- (instancetype)initWithEarthquake:(Earthquake *)eq
{
    self = [super initWithNibName:@"EqInfoTableView" bundle:nil];
    if (self) {
        self.eq = eq;
    }
    return self;
}

- (void)viewDidLoad {
    self.tableView = (UITableView *)self.view;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"EqInfoTableViewCell" bundle:nil] forCellReuseIdentifier:cellIdentifier];
    if (self.eq != nil) {
        self.textualInfoArray = [[NSMutableArray alloc] init];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.timeStyle = NSDateFormatterMediumStyle;
        dateFormatter.dateStyle = NSDateFormatterMediumStyle;
        NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
        [dateFormatter setLocale:usLocale];
        NSString *dateString = [dateFormatter stringFromDate:self.eq.occurrenceDate];
        [self.textualInfoArray addObject:@{@"Location" : [NSString stringWithFormat:@"%@, depth of %.2fkm", self.eq.location, [[self.eq getPointPosition].depth doubleValue]]}];
        [self.textualInfoArray addObject:@{@"Magnitude" : [self.eq.magnitude stringValue]}];
        [self.textualInfoArray addObject:@{@"Date" : dateString}];
    }
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.textualInfoArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.tableView.frame.size.height / self.textualInfoArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EqInfoTableViewCell *cell = (EqInfoTableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    NSDictionary *dic = self.textualInfoArray[[indexPath row]];
    cell.keyLbl.text = [NSString stringWithFormat:@"%@:", dic.allKeys[0]];
    cell.valueLbl.text = [dic valueForKey:dic.allKeys[0]];
    return cell;
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    [self.tableView setContentInset:UIEdgeInsetsZero];
}

@end
