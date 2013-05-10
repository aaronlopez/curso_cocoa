//
//  ViewController.m
//  LocalNotification
//
//  Created by aaron on 08/05/13.
//  Copyright (c) 2013 Educacion. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)createNotification:(id)sender {
    UILocalNotification *localNotif = [[UILocalNotification alloc] init];
    
    NSDate *now = [NSDate date];
    NSDate *newDate1 = [now dateByAddingTimeInterval:10];
    localNotif.fireDate = newDate1;
    localNotif.timeZone = [NSTimeZone defaultTimeZone];
	
	localNotif.alertBody = @"Notificación local";
	localNotif.alertAction = @"VIEW";
	
    localNotif.soundName = UILocalNotificationDefaultSoundName;
    localNotif.applicationIconBadgeNumber = 1;
	 NSDictionary *infoDict = [NSDictionary dictionaryWithObject:@"1234" forKey:@"id"];
    localNotif.userInfo = infoDict;
	
	[[UIApplication sharedApplication] scheduleLocalNotification:localNotif];
    }

@end
