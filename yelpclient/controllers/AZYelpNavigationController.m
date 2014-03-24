//
//  AZYelpNavigationController.m
//  yelpclient
//
//  Created by Jonathan Azoff on 3/23/14.
//  Copyright (c) 2014 Jonathan Azoff. All rights reserved.
//

#import "AZYelpNavigationController.h"
#import "AZYelpSearchController.h"
#import "AZYelpSearchBar.h"
#import "AZYelpFilterController.h"

@interface AZYelpNavigationController ()

@property (nonatomic) AZYelpSearchBar *searchBar;
@property (nonatomic) id<AZYelpNavigationSearchHandler> searchTermDelegate;

@end

@implementation AZYelpNavigationController

- (id)init
{
    id root = [[AZYelpSearchController alloc] init];
    self = [self initWithRootViewController:root];
    return self;
}

- (AZYelpSearchBar *)searchBar
{
    if (_searchBar != nil)
        return _searchBar;
    _searchBar = [[AZYelpSearchBar alloc] init];
    [self.navigationBar addSubview:_searchBar.view];
    return _searchBar;
}

- (IBAction)onFilterButton
{
    [self pushViewController:[[AZYelpFilterController alloc] init] animated:YES];
}

- (void)enableSearch:(id<AZYelpNavigationSearchHandler>)delegate
{
    [self.searchBar.filterButton addTarget:self action:@selector(onFilterButton) forControlEvents:UIControlEventTouchUpInside];
    self.searchBar.searchField.delegate = self;
    self.searchTermDelegate = delegate;
    self.searchBar.view.hidden = NO;
    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor clearColor]};
}

- (void)disableSearch
{
    self.searchBar.searchField.delegate = nil;
    self.searchTermDelegate = nil;
    self.searchBar.view.hidden = YES;
    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor darkTextColor]};
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField endEditing:YES];
    if (self.searchTermDelegate != nil)
        return [self.searchTermDelegate handleSearchTerm:textField.text];
    return NO;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self disableSearch];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
