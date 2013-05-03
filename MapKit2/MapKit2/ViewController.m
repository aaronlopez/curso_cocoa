//
//  ViewController.m
//  MapKit2
//
//  Created by aaron on 02/05/13.
//  Copyright (c) 2013 Educacion. All rights reserved.
//

#import "ViewController.h"
#import "AnotacionCustom.h"
#import "AnotacionSimple.h"

@interface ViewController ()

@property (strong, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    MKCoordinateRegion newRegion;
  
    newRegion.center.latitude =   28.13658;
    newRegion.center.longitude = -15.438699;
    newRegion.span.latitudeDelta = 0.112872;
    newRegion.span.longitudeDelta = 0.109863;
    
    [self.mapView setRegion:newRegion animated:YES];
    AnotacionSimple *as =[[AnotacionSimple alloc] init];
	[self.mapView addAnnotation:as];
    AnotacionCustom *ac =[[AnotacionCustom alloc] init];
	[self.mapView addAnnotation:ac];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - MKMapViewDelegate


- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
     id <MKAnnotation> annotation = [view annotation];
    NSLog(@"%@",annotation);
    [self performSegueWithIdentifier:@"detail" sender:nil];

}

- (MKAnnotationView *)mapView:(MKMapView *)theMapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MKUserLocation class]])
    {
        return nil;
    }

    if ([annotation isKindOfClass:[AnotacionSimple class]])
    {

        static NSString *AnotacionSimpleId = @"AnotacionSimpleId";
        
        MKPinAnnotationView *pinView =
        (MKPinAnnotationView *) [self.mapView dequeueReusableAnnotationViewWithIdentifier:AnotacionSimpleId];
        if (pinView == nil)
        {
          
            MKPinAnnotationView *customPinView = [[MKPinAnnotationView alloc]
                                                  initWithAnnotation:annotation reuseIdentifier:AnotacionSimpleId];
            customPinView.pinColor = MKPinAnnotationColorPurple;
            customPinView.animatesDrop = YES;
            customPinView.canShowCallout = YES;
            
            UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
            [rightButton addTarget:nil action:nil forControlEvents:UIControlEventTouchUpInside];
            customPinView.rightCalloutAccessoryView = rightButton;
            
            return customPinView;
        }
        else
        {
            pinView.annotation = annotation;
        }
        return pinView;
    }
    else if ([annotation isKindOfClass:[AnotacionCustom class]])   // for City of San Francisco
    {
        static NSString *AnotacionCustomID = @"AnotacionCustomID";
        
        MKAnnotationView *customAnnotationView =
        [self.mapView dequeueReusableAnnotationViewWithIdentifier:AnotacionCustomID];
        if (customAnnotationView == nil)
        {
            MKAnnotationView *annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnotacionCustomID];
            annotationView.canShowCallout = YES;
            UIImage *imageBase = [UIImage imageNamed:@"auditorio.jpg"];
            annotationView.image = imageBase;
            annotationView.opaque = NO;
            return annotationView;
        }
        else
        {
            customAnnotationView.annotation = annotation;
        }
        return customAnnotationView;
    }
    return nil;
}

@end
