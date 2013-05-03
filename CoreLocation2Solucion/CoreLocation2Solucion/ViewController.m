//
//  ViewController.m
//  CoreLocation2Solucion
//
//  Created by aaron on 02/05/13.
//  Copyright (c) 2013 Educacion. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


- (IBAction)actionSearch:(id)sender {
    
    CLLocationCoordinate2D coord=CLLocationCoordinate2DMake([self.latitud.text floatValue], [self.longitud.text floatValue]);
    CLLocation *location = [[CLLocation alloc] initWithLatitude:coord.latitude longitude:coord.longitude] ;
    CLGeocoder *geocoder = [[CLGeocoder alloc] init] ;
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        if (error)
        {
            [self.labelPlacemark setText:[error description] ] ;
            return;
        }
        
        [self.labelPlacemark setText: [placemarks description] ];
        
    }];
}

@end
