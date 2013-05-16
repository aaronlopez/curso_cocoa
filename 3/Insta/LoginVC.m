//
//  LoginVC.m
//  Insta
//
//  Created by aaron on 16/05/13.
//  Copyright (c) 2013 Educacion. All rights reserved.
//

#import "LoginVC.h"
#include <CommonCrypto/CommonDigest.h>

#define kSalt @"adlfu3489tyh2jnkLIUGI&%EV(&0982cbgrykxjnk8855"
@interface LoginVC ()

@end

@implementation LoginVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self.username becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if(textField.tag==0){
        [ self.password becomeFirstResponder];
          return YES;
    }

        [textField resignFirstResponder];
        return NO;
  
}


#pragma mark WS Call
-(IBAction)buttonLogin:(UIButton*)sender {
	//form fields validation
	if (self.username.text.length < 4 || self.password.text.length < 4) {
		
		return;
	}
	//salt the password
	NSString* saltedPassword = [NSString stringWithFormat:@"%@%@", self.password.text, kSalt];
	//prepare the hashed storage
	NSString* hashedPassword = nil;
	unsigned char hashedPasswordData[CC_SHA1_DIGEST_LENGTH];
	//hash the pass
	NSData *data = [saltedPassword dataUsingEncoding: NSUTF8StringEncoding];
	if (CC_SHA1([data bytes], [data length], hashedPasswordData)) {
		hashedPassword = [[NSString alloc] initWithBytes:hashedPasswordData length:sizeof(hashedPasswordData) encoding:NSASCIIStringEncoding];
	}	//check whether it's a login or register
	NSString* command = (sender.tag==1)?@"register":@"login";
	NSMutableDictionary* params =[NSMutableDictionary dictionaryWithObjectsAndKeys:command, @"command", self.username.text, @"username", hashedPassword, @"password", nil];
	//make the call to the web API
	[[WS_API sharedInstance] commandWithParams:params onCompletion:^(NSDictionary *json) {
		//result returned
		NSDictionary* res = [[json objectForKey:@"result"] objectAtIndex:0];
		if ([json objectForKey:@"error"]==nil && [[res objectForKey:@"IdUser"] intValue]>0) {
			[[WS_API sharedInstance] setUser: res];
			[self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
			//show message to the user
			[[[UIAlertView alloc] initWithTitle:@"Logged in" message:[NSString stringWithFormat:@"Welcome %@",[res objectForKey:@"username"]] delegate:nil cancelButtonTitle:@"Close" otherButtonTitles: nil] show];
		} 
	}];
    
}



@end
