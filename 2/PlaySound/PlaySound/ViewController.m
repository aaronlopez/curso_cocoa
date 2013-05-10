//
//  ViewController.m
//  PlaySound
//
//  Created by aaron on 08/05/13.
//  Copyright (c) 2013 Educacion. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@end

@implementation ViewController
@synthesize soundFileURLRef;
@synthesize soundFileObject;


- (void)viewDidLoad
{
    [super viewDidLoad];
   
    NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"tick"
                                                withExtension: @"aiff"];
    
    
    // Store the URL as a CFURLRef instance
    self.soundFileURLRef = (__bridge CFURLRef)  tapSound ;
    
    // Create a system sound object representing the sound file.
    AudioServicesCreateSystemSoundID (
                                      
                                      soundFileURLRef,
                                      &soundFileObject
                                      );
    OSStatus status = AudioServicesCreateSystemSoundID((__bridge CFURLRef)tapSound, &soundFileObject);
    NSLog(@"AudioServicesCreateSystemSoundID status = %ld", status);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)playSound:(id)sender {
    AudioServicesPlaySystemSound (soundFileObject);
    AudioServicesPlayAlertSound (soundFileObject);
    AudioServicesPlaySystemSound (kSystemSoundID_Vibrate);

    
}

@end
