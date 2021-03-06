//
//  PhotoViewVC.m
//  Insta
//
//  Created by aaron on 16/05/13.
//  Copyright (c) 2013 Educacion. All rights reserved.
//

#import "PhotoViewVC.h"
#import "UIImageView+WebCache.h"
@interface PhotoViewVC ()
@property (strong, nonatomic) IBOutlet UIImageView *image;
@property (strong, nonatomic) IBOutlet UILabel *name;

@end

@implementation PhotoViewVC
@synthesize photo=_photo;

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
    self.name.text=[self.photo objectForKey:@"title"];
    [ self.image setImageWithURL:[[WS_API sharedInstance] urlForImageWithId:[self.photo objectForKey:@"IdPhoto"] isThumb:NO]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
