//
//  ViewController.m
//  Social1
//
//  Created by aaron on 02/05/13.
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

-(IBAction)sendFacebook:(id)sender{

    
    SLComposeViewController *fbController=[SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
    
    
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
    {
        SLComposeViewControllerCompletionHandler completionHandler=^(SLComposeViewControllerResult result){
            
            [fbController dismissViewControllerAnimated:YES completion:nil];
            
            switch(result){
                case SLComposeViewControllerResultCancelled:
                default:
                {
                    NSLog(@"Cancelado");
                    
                }
                    break;
                case SLComposeViewControllerResultDone:
                {
                    NSLog(@"Enviado");
                }
                    break;
            }};
        
        [fbController addImage:[UIImage imageNamed:@"rainy.jpg"]];
        [fbController setInitialText:@"Curso"];
       // [fbController addURL:[NSURL URLWithString:@""]];
        [fbController setCompletionHandler:completionHandler];
        [self presentViewController:fbController animated:YES completion:nil];
    }
    
    
    
}

@end
