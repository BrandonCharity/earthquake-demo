//
//  EqDetailViewController.m
//  geo-monitor-demo
//
//  Created by Brandon Charity on 1/17/16.
//  Copyright © 2016 bac.fresh. All rights reserved.
//

#import "EqDetailViewController.h"
#import "EqInfoViewController.h"
#import "EqMapViewController.h"
#import "LayoutConstraintManager.h"

@interface EqDetailViewController ()
@property (nonatomic) EqInfoViewController *eqInfoController;
@property (nonatomic) EqMapViewController *eqMapController;
@end

@implementation EqDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (self.earthquake != nil) {
        self.eqInfoController = [[EqInfoViewController alloc] initWithEarthquake:self.earthquake];
        self.eqMapController = [[EqMapViewController alloc] initWithEarthquakes:@[self.earthquake]];
        [self.view addSubview:self.eqInfoController.view];
        [self.view addSubview:self.eqMapController.view];
        [self.eqMapController.view setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.eqInfoController.view setTranslatesAutoresizingMaskIntoConstraints:NO];
        [LayoutConstraintManager stickView:self.eqMapController.view toParentViewTop:self.view];
        [LayoutConstraintManager stickView:self.eqInfoController.view toParentViewBottom:self.view];
        [LayoutConstraintManager setView:self.eqMapController.view aboveView:self.eqInfoController.view withParentView:self.view];
        [LayoutConstraintManager setHeight:(self.view.frame.size.height / 2) ofView:self.eqMapController.view];
        [LayoutConstraintManager setHeight:(self.view.frame.size.height / 2) ofView:self.eqInfoController.view];
        [self addChildViewController:self.eqMapController];
        [self didMoveToParentViewController:self.eqMapController];
        [self addChildViewController:self.eqInfoController];
        [self didMoveToParentViewController:self.eqInfoController];
    }
    
    if (self.navigationController != nil) {
        [self.navigationController.navigationItem setHidesBackButton:NO];
    }
}

@end
