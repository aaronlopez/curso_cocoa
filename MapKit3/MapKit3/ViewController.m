//
//  ViewController.m
//  MapKit2
//
//  Created by aaron on 02/05/13.
//  Copyright (c) 2013 Educacion. All rights reserved.
//

#import "ViewController.h"
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
    [self.mapView addOverlay:[MKCircle circleWithCenterCoordinate:as.coordinate radius:300.0f]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - MKMapViewDelegate
- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id <MKOverlay>)overlay {
	if([overlay isKindOfClass:[MKCircle class]]) {
		// Create the view for the radius overlay.
		MKCircleView *circleView = [[MKCircleView alloc] initWithOverlay:overlay];
		circleView.strokeColor = [UIColor purpleColor];
		circleView.fillColor = [[UIColor purpleColor] colorWithAlphaComponent:0.4];
		
		return circleView;
	}
	
	return nil;
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
            
                     
            return customPinView;
        }
        else
        {
            pinView.annotation = annotation;
        }
        return pinView;
    
      }
    return nil;
}

@end
