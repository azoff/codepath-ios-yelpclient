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
    if(self = [super init]) {
        self.propertyMap = @{
            @"id": @"publicID",
            @"image_url": @"thumbURLString",
            @"rating_img_url": @"ratingImageURLString",
            @"review_count": @"reviewCount",
        };
    }
    return self;
}

- (NSURLRequest *)thumbRequest
{
    return [NSURLRequest requestWithURL:[NSURL URLWithString:self.thumbURLString]];
}

- (NSURLRequest *)ratingImageRequest
{
    return [NSURLRequest requestWithURL:[NSURL URLWithString:self.ratingImageURLString]];
}

- (NSString *)displayReviewCount
{
    NSString *format = [self.reviewCount integerValue] == 1 ? @"%@ Review" : @"%@ Reviews";
    return [NSString stringWithFormat:format, self.reviewCount];
}

- (NSString *)displayCategories
{
    return [[self categoryNames] componentsJoinedByString:@", "];
}

- (NSArray *)categoryNames
{
    NSMutableArray *names = [[NSMutableArray alloc] init];
    [self.categories enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [names addObject:obj[0]];
    }];
    return names;
}

@end
