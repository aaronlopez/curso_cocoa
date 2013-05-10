//
//  ViewController.h
//  PlaySound
//
//  Created by aaron on 08/05/13.
//  Copyright (c) 2013 Educacion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioServices.h>
@interface ViewController : UIViewController
{
    
    CFURLRef        soundFileURLRef;
    SystemSoundID   soundFileObject;
    
}

@property (readwrite)   CFURLRef        soundFileURLRef;
@property (readonly)    SystemSoundID   soundFileObject;
@end
