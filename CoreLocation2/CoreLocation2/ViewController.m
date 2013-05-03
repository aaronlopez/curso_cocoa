//
//  ViewController.m
//  CoreLocation2
//
//  Created by aaron on 01/05/13.
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
    CLGeocoder *geocoder = [[CLGeocoder alloc] init] ;
    [geocoder geocodeAddressString:self.textField.text completionHandler:^(NSArray *placemarks, NSError *error) {
        NSLog(@"geocodeAddressString:completionHandler: Completion Handler called!");
        if (error)
        {
            [self.labelPlacemark setText:[error description] ] ;
            return;
        }
        
       [self.labelPlacemark setText: [placemarks description] ];
        
    }];
}

@end
