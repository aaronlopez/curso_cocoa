/*
     File: RootViewController.m 
 Abstract: 
     
  Version: 1.0 
  
 Disclaimer: IMPORTANT:  This Apple software is supplied to you by Apple 
 Inc. ("Apple") in consideration of your agreement to the following 
 terms, and your use, installation, modification or redistribution of 
 this Apple software constitutes acceptance of these terms.  If you do 
 not agree with these terms, please do not use, install, modify or 
 redistribute this Apple software. 
  
 In consideration of your agreement to abide by the following terms, and 
 subject to these terms, Apple grants you a personal, non-exclusive 
 license, under Apple's copyrights in this original Apple software (the 
 "Apple Software"), to use, reproduce, modify and redistribute the Apple 
 Software, with or without modifications, in source and/or binary forms; 
 provided that if you redistribute the Apple Software in its entirety and 
 without modifications, you must retain this notice and the following 
 text and disclaimers in all such redistributions of the Apple Software. 
 Neither the name, trademarks, service marks or logos of Apple Inc. may 
 be used to endorse or promote products derived from the Apple Software 
 without specific prior written permission from Apple.  Except as 
 expressly stated in this notice, no other rights or licenses, express or 
 implied, are granted by Apple herein, including but not limited to any 
 patent rights that may be infringed by your derivative works or by other 
 works in which the Apple Software may be incorporated. 
  
 The Apple Software is provided by Apple on an "AS IS" basis.  APPLE 
 MAKES NO WARRANTIES, EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION 
 THE IMPLIED WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY AND FITNESS 
 FOR A PARTICULAR PURPOSE, REGARDING THE APPLE SOFTWARE OR ITS USE AND 
 OPERATION ALONE OR IN COMBINATION WITH YOUR PRODUCTS. 
  
 IN NO EVENT SHALL APPLE BE LIABLE FOR ANY SPECIAL, INDIRECT, INCIDENTAL 
 OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF 
 SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS 
 INTERRUPTION) ARISING IN ANY WAY OUT OF THE USE, REPRODUCTION, 
 MODIFICATION AND/OR DISTRIBUTION OF THE APPLE SOFTWARE, HOWEVER CAUSED 
 AND WHETHER UNDER THEORY OF CONTRACT, TORT (INCLUDING NEGLIGENCE), 
 STRICT LIABILITY OR OTHERWISE, EVEN IF APPLE HAS BEEN ADVISED OF THE 
 POSSIBILITY OF SUCH DAMAGE. 
  
 Copyright (C) 2011 Apple Inc. All Rights Reserved. 
  
 */

#import "RootViewController.h"

@interface RootViewController()

@property (nonatomic, strong) UIBarButtonItem *flipButton;
@property (nonatomic, strong) UIBarButtonItem *doneButton;

@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UITableView *colorTableView;

@property NSInteger previousColor;
@property NSInteger selectedColor;

- (IBAction)flipAction:(id)sender;
- (void)updateCloudItems:(NSNotification *)notification;

@end


#pragma mark -

@implementation RootViewController

@synthesize instructionsView = _instructionsView;
@synthesize mainView = _mainView;

@synthesize flipButton = _flipButton;
@synthesize doneButton = _doneButton;

@synthesize containerView = _containerView;
@synthesize colorTableView = _colorTableView;

@synthesize previousColor = _previousColor;
@synthesize selectedColor = _selectedColor;

static NSString *kBackgroundColorKey = @"backgroundColor";


#pragma mark -

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
		self.selectedColor = -1;
        
        // listen for key-value store changes externally from the cloud
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(updateCloudItems:)
                                                     name:NSUbiquitousKeyValueStoreDidChangeExternallyNotification 
                                                   object:[NSUbiquitousKeyValueStore defaultStore]];
        // By passing "object", it tells the cloud that we want to use "key-value store"
        // (which will allow other devices to automatically sync)
        
        // Get any change since last launch:
        // This will spark the "NSUbiquitousKeyValueStoreDidChangeExternallyNotification",
        // and in turn the "updateCloudItems" method will be called for updating.
        //
        // Important note: be careful not to call synchronize or any set calls
        // in quick succession, or you will be throttled.
    }
    return self;
}

