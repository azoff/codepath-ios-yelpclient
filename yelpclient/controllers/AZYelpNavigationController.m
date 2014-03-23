//
//  AZYelpNavigationController.m
//  yelpclient
//
//  Created by Jonathan Azoff on 3/22/14.
//  Copyright (c) 2014 Jonathan Azoff. All rights reserved.
//

#import "AZYelpNavigationController.h"
#import "AZYelpSearchController.h"

@interface AZYelpNavigationController ()

@end

@implementation AZYelpNavigationController

- (id)init
{
    id root = [[AZYelpSearchController alloc] init];
    self = [self initWithRootViewController:root];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
