//
//  AZYelpClient.m
//  yelpclient
//
//  Created by Jonathan Azoff on 3/20/14.
//  Copyright (c) 2014 Jonathan Azoff. All rights reserved.
//

#import "AZYelpClient.h"
#import <GCOAuth.h>
#import <MUJSONResponseSerializer.h>
#import <AFHTTPRequestOperationManager.h>

static NSString * const API_SCHEME      = @"http";
static NSString * const API_HOST        = @"api.yelp.com";
static NSString * const API_VERSION     = @"v2";
static NSString * const CONSUMER_KEY    = @"iZUXdq6RAwilIHmpEftp6Q";
static NSString * const CONSUMER_SECRET = @"-gIFJcKq8ijCs1-oMkqu_H-ZQiE";
static NSString * const TOKEN           = @"jJE0y79RhNtzSX6ypydAm-955LkOpfzH";
static NSString * const TOKEN_SECRET    = @"kPD3baTf-pYMlzwL_AVcNeT1y7s";

static AZYelpClient *_sharedClient;

@implementation AZYelpClient

+ (void)searchBusinessesWithParams:(NSDictionary *)params
                                     success:(void (^)(AZYelpSearchResult *))success
                                     failure:(void (^)(NSError *))failure
{
    [self getResponseWithObjectClass:[AZYelpSearchResult class]
                                path:@"search"
                          parameters:params
                             success:^(id responseObject) {
                                 AZYelpSearchResult* result = (AZYelpSearchResult*) responseObject;
                                 if (!result.error) return success(result);
                                 else failure([result.error nativeError]);
                             }
                             failure: failure];
}


+ (void)getResponseWithObjectClass:(Class)responseObjectClass
                              path:(NSString *)methodPath
                        parameters:(NSDictionary *)GETParameters
                           success:(void (^)(id))success
                           failure:(void (^)(NSError *))failure
{
    
    // sign the request
    NSString *path = [NSString stringWithFormat:@"/%@/%@", API_VERSION, methodPath];
    NSURLRequest *request = [GCOAuth URLRequestForPath:path
                                         GETParameters:GETParameters
                                                scheme:API_SCHEME
                                                  host:API_HOST
                                           consumerKey:CONSUMER_KEY
                                        consumerSecret:CONSUMER_SECRET
                                           accessToken:TOKEN
                                           tokenSecret:TOKEN_SECRET];
    
    // set up the response handler
    id responseSerializer = [[MUJSONResponseSerializer alloc] init];
    id acceptCodes = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(200, 400)];
    [responseSerializer setResponseObjectClass:responseObjectClass];
    [responseSerializer setAcceptableStatusCodes:acceptCodes];
    
    // create the HTTP client
    AFHTTPRequestOperationManager *client = [[AFHTTPRequestOperationManager alloc] init];
    [client setResponseSerializer:responseSerializer];
    
    // issue the request
    [client.operationQueue addOperation:[client HTTPRequestOperationWithRequest:request
        success:^(AFHTTPRequestOperation *operation, id responseObject) {
            success(responseObject);
        }
        failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            failure(error);
        }
     ]];
    
}


@end
