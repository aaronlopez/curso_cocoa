//
//  ViewController.m
//  PlaySound
//
//  Created by aaron on 08/05/13.
//  Copyright (c) 2013 Educacion. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (){
    CFURLRef		soundFileURLRef;
	SystemSoundID	soundFileObject;
}
@property (readwrite)	CFURLRef		soundFileURLRef;
@property (readonly)	SystemSoundID	soundFileObject;
@end

@implementation ViewController
@synthesize soundFileURLRef;
@synthesize soundFileObject;


- (void)viewDidLoad
{
    [super viewDidLoad];
   
    NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"tap"
                                                withExtension: @"aif"];
    
    //self.soundFileURLRef = ( CFURLRef)objc_unretainedPointer( tapSound );
    
    AudioServicesCreateSystemSoundID (
                                      
                                      soundFileURLRef,
                                      &soundFileObject
                                      );
	// Do any additional setup after loading the view, typically from a nib.
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
- (IBAction) playSystemSound: (id) sender {
    
    AudioServicesPlaySystemSound (soundFileObject);
}


// Respond to a tap on the Alert Sound button.
- (IBAction) playAlertSound: (id) sender {
    
    AudioServicesPlayAlertSound (soundFileObject);
}


// Respond to a tap on the Vibrate button. In the Simulator and on devices with no
//    vibration element, this method does nothing.
- (IBAction) vibrate: (id) sender {
    
    AudioServicesPlaySystemSound (kSystemSoundID_Vibrate);
}

@end
