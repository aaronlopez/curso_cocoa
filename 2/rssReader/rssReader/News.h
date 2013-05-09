//
//  Tweet.h
//  XMLParserTutorial
//
//  Created by Kent Franks on 5/6/11.
//  Copyright 2011 TheAppCodeBlog. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface News : NSObject
{
	NSString	 *title;
	NSString	 *description;
    NSString     *pubdate;
	
}

@property (nonatomic, retain) NSString	 *title;
@property (nonatomic, retain) NSString	 *description;
@property (nonatomic, retain)    NSString     *pubdate;

@end
