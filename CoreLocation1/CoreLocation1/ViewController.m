//
//  ViewController.m
//  CoreLocation1
//
//  Created by aaron on 01/05/13.
//  Copyright (c) 2013 Educacion. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize locationManager=_locationManager;
- (void)viewDidLoad
{
    [super viewDidLoad];
	self.locationManager = [[CLLocationManager alloc] init];
	self.locationManager.delegate = self;
	self.locationManager.distanceFilter = kCLLocationAccuracyHundredMeters;
	self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
	[self.locationManager startUpdatingLocation];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
	NSLog(@"Error: %@", error);
}


- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
	[self.labelPos setText:[NSString stringWithFormat: NSLocalizedString(@"pos",""),newLocation]];
}


@end
