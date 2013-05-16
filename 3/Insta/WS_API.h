//
//  WS_API.h
//  Insta
//
//  Created by aaron on 16/05/13.
//  Copyright (c) 2013 Educacion. All rights reserved.
//

#import "AFHTTPClient.h"
#import "AFNetworking.h"

typedef void (^JSONResponseBlock)(NSDictionary* json);

@interface WS_API : AFHTTPClient

@property (strong, nonatomic) NSDictionary* user;

+(WS_API*)sharedInstance;

-(BOOL)isAuthorized;

-(void)commandWithParams:(NSMutableDictionary*)params onCompletion:(JSONResponseBlock)completionBlock;
-(NSURL*)urlForImageWithId:(NSNumber*)IdPhoto isThumb:(BOOL)isThumb;
@end
