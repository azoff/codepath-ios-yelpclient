//
//  AZUIFilterLabel.m
//  yelpclient
//
//  Created by Jonathan Azoff on 3/24/14.
//  Copyright (c) 2014 Jonathan Azoff. All rights reserved.
//

#import "AZYelpFilterLabel.h"

@implementation AZYelpFilterLabel

- (id)initWithName:(NSString *)name
{
    self = [super initWithFrame:CGRectMake(0, 0, 320, AZ_YELP_FILTER_LABEL_HEIGHT)];
    if (self) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 320, AZ_YELP_FILTER_LABEL_HEIGHT)];
        label.font = [UIFont systemFontOfSize:15];
        label.text = name;
        [self addSubview:label];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
