//
//  StreamVC.m
//  Insta
//
//  Created by aaron on 16/05/13.
//  Copyright (c) 2013 Educacion. All rights reserved.
//

#import "StreamVC.h"
#import "StreamCell.h"
#import "UIImageView+WebCache.h"
#import "PhotoViewVC.h"
@interface StreamVC ()

@end

@implementation StreamVC
@synthesize photos=_photos;
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
    
    self.photos=[[NSMutableArray alloc] initWithCapacity:0];
    self.navigationItem.rightBarButtonItem=self.camera;
    self.navigationItem.title = @"Insta";
    self.navigationItem.leftBarButtonItem=self.options;
   
}
-(void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
  
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInCollectionView:
(UICollectionView *)collectionView
{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView
    numberOfItemsInSection:(NSInteger)section
{
    return self.photos.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                 cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    StreamCell *myCell = [collectionView
                                    dequeueReusableCellWithReuseIdentifier:@"cell"
                                    forIndexPath:indexPath];
    NSDictionary * photo=[self.photos objectAtIndex:indexPath.row];
   myCell.name.text=[NSString stringWithFormat:@"@%@",[photo objectForKey:@"username"]];
    [ myCell.image setImageWithURL:[[WS_API sharedInstance] urlForImageWithId:[photo objectForKey:@"IdPhoto"] isThumb:YES]];
    return myCell;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"photoDetail"])
    {
        NSIndexPath *selectedIndexPath = [[self.collectionView indexPathsForSelectedItems] objectAtIndex:0];
        
        NSDictionary *photo=[self.photos objectAtIndex:selectedIndexPath.row];    
        PhotoViewVC *detailViewController = [segue destinationViewController];
        detailViewController.photo = [[NSDictionary alloc] initWithDictionary:photo];
    }
}

#pragma mark ServerCalls
-(void)refresh{
}

-(void)logout {
}


#pragma mark UIActionSheet

- (IBAction)buttonUISheet:(id)sender {
    
	[[[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Close" destructiveButtonTitle:nil otherButtonTitles: @"Refresh", @"Logout", nil]
	 showInView:self.view];
}


-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 0:
            [self refresh];
			break;
        case 1:
            [self logout];
			break;
    }
}
@end
