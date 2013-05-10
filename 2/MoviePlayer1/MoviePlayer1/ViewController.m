//
//  ViewController.m
//  MoviePlayer1
//
//  Created by aaron on 08/05/13.
//  Copyright (c) 2013 Educacion. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(retain,nonatomic)MPMoviePlayerController *moviePlayer;
@end

@implementation ViewController
@synthesize moviePlayer;
- (void)viewDidLoad
{
    [super viewDidLoad];
     self.moviePlayer = [[MPMoviePlayerController alloc] init];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSURL *)localMovieURL
{
	NSURL *theMovieURL = nil;
	NSBundle *bundle = [NSBundle mainBundle];
	if (bundle)
	{
		NSString *moviePath = [bundle pathForResource:@"shake" ofType:@"mp4"];
		if (moviePath)
		{
			theMovieURL = [NSURL fileURLWithPath:moviePath];
		}
	}
    return theMovieURL;
}
- (IBAction)playVideoURL:(id)sender {
    
   
         [self.moviePlayer setContentURL:[NSURL URLWithString:@"https://s3-eu-west-1.amazonaws.com/david.videos/shake.mp4"]];
       [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(moviePlayBackDidFinish:)
                                                     name:MPMoviePlayerPlaybackDidFinishNotification
                                                   object:moviePlayer];
        
        [moviePlayer setMovieSourceType:MPMovieSourceTypeUnknown];
        [self.view addSubview:moviePlayer.view];
        [moviePlayer setFullscreen:YES];
        
   
}
- (void) moviePlayBackDidFinish:(NSNotification*)notification {
    MPMoviePlayerController *player = [notification object];
    [[NSNotificationCenter defaultCenter]
     removeObserver:self
     name:MPMoviePlayerPlaybackDidFinishNotification
     object:player];
    }
@end
