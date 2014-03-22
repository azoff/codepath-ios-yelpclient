//
//  AZYelpClient.h
//  yelpclient
//
//  Created by Jonathan Azoff on 3/20/14.
//  Copyright (c) 2014 Jonathan Azoff. All rights reserved.
//
#import "AZYelpSearchResult.h"

@interface AZYelpClient : NSObject

+ (void)searchBusinessesWithParams:(NSDictionary *)params
                           success:(void (^)(AZYelpSearchResult *))success
                           failure:(void (^)(NSError *))failure;

@end
