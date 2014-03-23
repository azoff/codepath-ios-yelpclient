//
//  AZYelpLocation.m
//  yelpclient
//
//  Created by Jonathan Azoff on 3/22/14.
//  Copyright (c) 2014 Jonathan Azoff. All rights reserved.
//

#import "AZYelpLocation.h"

@implementation AZYelpLocation

- (NSString *)shortAddress
{
    return [NSString stringWithFormat:@"%@, %@", self.address[0], self.neighborhoods[0]];
}

@end
