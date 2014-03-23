//
//  AZYelpBusiness.m
//  yelpclient
//
//  Created by Jonathan Azoff on 3/20/14.
//  Copyright (c) 2014 Jonathan Azoff. All rights reserved.
//

#import "AZYelpBusiness.h"

@implementation AZYelpBusiness

- (instancetype)init
{
    if(self = [super init]) {
        self.propertyMap = @{
            @"id": @"publicID",
            @"image_url": @"thumbURLString"
        };
    }
    return self;
}

- (NSURLRequest *)thumbRequest
{
    return [NSURLRequest requestWithURL:[NSURL URLWithString:self.thumbURLString]];
}

- (Class)classForElementsInArrayProperty:(NSString *)propertyName
{
    return nil;
}

@end
