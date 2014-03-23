//
//  AZYelpBusiness.h
//  yelpclient
//
//  Created by Jonathan Azoff on 3/20/14.
//  Copyright (c) 2014 Jonathan Azoff. All rights reserved.
//

#import "MUJSONResponseSerializer.h"
#import "AZYelpLocation.h"

@interface AZYelpBusiness : MUJSONResponseObject

@property (nonatomic, strong) NSString *publicID;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *thumbURLString;
@property (nonatomic, strong) NSString *ratingImageURLString;
@property (nonatomic, strong) NSNumber *reviewCount;
@property (nonatomic, strong) AZYelpLocation *location;

- (NSURLRequest *)thumbRequest;
- (NSURLRequest *)ratingImageRequest;
- (NSString *)displayReviewCount;

@end
