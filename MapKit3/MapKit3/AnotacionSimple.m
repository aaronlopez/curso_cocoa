//
//  AnotacionSimple.m
//  MapKit2
//
//  Created by aaron on 02/05/13.
//  Copyright (c) 2013 Educacion. All rights reserved.
//

#import "AnotacionSimple.h"

@implementation AnotacionSimple
- (CLLocationCoordinate2D)coordinate;
{
    CLLocationCoordinate2D theCoordinate;
    theCoordinate.latitude = 28.142465;
    theCoordinate.longitude = -15.434031;
    return theCoordinate;
}


- (NSString *)title
{
    return @"Las Canteras";
}

// optional
- (NSString *)subtitle
{
    return @"Playa de Las Canteras";
}
@end
