//
//  AZYelpLocation.m
//  yelpclient
//
//  Created by Jonathan Azoff on 3/20/14.
//  Copyright (c) 2014 Jonathan Azoff. All rights reserved.
//

#import "AZYelpLocation.h"

@implementation AZYelpLocation

- (instancetype)init
{
    if(self = [super init])
    {
        self.propertyMap = @{@"country_code": @"countryCode",
                             @"state_code": @"stateCode",
                             @"display_address":  @"displayAddress",
                             @"cross_streets":  @"crossStreets",
                             @"postal_code": @"postalCode"};
    }
    return self;
}

- (Class)classForElementsInArrayProperty:(NSString *)propertyName
{
    return [NSString class];
}

@end
