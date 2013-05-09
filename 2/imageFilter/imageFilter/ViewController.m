//
//  ViewController.m
//  imageFilter
//
//  Created by aaron on 08/05/13.
//  Copyright (c) 2013 Educacion. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *originalImage;
@property (strong, nonatomic) IBOutlet UIImageView *filteredImage;

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
- (IBAction)applyFilter:(id)sender {
    UIImageOrientation originalOrientation = self.originalImage.image.imageOrientation;
    CIImage *inputImage = [[CIImage alloc] initWithCGImage:[self.originalImage.image CGImage]];
    CIFilter *adjustmentFilter = [CIFilter filterWithName:@"CISepiaTone"];
    [adjustmentFilter setDefaults];
    [adjustmentFilter setValue:inputImage forKey:@"inputImage"];
    [adjustmentFilter setValue:[NSNumber numberWithFloat:1.0f] forKey:@"inputIntensity"];
    
    CIImage *outputImage = [adjustmentFilter valueForKey:@"outputImage"];
    
    CIContext* context = [CIContext contextWithOptions:nil];
    
    CGImageRef imgRef = [context createCGImage:outputImage fromRect:outputImage.extent] ;
    
    UIImage* img = [[UIImage alloc] initWithCGImage:imgRef scale:1.0 orientation:originalOrientation];
    
    CGImageRelease(imgRef);
    self.filteredImage.image = img;
}

@end
