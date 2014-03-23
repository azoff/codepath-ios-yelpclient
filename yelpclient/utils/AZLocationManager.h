//
//  AZLocationUtil.h
//  yelpclient
//
//  Created by Jonathan Azoff on 3/23/14.
//  Copyright (c) 2014 Jonathan Azoff. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AZLocationManager : NSObject

+(void)setDelegate:(id<CLLocationManagerDelegate>)delegate;

@end
