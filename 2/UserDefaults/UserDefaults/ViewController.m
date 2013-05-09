//
//  ViewController.m
//  UserDefaults
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
    
        self.texto_salida.text=[[NSUserDefaults standardUserDefaults] stringForKey:@"nombre"];
        
    [[NSUserDefaults standardUserDefaults] setValue:@"Aarón" forKey:@"nombre"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
   
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
