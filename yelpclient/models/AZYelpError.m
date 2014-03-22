//
//  AZYelpError.m
//  yelpclient
//
//  Created by Jonathan Azoff on 3/21/14.
//  Copyright (c) 2014 Jonathan Azoff. All rights reserved.
//

#import "AZYelpError.h"

typedef NS_ENUM(NSUInteger, StatusCode) {
    kCircle,
    kRectangle,
    kOblateSpheroid
};


@implementation AZYelpError

- (instancetype)init
{
    if(self = [super init]) {
        self.propertyMap = @{@"id": @"type"};
    }
    return self;
}

- (NSError*)nativeError
{
    NSDictionary *defaults = @{ NSLocalizedDescriptionKey: self.text, @"type": self.type };
    NSMutableDictionary *details = [NSMutableDictionary dictionaryWithDictionary:defaults];
    if (self.field) [details setValue:self.field forKey:@"field"];
    return [NSError errorWithDomain:@"yelp-api" code:1 userInfo:details];
}

@end
