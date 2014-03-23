//
//  AZYelpLocation.h
//  yelpclient
//
//  Created by Jonathan Azoff on 3/22/14.
//  Copyright (c) 2014 Jonathan Azoff. All rights reserved.
//

#import "MUJSONResponseSerializer.h"

@interface AZYelpLocation : MUJSONResponseObject

@property (nonatomic, strong) NSArray *address;
@property (nonatomic, strong) NSArray *neighborhoods;

- (NSString *)shortAddress;

@end
