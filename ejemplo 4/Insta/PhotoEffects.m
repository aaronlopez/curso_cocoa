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
    self.filters=[[NSArray alloc] initWithObjects:@"CISepiaTone",@"CIBloom",@"CIColorMonochrome",@"CIHoleDistortion",@"CIColorInvert", nil ];
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
    self.imageFont= [info objectForKey:UIImagePickerControllerOriginalImage];
    self.imageView.image = self.imageFont;
    [picker dismissViewControllerAnimated:NO completion:nil]; 
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:NO completion:nil];
    [self.navigationController popViewControllerAnimated:NO];
    
}

-(void)takePhoto {
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
#if TARGET_IPHONE_SIMULATOR
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
#else
    imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
#endif
    imagePickerController.delegate = (id)self;
    
    [self presentViewController:imagePickerController animated:YES completion:nil ]; 
}
- (IBAction)effect:(id)sender {


}
- (IBAction)applyEffects:(id)sender {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.labelText = @"Loading";

    UIImageOrientation originalOrientation = self.imageFont.imageOrientation;
    CIImage *inputImage = [[CIImage alloc] initWithCGImage:[self.imageFont CGImage]];
    NSInteger index = [sender tag];
    NSString *filterS=[self.filters objectAtIndex:index];
    CIFilter *adjustmentFilter = [CIFilter filterWithName:filterS];
    [adjustmentFilter setDefaults];
    [adjustmentFilter setValue:inputImage forKey:@"inputImage"];
    
    CIImage *outputImage = [adjustmentFilter valueForKey:@"outputImage"];
    
    CIContext* context = [CIContext contextWithOptions:nil];
    
    CGImageRef imgRef = [context createCGImage:outputImage fromRect:outputImage.extent] ;
    
    UIImage* img = [[UIImage alloc] initWithCGImage:imgRef scale:1.0 orientation:originalOrientation];
    
    CGImageRelease(imgRef);
    self.imageView.image = img;
     [hud hide:YES];
    
}

#pragma mark WS CALL
- (IBAction)upload:(id)sender {
    [[WS_API sharedInstance] commandWithParams:[NSMutableDictionary dictionaryWithObjectsAndKeys:@"upload", @"command", UIImageJPEGRepresentation(self.imageView.image,70), @"file", self.name.text, @"title", nil] onCompletion:^(NSDictionary *json) {
		//completion
        NSLog(@"json %@",json);
		if (![json objectForKey:@"error"]) {
			//success
			[[[UIAlertView alloc]initWithTitle:@"Success!" message:@"Your photo is uploaded" delegate:nil cancelButtonTitle:@"Yay!" otherButtonTitles: nil] show];
             [self.navigationController popViewControllerAnimated:NO];
            
		}else
        {
        	[[[UIAlertView alloc]initWithTitle:@"Fail!" message:[json objectForKey:@"error"] delegate:nil cancelButtonTitle:@"Yay!" otherButtonTitles: nil] show];
            [self.navigationController popViewControllerAnimated:NO];
            
        }
	}];
}

@end
