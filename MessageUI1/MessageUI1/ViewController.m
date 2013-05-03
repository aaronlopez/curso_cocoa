//
//  ViewController.m
//  MessageUI1
//
//  Created by aaron on 02/05/13.
//  Copyright (c) 2013 Educacion. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize feedbackMsg;


#pragma mark SMS picker




-(IBAction)showSMSPicker:(id)sender {
    Class messageClass = (NSClassFromString(@"MFMessageComposeViewController"));
	
	if (messageClass != nil) {
		if ([messageClass canSendText]) {
			[self displaySMSComposerSheet];
		}
		else {
			feedbackMsg.hidden = NO;
			feedbackMsg.text = @"Device not configured to send SMS.";
            
		}
	}
	else {
		feedbackMsg.hidden = NO;
		feedbackMsg.text = @"Device not configured to send SMS.";
	}
}


#pragma mark Compose SMS

-(void)displaySMSComposerSheet
{
	MFMessageComposeViewController *picker = [[MFMessageComposeViewController alloc] init];
	picker.messageComposeDelegate = self;
	

    [self presentViewController:picker animated:YES completion:nil];
}


#pragma mark -
#pragma mark SMS

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller
                 didFinishWithResult:(MessageComposeResult)result {
	
	feedbackMsg.hidden = NO;
	// Notifies users about errors associated with the interface
	switch (result)
	{
		case MessageComposeResultCancelled:
			feedbackMsg.text = @"Result: SMS sending canceled";
			break;
		case MessageComposeResultSent:
			feedbackMsg.text = @"Result: SMS sent";
			break;
		case MessageComposeResultFailed:
			feedbackMsg.text = @"Result: SMS sending failed";
			break;
		default:
			feedbackMsg.text = @"Result: SMS not sent";
			break;
	}
    [self dismissViewControllerAnimated:YES completion:nil];

}


@end
