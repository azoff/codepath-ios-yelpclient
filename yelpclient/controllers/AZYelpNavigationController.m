//
//  AZYelpNavigationController.m
//  yelpclient
//
//  Created by Jonathan Azoff on 3/23/14.
//  Copyright (c) 2014 Jonathan Azoff. All rights reserved.
//

#import "AZYelpNavigationController.h"
#import "AZYelpSearchController.h"

@interface AZYelpNavigationController ()

@property (nonatomic) UITextField *searchField;
@property (nonatomic) id<AZYelpNavigationSearchHandler> searchTermDelegate;

@end

@implementation AZYelpNavigationController

- (id)init
{
    id root = [[AZYelpSearchController alloc] init];
    self = [self initWithRootViewController:root];
    return self;
}

- (UITextField *)searchField
{
    if (_searchField != nil)
        return _searchField;
    _searchField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 200, 50)];
    _searchField.delegate = self;
    _searchField.hidden = YES;
    [self.navigationBar addSubview:_searchField];
    return _searchField;
}

- (void)enableSearch:(id<AZYelpNavigationSearchHandler>)delegate
{
    self.searchTermDelegate = delegate;
    self.searchField.hidden = NO;
}

- (void)disableSearch
{
    self.searchTermDelegate = nil;
    self.searchField.hidden = YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.searchField endEditing:YES];
    if (self.searchTermDelegate != nil)
        return [self.searchTermDelegate handleSearchTerm:textField.text];
    return NO;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
