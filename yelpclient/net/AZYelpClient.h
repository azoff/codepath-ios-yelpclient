//
//  AZYelpClient.h
//  yelpclient
//
//  Created by Jonathan Azoff on 3/20/14.
//  Copyright (c) 2014 Jonathan Azoff. All rights reserved.
//
#import "BDBOAuth1SessionManager.h"

@interface AZYelpClient : BDBOAuth1SessionManager

- (id)init;

- (void)searchParameters:(NSDictionary *)parameters
                 success:(void (^)(id))success
                 failure:(void (^)(NSError *))failure;

+ (instancetype)client;

@end
