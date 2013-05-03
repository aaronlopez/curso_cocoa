//
//  ViewController.h
//  CoreLocation2Solucion
//
//  Created by aaron on 02/05/13.
//  Copyright (c) 2013 Educacion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
@interface ViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *labelPlacemark;

@property (strong, nonatomic) IBOutlet UITextField *latitud;
@property (strong, nonatomic) IBOutlet UITextField *longitud;
@end

