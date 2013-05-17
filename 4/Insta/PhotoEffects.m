//
//  PhotoEffects.m
//  Insta
//
//  Created by aaron on 16/05/13.
//  Copyright (c) 2013 Educacion. All rights reserved.
//

#import "PhotoEffects.h"
#import "MBProgressHUD.h"
@interface PhotoEffects ()
@property (strong,nonatomic) UIImage * imageFont;
@property (strong, nonatomic) IBOutlet UITextField *name;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong,nonatomic) NSArray * filters;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *buttonUp;

@end

@implementation PhotoEffects

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    // Custom initialization
    self.navigationItem.rightBarButtonItem=self.buttonUp;
    self.scrollView.scrollEnabled=YES;
    [self.scrollView setContentSize:CGSizeMake(440,101)];
    [self takePhoto];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark TexViewDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
        [textField resignFirstResponder];
        return NO;
 }
#pragma mark - Image picker delegate methods
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
  }

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
}

-(void)takePhoto {
 }
- (IBAction)applyEffects:(id)sender {
}

#pragma mark WS CALL
- (IBAction)upload:(id)sender {
   
}

@end
