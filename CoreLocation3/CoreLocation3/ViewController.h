//
//  ViewController.h
//  CoreLocation3
//
//  Created by aaron on 02/05/13.
//  Copyright (c) 2013 Educacion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
@interface ViewController : UIViewController<CLLocationManagerDelegate>


@property (nonatomic, retain) CLLocationManager *locationManager;

@end