- (UIColor *)backgroundColorFromColorIndex:(NSInteger)colorIndex
{
    UIColor *returnColor = nil;
    switch (colorIndex)
    {
        case 0:
            returnColor = [UIColor whiteColor];
            break;
        case 1:
            returnColor = [UIColor redColor];
            break;
        case 2:
            returnColor = [UIColor greenColor];
            break;
        case 3:
            returnColor = [UIColor yellowColor];
            break;
    }
    return returnColor;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"PrefsInCloud";
    
    // create the container view which we will use for flip animation (centered horizontally)
	_containerView = [[UIView alloc] initWithFrame:self.view.bounds];
	[self.view addSubview:self.containerView];
    
    [self.containerView addSubview:_mainView];
    
    // add our custom flip button as the nav bar's custom right view
	UIButton* infoButton = [UIButton buttonWithType:UIButtonTypeInfoLight];
    CGRect frame = infoButton.frame;
    frame.size.width = 40.0f;
    infoButton.frame = frame;
	[infoButton addTarget:self action:@selector(flipAction:) forControlEvents:UIControlEventTouchUpInside];
	_flipButton = [[UIBarButtonItem alloc] initWithCustomView:infoButton];
	self.navigationItem.rightBarButtonItem = self.flipButton;
	
	// create our done button as the nav bar's custom right view for the flipped view (used later)
	_doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                               target:self
                                                               action:@selector(flipAction:)];
    
    // by this time if "selectedColor" is undefined (-1), we don't have a kvc store in the cloud yet,
    // so check our local preferences (if any) to set the background color
    //
    if (self.selectedColor == -1)
    {
        if ([[NSUserDefaults standardUserDefaults] objectForKey:kBackgroundColorKey] != nil)
        {
            // we have a color preference stored on this device
            self.selectedColor = [[NSUserDefaults standardUserDefaults] integerForKey:kBackgroundColorKey];
        }
        else
        {
            // we don't have a color preference stored on this device,
            // use the default value in this case (white)
            //
            self.selectedColor = 0;  // default to white background color
        }
        self.mainView.backgroundColor = [self backgroundColorFromColorIndex:self.selectedColor];
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    self.instructionsView = nil;
    self.colorTableView = nil;
    
    self.containerView = nil;

	self.flipButton = nil;
	self.doneButton = nil;
}


#pragma mark -
#pragma mark Actions

// called when the user presses the 'i' icon to change the app settings
//
- (void)flipAction:(id)sender
{
	BOOL goingToColorChoiceView = ([self.mainView superview] != nil ? YES : NO);
    
    // save off the previous color,
    // so we can avoid setting it if the user did not change a color
    if (goingToColorChoiceView)
    {
        // we are flipping to the choose color view
        _previousColor = self.selectedColor;
    }
    else
    {
        // we are leaving the choose color view.
        // store the value change if it was different than before
        if (self.previousColor != self.selectedColor)
        {
            // set the new value in our local NSUserDefaults
            //
            // note: synchronize is called automatically by "set" call (after some delay),
            // if the server has pushed some changes to the device and automatically when the
            // app is put in the background.
            // 
            [[NSUserDefaults standardUserDefaults] setInteger:self.selectedColor forKey:kBackgroundColorKey];

            // set the new value to the cloud and synchronize
            NSUbiquitousKeyValueStore *kvStore = [NSUbiquitousKeyValueStore defaultStore];
            [kvStore setObject:[NSNumber numberWithInteger:self.selectedColor] forKey:kBackgroundColorKey];
        }
    }
    [UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.75];
	
    // since the user can turn off user tracking by simply moving the map,
    // we want to make sure our UISwitch reflects that change.
    [UIView setAnimationTransition:(goingToColorChoiceView ?
									UIViewAnimationTransitionFlipFromLeft : UIViewAnimationTransitionFlipFromRight)
                           forView:self.containerView cache:YES];
	if (goingToColorChoiceView)
    {
		[self.mainView removeFromSuperview];
		[self.containerView addSubview:self.instructionsView];
	}
    else
    {
		[self.instructionsView removeFromSuperview];
		[self.containerView addSubview:self.mainView];
	}	
	
	[UIView commitAnimations];
	
	// adjust our done/info buttons accordingly
	if (goingToColorChoiceView)
    {
        self.navigationItem.rightBarButtonItem = self.doneButton;
    }
    else
    {
        self.navigationItem.rightBarButtonItem = self.flipButton;
    }
}


