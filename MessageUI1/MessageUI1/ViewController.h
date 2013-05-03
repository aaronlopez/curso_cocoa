//
//  ViewController.h
//  MessageUI1
//
//  Created by aaron on 02/05/13.
//  Copyright (c) 2013 Educacion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>


@interface ViewController : UIViewController <
MFMessageComposeViewControllerDelegate, UINavigationControllerDelegate> {
	
	IBOutlet UILabel *feedbackMsg;
}

@property (nonatomic, retain) IBOutlet UILabel *feedbackMsg;

-(IBAction)showSMSPicker:(id)sender;
-(void)displaySMSComposerSheet;


@end