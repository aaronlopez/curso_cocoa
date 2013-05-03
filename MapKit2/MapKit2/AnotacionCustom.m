//
//  AnotacionCustom.m
//  MapKit2
//
//  Created by aaron on 02/05/13.
//  Copyright (c) 2013 Educacion. All rights reserved.
//

#import "AnotacionCustom.h"

@implementation AnotacionCustom
- (CLLocationCoordinate2D)coordinate;
{
    CLLocationCoordinate2D theCoordinate;
    theCoordinate.latitude = 28.129967;
    theCoordinate.longitude = -15.450232;
    return theCoordinate;
}

- (NSString *)title
{
    return @"Auditorio";
}

// optional
- (NSString *)subtitle
{
    return @"";
}
@end
