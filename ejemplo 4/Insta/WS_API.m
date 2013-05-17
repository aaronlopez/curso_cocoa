//
//  WS_API.m
//  Insta
//
//  Created by aaron on 16/05/13.
//  Copyright (c) 2013 Educacion. All rights reserved.
//

#import "WS_API.h"

#define SERVER @"http://ec2-54-216-60-9.eu-west-1.compute.amazonaws.com/"

@implementation WS_API

@synthesize user;

#pragma mark - Singleton methods
/**
 * Singleton methods
 */
+(WS_API*)sharedInstance {
    static WS_API *sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        sharedInstance = [[self alloc] initWithBaseURL:[NSURL URLWithString:SERVER]];
    });
    
    return sharedInstance;
}

#pragma mark - init
//intialize the API class with the deistination host name

-(WS_API*)init {
    //call super init
    self = [super init];
    if (self != nil) {
        //initialize the object
        user = nil;
        [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
        [self setDefaultHeader:@"Accept" value:@"application/json"];
    }
    return self;
}

-(BOOL)isAuthorized {
    return [[user objectForKey:@"IdUser"] intValue]>0;
}

-(void)commandWithParams:(NSMutableDictionary*)params onCompletion:(JSONResponseBlock)completionBlock {
	NSData* uploadFile = nil;
	if ([params objectForKey:@"file"]) {
		uploadFile = (NSData*)[params objectForKey:@"file"];
		[params removeObjectForKey:@"file"];
	}
    
    NSMutableURLRequest *apiRequest = [self multipartFormRequestWithMethod:@"POST" path:@"" parameters:params constructingBodyWithBlock: ^(id <AFMultipartFormData>formData) {
		if (uploadFile) {
			[formData appendPartWithFileData:uploadFile name:@"file" fileName:@"photo.jpg" mimeType:@"image/jpeg"];
		}
	}];
    AFJSONRequestOperation* operation = [[AFJSONRequestOperation alloc] initWithRequest: apiRequest];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        //success!
        completionBlock(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //failure :(
        completionBlock([NSDictionary dictionaryWithObject:[error localizedDescription] forKey:@"error"]);
    }];
    [operation start];
}

-(NSURL*)urlForImageWithId:(NSNumber*)IdPhoto isThumb:(BOOL)isThumb {
    NSString* urlString = [NSString stringWithFormat:@"%@/upload/%@%@.jpg", SERVER, IdPhoto, (isThumb)?@"-thumb":@""];
    return [NSURL URLWithString:urlString];
}
@end

