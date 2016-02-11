//
//  EqSummaryTableViewController.m
//  geo-monitor-demo
//
//  Created by Brandon Charity on 1/16/16.
//  Copyright © 2016 bac.fresh. All rights reserved.
//

#import "EqSummaryTableViewController.h"
#import "CoreDataManager.h"
#import "Earthquake.h"
#import "EqDetailViewController.h"
#import "EqSummaryTableViewCell.h"
#import "GeoJsonFeatureCollection.h"
#import "GeoJsonMetaData.h"
#import "GeoJsonToManagedObject.h"
#import "MagnitudeColorCoder.h"
#import "UsgsAgent.h"

@interface EqSummaryTableViewController ()
@property (nonatomic) UsgsAgent *usgsAgent;
@property (nonatomic) MagnitudeColorCoder *magColorCoder;
@property (nonatomic) GeoJsonFeatureCollection *featureCollection;
@property (nonatomic) NSMutableArray<Earthquake *> *cachedEarthquakes;
@end

@implementation EqSummaryTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 44.0;
    [self.tableView registerNib:[UINib nibWithNibName:@"EqSummaryTableViewCell" bundle:nil] forCellReuseIdentifier:@"EarthquakeCell"];
    self.magColorCoder = [[MagnitudeColorCoder alloc] initWithFirstColor:[UIColor greenColor] andSecondColor:[UIColor redColor]];
    self.cachedEarthquakes = [[NSMutableArray alloc] init];
    self.usgsAgent = [UsgsAgent sharedInstance];
    if ([self.usgsAgent usgsApiIsReachable]) {
        [self getLatestEarthquakes];
    }
    else {
        [self getCachedEarthquakes];
    }
    [[self.usgsAgent getReachabilityManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status != AFNetworkReachabilityStatusNotReachable && status != AFNetworkReachabilityStatusUnknown) {
            [self getLatestEarthquakes];
        }
        else {
            [self getCachedEarthquakes];
        }
    }];
}

- (void)getLatestEarthquakes {
    [self.usgsAgent getEarthquakesForLastHour:^(id responseObject, NSError *error) {
        NSDictionary *responseDic = (NSDictionary *)responseObject;
        if (error == nil && responseDic != nil && [responseDic allKeys].count > 0) {
            NSDictionary *responseDic = (NSDictionary *)responseObject;
            self.featureCollection = [[GeoJsonFeatureCollection alloc] initWithInfo:responseDic];
            [self setTitle:self.featureCollection.metadata.title];
            [self.cachedEarthquakes removeAllObjects];
            [Earthquake removeAllEarthquakes:[[CoreDataManager sharedInstance] mainUIContext]];
            for (int i = 0; i < self.featureCollection.features.count; i++) {
                [self.cachedEarthquakes addObject:[GeoJsonToManagedObject featureToEarthquake:[self.featureCollection.features objectAtIndex:i]]];
            }
            [[CoreDataManager sharedInstance] saveToDiskAsync:[[CoreDataManager sharedInstance] mainUIContext] completionBlock:nil];
            [self.tableView reloadData];
        }
        else {
            [self getCachedEarthquakes];
        }
    }];
}

- (void)getCachedEarthquakes {
    if ([self.cachedEarthquakes count] == 0) {
        [self.cachedEarthquakes addObjectsFromArray:[Earthquake getEarthquakes:[[CoreDataManager sharedInstance] mainUIContext]]];
    }
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cachedEarthquakes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EqSummaryTableViewCell *cell = (EqSummaryTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"EarthquakeCell" forIndexPath:indexPath];
    Earthquake *eq = [self.cachedEarthquakes objectAtIndex:[indexPath row]];
    cell.locationLbl.text = eq.location;
    cell.magnitudeLbl.text = [eq.magnitude stringValue];
    UIColor *bgColor = [self.magColorCoder getColorForMagnitude:eq.magnitude];
    cell.contentView.backgroundColor = bgColor;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Earthquake *eq = [self.cachedEarthquakes objectAtIndex:[indexPath row]];
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    EqDetailViewController *detailController = [mainStoryboard instantiateViewControllerWithIdentifier:@"EqDetailViewController"];
    detailController.earthquake = eq;
    [self.navigationController pushViewController:detailController animated:YES];
}

@end
