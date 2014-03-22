//
//  AZYelpError.h
//  yelpclient
//
//  Created by Jonathan Azoff on 3/21/14.
//  Copyright (c) 2014 Jonathan Azoff. All rights reserved.
//

#import "MUJSONResponseSerializer.h"

@interface AZYelpError : MUJSONResponseObject

@property (nonatomic, strong) NSString* type;
@property (nonatomic, strong) NSString* text;
@property (nonatomic, strong) NSString* field;

- (NSError*)nativeError;

@end
