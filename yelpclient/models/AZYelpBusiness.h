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
@property (nonatomic, strong) NSString *displayPhone;
@property (nonatomic) BOOL isClaimed;
@property (nonatomic) BOOL isClosed;
@property (nonatomic, strong) NSURL *imageUrl;
@property (nonatomic, strong) AZYelpLocation *location;
@property (nonatomic, strong) NSString *mobileUrl;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSURL *ratingImgUrl;
@property (nonatomic, strong) NSURL *ratingImgUrlLarge;
@property (nonatomic, strong) NSURL *ratingImgUrlSmall;
@property (nonatomic, strong) NSNumber *reviewCount;
@property (nonatomic, strong) NSURL *snippetImageUrl;
@property (nonatomic, strong) NSString *snippetText;
@property (nonatomic, strong) NSURL *url;
@property (nonatomic, strong) NSString *menuProvider;
@property (nonatomic, strong) NSDate *menuDateUpdated;

@end
