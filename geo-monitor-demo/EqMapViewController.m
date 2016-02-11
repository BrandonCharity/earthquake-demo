//
//  EqMapViewController.m
//  geo-monitor-demo
//
//  Created by Brandon Charity on 1/17/16.
//  Copyright © 2016 bac.fresh. All rights reserved.
//

#import "EqMapViewController.h"
#import "Earthquake.h"
#import "EqAnnotation.h"
#import "Position.h"

@interface EqMapViewController () <MKMapViewDelegate>
@property (nonatomic) MKMapView *mapView;
@property (nonatomic) NSArray<Earthquake *> *earthquakes;
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@end

@implementation EqMapViewController

- (instancetype)initWithEarthquakes:(NSArray<Earthquake *> *)earthquakes
{
    self = [super initWithNibName:@"EqMapView" bundle:nil];
    if (self) {
        self.mapView = (MKMapView *)self.view;
        if (earthquakes != nil && earthquakes.count > 0) {
            self.earthquakes = earthquakes;
            for (int i = 0; i < self.earthquakes.count; i++) {
                Earthquake *eq = [self.earthquakes objectAtIndex:i];
                Position *pos = [eq getPointPosition];
                if (pos != nil) {
                    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake([pos.latitude doubleValue], [pos.longitude doubleValue]);
                    self.coordinate = coord;
                    if (CLLocationCoordinate2DIsValid(coord)) {
                        EqAnnotation *eqAnnotation = [[EqAnnotation alloc] initWithLocation:eq.location andCoordinate:coord];
                        [self.mapView addAnnotation:eqAnnotation];
                    }
                }
            }
            self.mapView.delegate = self;
        }
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    CLLocationDistance distance = 80000.0;
    [self.mapView setRegion:MKCoordinateRegionMakeWithDistance(self.coordinate, distance, distance) animated:YES];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation; {
    if ([annotation isKindOfClass:[EqAnnotation class]]) {
        NSString *identifier = @"eq";
        MKAnnotationView *view = [self.mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        if (view == nil) {
            view = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
            [view setCanShowCallout:YES];
            [view setCalloutOffset:CGPointMake(0, 5)];
            [view setRightCalloutAccessoryView:[UIButton buttonWithType:UIButtonTypeDetailDisclosure]];
        }
        else {
            [view setAnnotation:annotation];
        }
        return view;
    }
    else {
        return nil;
    }
}


@end
