//
//  ViewController.m
//  CoreLocation3
//
//  Created by aaron on 02/05/13.
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
	self.locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
	[self.locationManager startUpdatingLocation];
   
    CLLocationCoordinate2D coordinate = {37.33233141, -122.03121860 };
    CLRegion *newRegion = [[CLRegion alloc] initCircularRegionWithCenter:coordinate radius:250.0 identifier:@"Apple"];
    NSLog(@"about to monitor region with radius: %f", newRegion.radius);
    [self.locationManager startMonitoringForRegion:newRegion];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
	NSLog(@"didFailWithError: %@", error);
}


- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
	//NSLog(@"didUpdateToLocation %@ from %@", newLocation, oldLocation);
}


- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region  {
	NSString *event = [NSString stringWithFormat:@"didEnterRegion %@ at %@", region.identifier, [NSDate date]];
 NSLog(@"%@",event);

}


- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region {
	NSString *event = [NSString stringWithFormat:@"didExitRegion %@ at %@", region.identifier, [NSDate date]];
    NSLog(@"%@",event);

}


- (void)locationManager:(CLLocationManager *)manager monitoringDidFailForRegion:(CLRegion *)region withError:(NSError *)error {
	NSString *event = [NSString stringWithFormat:@"monitoringDidFailForRegion %@: %@", region.identifier, error];
     NSLog(@"%@",event);
}

@end
