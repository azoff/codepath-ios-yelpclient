//
//  AZYelpBusiness.h
//  yelpclient
//
//  Created by Jonathan Azoff on 3/20/14.
//  Copyright (c) 2014 Jonathan Azoff. All rights reserved.
//

#import "MUJSONResponseSerializer.h"

@interface AZYelpBusiness : MUJSONResponseObject

@property (nonatomic, strong) NSString *publicID;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *thumbURLString;

- (NSURLRequest *)thumbRequest;

@end
