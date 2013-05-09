//
//  ViewController.m
//  FaceDetect
//
//  Created by aaron on 08/05/13.
//  Copyright (c) 2013 Educacion. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) IBOutlet UIImageView *lena;
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
- (IBAction)detectSender:(id)sender {
     [self markFaces:self.lena];
}

-(void)markFaces:(UIImageView *)facePicture
{
    CIImage* image = [CIImage imageWithCGImage:facePicture.image.CGImage];

    CIDetector* detector = [CIDetector detectorOfType:CIDetectorTypeFace
                                              context:nil options:[NSDictionary dictionaryWithObject:CIDetectorAccuracyHigh forKey:CIDetectorAccuracy]];
    
    NSArray* features = [detector featuresInImage:image];
   
    for(CIFaceFeature* faceFeature in features)
    {
        CGFloat faceWidth = faceFeature.bounds.size.width;
        UIView* faceView = [[UIView alloc] initWithFrame:CGRectMake(faceFeature.bounds.origin.x,165-faceFeature.bounds.origin.y, faceFeature.bounds.size.width, faceFeature.bounds.size.height)];
       faceView.layer.borderWidth = 1;
        faceView.layer.borderColor = [[UIColor redColor] CGColor];
        [self.view addSubview:faceView];
        
        if(faceFeature.hasLeftEyePosition)
        {
            UIView* leftEyeView = [[UIView alloc] initWithFrame:CGRectMake(faceFeature.leftEyePosition.x-faceWidth*0.15, faceFeature.leftEyePosition.y-faceWidth*0.15, faceWidth*0.3, faceWidth*0.3)];
            [leftEyeView setBackgroundColor:[[UIColor blueColor] colorWithAlphaComponent:0.3]];
            [leftEyeView setCenter:CGPointMake(faceFeature.leftEyePosition.x, 256-faceFeature.leftEyePosition.y)];
            leftEyeView.layer.cornerRadius = faceWidth*0.15;
            [self.view addSubview:leftEyeView];
        }
        
        if(faceFeature.hasRightEyePosition)
        {
            UIView* leftEye = [[UIView alloc] initWithFrame:CGRectMake(faceFeature.rightEyePosition.x-faceWidth*0.15, faceFeature.rightEyePosition.y-faceWidth*0.15, faceWidth*0.3, faceWidth*0.3)];
            [leftEye setBackgroundColor:[[UIColor blueColor] colorWithAlphaComponent:0.3]];
            [leftEye setCenter:CGPointMake(faceFeature.rightEyePosition.x, 256-faceFeature.rightEyePosition.y)];//()faceFeature.leftEyePosition];
            leftEye.layer.cornerRadius = faceWidth*0.15;
            [self.view addSubview:leftEye];
        }
        
        if(faceFeature.hasMouthPosition)
        {
            UIView* mouth = [[UIView alloc] initWithFrame:CGRectMake(faceFeature.mouthPosition.x-faceWidth*0.2, faceFeature.mouthPosition.y-faceWidth*0.2, faceWidth*0.4, faceWidth*0.4)];
            [mouth setBackgroundColor:[[UIColor greenColor] colorWithAlphaComponent:0.3]];
            [mouth setCenter:CGPointMake(faceFeature.mouthPosition.x, 256-faceFeature.mouthPosition.y)];
            mouth.layer.cornerRadius = faceWidth*0.2;
            [self.view addSubview:mouth];
        }
    }
 
}
@end
