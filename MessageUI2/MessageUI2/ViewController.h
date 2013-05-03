//
//  ViewController.h
//  MessageUI2
//
//  Created by aaron on 02/05/13.
//  Copyright (c) 2013 Educacion. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface ViewController : UIViewController <MFMailComposeViewControllerDelegate, UINavigationControllerDelegate> {
	
	IBOutlet UILabel *feedbackMsg;
}

@property (nonatomic, retain) IBOutlet UILabel *feedbackMsg;

-(IBAction)showMailPicker:(id)sender;
-(void)displayMailComposerSheet;



@end

