//
//  AZYelpLocation.h
//  yelpclient
//
//  Created by Jonathan Azoff on 3/20/14.
//  Copyright (c) 2014 Jonathan Azoff. All rights reserved.
//

#import "MUJSONResponseSerializer.h"

@interface AZYelpLocation : MUJSONResponseObject

@property (nonatomic, strong) NSArray *address;
@property (nonatomic, strong) NSArray *displayAddress;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *countryCode;
@property (nonatomic, strong) NSArray *neighborhoods;
@property (nonatomic, strong) NSString *crossStreets;
@property (nonatomic, strong) NSString *postalCode;
@property (nonatomic, strong) NSString *stateCode;

@end
