//
//  AZYelpSearchBar.m
//  yelpclient
//
//  Created by Jonathan Azoff on 3/23/14.
//  Copyright (c) 2014 Jonathan Azoff. All rights reserved.
//

#import "AZYelpSearchBar.h"

@interface AZYelpSearchBar ()

@end

@implementation AZYelpSearchBar

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.searchField.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"term"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
