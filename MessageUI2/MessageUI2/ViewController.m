//
//  ViewController.m
//  MessageUI2
//
//  Created by aaron on 02/05/13.
//  Copyright (c) 2013 Educacion. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize feedbackMsg;

#pragma mark -
#pragma mark Views lifecycle

- (void)viewDidUnload {
	self.feedbackMsg = nil;
}

#pragma mark Show Mail

-(IBAction)showMailPicker:(id)sender {
	Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
	if (mailClass != nil) {
		if ([mailClass canSendMail]) {
			[self displayMailComposerSheet];
		}
		else {
			feedbackMsg.hidden = NO;
			feedbackMsg.text = @"Device not configured to send mail.";
		}
	}
	else	{
		feedbackMsg.hidden = NO;
		feedbackMsg.text = @"Device not configured to send mail.";
	}
}

#pragma mark Compose Mail

-(void)displayMailComposerSheet
{
	MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
	picker.mailComposeDelegate = self;
	
	[picker setSubject:@"Hello from California!"];
	
	
	NSArray *toRecipients = [NSArray arrayWithObject:@"aaronlopez@gmail.com"];
	[picker setToRecipients:toRecipients];
    //[picker setCcRecipients:ccRecipients];
	//[picker setBccRecipients:bccRecipients];
	
	NSString *path = [[NSBundle mainBundle] pathForResource:@"rainy" ofType:@"jpg"];
	NSData *myData = [NSData dataWithContentsOfFile:path];
	[picker addAttachmentData:myData mimeType:@"image/jpeg" fileName:@"rainy"];
	
	NSString *emailBody = @"It is raining in sunny California!";
	[picker setMessageBody:emailBody isHTML:NO];

    [self presentViewController:picker animated:YES completion:nil];

}

#pragma mark Dismiss Mail

- (void)mailComposeController:(MFMailComposeViewController*)controller
          didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
	
	feedbackMsg.hidden = NO;
	// Notifies users about errors associated with the interface
	switch (result)
	{
		case MFMailComposeResultCancelled:
			feedbackMsg.text = @"Result: Mail sending canceled";
			break;
		case MFMailComposeResultSaved:
			feedbackMsg.text = @"Result: Mail saved";
			break;
		case MFMailComposeResultSent:
			feedbackMsg.text = @"Result: Mail sent";
			break;
		case MFMailComposeResultFailed:
			feedbackMsg.text = @"Result: Mail sending failed";
			break;
		default:
			feedbackMsg.text = @"Result: Mail not sent";
			break;
	}
    [self dismissViewControllerAnimated:YES completion:nil];
}



@end