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
    if(self = [super init])
    {
        self.propertyMap = @{@"id": @"publicID",
                             @"display_phone": @"displayPhone",
                             @"is_claimed":  @"isClaimed",
                             @"is_closed":  @"isClosed",
                             @"image_url":  @"imageUrl",
                             @"mobile_url":  @"mobileUrl",
                             @"rating_img_url":  @"ratingImgUrl",
                             @"rating_img_url_large":  @"ratingImgUrlLarge",
                             @"rating_img_url_small":  @"ratingImgUrlSmall",
                             @"review_count":  @"reviewCount",
                             @"snippet_image_url":  @"snippetImageUrl",
                             @"snippet_text":  @"snippetText",
                             @"menu_date_updated":  @"menuDateUpdated",
                             @"menu_provider": @"menuProvider"};
    }
    return self;
}

@end
