//
//  StreamVC.h
//  Insta
//
//  Created by aaron on 16/05/13.
//  Copyright (c) 2013 Educacion. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StreamVC : UICollectionViewController<UICollectionViewDataSource, UICollectionViewDelegate,UIActionSheetDelegate>

@property (strong, nonatomic) NSMutableArray *photos;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *camera;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *options;

@end
