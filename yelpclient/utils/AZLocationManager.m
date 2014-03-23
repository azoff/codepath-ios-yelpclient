//
//  AZLocationUtil.m
//  yelpclient
//
//  Created by Jonathan Azoff on 3/23/14.
//  Copyright (c) 2014 Jonathan Azoff. All rights reserved.
//

#import "AZLocationManager.h"

static CLLocationManager const * _manager;

@implementation AZLocationManager

+(CLLocationManager const *)manager
{
    if (_manager != nil) return _manager;
    _manager = [[CLLocationManager alloc] init];
    _manager.desiredAccuracy = kCLLocationAccuracyBest;
    _manager.distanceFilter = kCLDistanceFilterNone;
    [_manager startUpdatingLocation];
    return _manager;
}

+(void)setDelegate:(id<CLLocationManagerDelegate>)delegate
{
    [self manager].delegate = delegate;
}


@end
