//
//  AZYelpClient.m
//  yelpclient
//
//  Created by Jonathan Azoff on 3/20/14.
//  Copyright (c) 2014 Jonathan Azoff. All rights reserved.
//

#import "AZYelpClient.h"
#import "AZYelpSearchResult.h"
#import <MUJSONResponseSerializer.h>

static NSString * const BASE_URL            = @"http://api.yelp.com/v2";
static NSString * const CONSUMER_KEY        = @"iZUXdq6RAwilIHmpEftp6Q";
static NSString * const CONSUMER_SECRET     = @"-gIFJcKq8ijCs1-oMkqu_H-ZQiE";
static NSString * const ACCESS_TOKEN        = @"jJE0y79RhNtzSX6ypydAm-955LkOpfzH";
static NSString * const ACCESS_TOKEN_SECRET = @"kPD3baTf-pYMlzwL_AVcNeT1y7s";

@implementation AZYelpClient

- (id)init
{
    NSURL *baseUrl = [NSURL URLWithString:BASE_URL];
    self = [self initWithBaseURL:baseUrl consumerKey:CONSUMER_KEY consumerSecret:CONSUMER_SECRET];
    [self.requestSerializer saveAccessToken:[BDBOAuthToken tokenWithToken:ACCESS_TOKEN secret:ACCESS_TOKEN_SECRET expiration:nil]];
    return self;
}

- (void)searchParameters:(NSDictionary *)parameters
                                     success:(void (^)(id))success
                                     failure:(void (^)(NSError *))failure
{
    [self GET:@"search" responseObjectClass:[AZYelpSearchResult class] parameters:parameters success:success failure:failure];
}

- (void)GET:(NSString *)methodPath
            responseObjectClass:(Class)responseObjectClass
                     parameters:(NSDictionary *)parameters
                        success:(void (^)(id))success
                        failure:(void (^)(NSError *))failure
{
    NSError *error;
    NSString *URLString = [[NSURL URLWithString:methodPath relativeToURL:self.baseURL] absoluteString];
    NSMutableURLRequest *request = [self.requestSerializer requestWithMethod:@"GET" URLString:URLString parameters:parameters error:&error];
    
    if (error) return failure(error);
    
    NSURLSessionDataTask *task = [self dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error != nil) return failure(error);
        else success(responseObject);
    }];
    
    //MUJSONResponseSerializer * responseSerializer = [[MUJSONResponseSerializer alloc] init];
    //[task setResponseSerializer:responseSerializer];
    //[responseSerializer setResponseObjectClass:responseObjectClass];
    
    [task resume];
    
}

+ (instancetype)client
{
    return [[self alloc] init];
}

@end
