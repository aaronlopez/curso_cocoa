//
//  ViewController.h
//  CoreLocation1
//
//  Created by aaron on 01/05/13.
//  Copyright (c) 2013 Educacion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
@interface ViewController : UIViewController<CLLocationManagerDelegate>
@property (strong, nonatomic) IBOutlet UILabel *labelPos;


@property (nonatomic, retain) CLLocationManager *locationManager;
@end
