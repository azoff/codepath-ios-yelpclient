//
//  AZYelpBusinesses.m
//  yelpclient
//
//  Created by Jonathan Azoff on 3/20/14.
//  Copyright (c) 2014 Jonathan Azoff. All rights reserved.
//

#import "AZYelpSearchResult.h"
#import "AZYelpBusiness.h"

@implementation AZYelpSearchResult

- (Class)classForElementsInArrayProperty:(NSString *)propertyName
{
    if ([propertyName isEqualToString:@"businesses"])
        return [AZYelpBusiness class];
    return nil;
}

@end
