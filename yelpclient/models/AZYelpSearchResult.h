//
//  AZYelpBusinesses.h
//  yelpclient
//
//  Created by Jonathan Azoff on 3/20/14.
//  Copyright (c) 2014 Jonathan Azoff. All rights reserved.
//

#import "MUJSONResponseSerializer.h"
#import "AZYelpError.h"

@interface AZYelpSearchResult : MUJSONResponseObject

@property (nonatomic) NSInteger *total;
@property (nonatomic, strong) AZYelpError *error;
@property (nonatomic, strong) NSArray  *businesses;

@end