#pragma mark - UITableView delegate methods

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Background Colors:";
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 4;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // clean out the old checkmark state
    for (NSInteger row = 0; row < 4; row++)
    {
        NSIndexPath *rowIndexPath = [NSIndexPath indexPathForRow:row inSection:0];
        [tableView cellForRowAtIndexPath:rowIndexPath].accessoryType = UITableViewCellAccessoryNone;
    }
     
    // apply the new checkmark state
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    _selectedColor = indexPath.row;
    self.mainView.backgroundColor = [self backgroundColorFromColorIndex:self.selectedColor];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *kOneCellID = @"cellID";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kOneCellID];
	if (cell == nil)
	{
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kOneCellID];
		cell.accessoryType = UITableViewCellAccessoryNone;
		cell.selectionStyle = UITableViewCellSelectionStyleBlue;	
	}
	
	// checkmark right table cell
    if (indexPath.row == self.selectedColor)
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    
    NSString *title = nil;
	switch (indexPath.row)
    {
        case 0:
            title = @"White";
            break;
        case 1:
            title = @"Red";
            break;
        case 2:
            title = @"Green";
            break;
        case 3:
            title = @"Yellow";
            break;
    }
	cell.textLabel.text = title;
    
	return cell;
}


#pragma mark - Cloud support

/*
 This method is called when the key-value store in the cloud has changed externally.
 The old color value is replaced with the new one
 Additionally, NSUserDefaults is updated and the table is reloaded.
 */
- (void)updateCloudItems:(NSNotification *)notification
{
	// We get more information from the notification, by using:
    //  NSUbiquitousKeyValueStoreChangeReasonKey or NSUbiquitousKeyValueStoreChangedKeysKey constants
    // against the notification's useInfo.
	//
    NSDictionary *userInfo = [notification userInfo];
    // get the reason (initial download, external change or quota violation change)
    
    NSNumber* reasonForChange = [userInfo objectForKey:NSUbiquitousKeyValueStoreChangeReasonKey];
    if (reasonForChange)
    {
        // reason was deduced, go ahead and check for the change
        //
        NSInteger reason = [[userInfo objectForKey:NSUbiquitousKeyValueStoreChangeReasonKey] integerValue];
        if (reason == NSUbiquitousKeyValueStoreServerChange ||
                // the value changed from the remote server
            reason == NSUbiquitousKeyValueStoreInitialSyncChange)
                // initial syncs happen the first time the device is synced
        {
            NSArray *changedKeys = [userInfo objectForKey:NSUbiquitousKeyValueStoreChangedKeysKey];
            
            // in case you have more than one key,
            // loop through and check for the one we want (kBackgroundColorKey)
            //
            for (NSString *changedKey in changedKeys)
            {
                if ([changedKey isEqualToString:kBackgroundColorKey])
                {
                    // note that the key used in the cloud match the key used locally
                    
                    // replace our "selectedColor" with the value from the cloud
                    NSNumber *selectedColorPrefsValue =
                            [[NSUbiquitousKeyValueStore defaultStore] objectForKey:kBackgroundColorKey];
                        
                    self.selectedColor = [selectedColorPrefsValue integerValue];
                    self.mainView.backgroundColor = [self backgroundColorFromColorIndex:self.selectedColor];
                    
                    // reset the preferred color in NSUserDefaults to keep a local value
                    [[NSUserDefaults standardUserDefaults] setInteger:self.selectedColor
                                                               forKey:kBackgroundColorKey];
                }
            }
        }
    }
}

@end
