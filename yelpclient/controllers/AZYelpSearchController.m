//
//  AZSearchControllerViewController.m
//  yelpclient
//
//  Created by Jonathan Azoff on 3/22/14.
//  Copyright (c) 2014 Jonathan Azoff. All rights reserved.
//

#import "AZYelpSearchController.h"
#import "AZYelpBusinessCell.h"
#import "AZYelpBusiness.h"
#import "AZYelpClient.h"
#import "AZLocationManager.h"
#import "MBProgressHUD.h"

static NSInteger const SCROLL_THRESHOLD = 5;
static NSInteger const LIMIT            = 20;
static NSString *const CELL_NAME        = @"AZYelpBusinessCell";

@interface AZYelpSearchController ()

@property (weak, nonatomic) IBOutlet UITableView *searchResultsTableView;

@property (nonatomic) BOOL searching;
@property (nonatomic) NSInteger offset;
@property (nonatomic) NSInteger total;
@property (nonatomic) NSMutableArray *results;
@property (nonatomic) UIFont *nameFont;
@property (nonatomic) CLLocation *location;
@property (nonatomic) NSString *term;
@property (nonatomic) NSArray *categories;

@end

@implementation AZYelpSearchController

- (void)clearResults
{
    [self.results removeAllObjects];
    self.offset  = 0;
    self.total   = 0;
    self.term    = [[NSUserDefaults standardUserDefaults] valueForKey:@"term"];
    [self renderResults];
}

- (void)renderResults
{
    [self endSearching:YES];
    [self.searchResultsTableView reloadData];
}

- (void)startSearching:(BOOL)withLoader
{
    self.searching = true;
    if (withLoader)
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

- (void)endSearching:(BOOL)withLoader
{
    self.searching = false;
    if (withLoader)
        [MBProgressHUD hideHUDForView:self.view animated:YES];
}

- (void)showError:(NSError *)error
{
    [self endSearching:YES];
    [[[UIAlertView alloc] initWithTitle:@"Oh No!"
                              message:error.localizedDescription
                             delegate:self
                    cancelButtonTitle:@"OK"
                    otherButtonTitles:nil, nil] show];
}

- (NSDictionary *)getParams
{
    CLLocationCoordinate2D location = self.location.coordinate;
    id params = [NSMutableDictionary dictionaryWithDictionary: @{
        @"term": self.term,
        @"limit": [[NSNumber numberWithInt:LIMIT] stringValue],
        @"offset": [[NSNumber numberWithInteger:self.offset] stringValue],
        @"ll": [NSString stringWithFormat:@"%f,%f", location.latitude, location.longitude]
    }];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSArray *defaultKeys = @[@"radius_filter", @"sort", @"deals_filter"];
    [defaultKeys enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *value = [userDefaults objectForKey:obj];
        if (value != nil && value.length > 0)
            [params setValue:value forKey:obj];
    }];
    NSMutableArray *categories = [NSMutableArray array];
    [self.categories enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *value = [userDefaults objectForKey:obj];
        if (value != nil)
            [categories addObject:obj];
    }];
    if (categories.count > 0)
        [params setValue:[categories componentsJoinedByString:@","] forKey:@"category_filter"];
    NSLog(@"%@", params);
    return params;
}

- (void)setTerm:(NSString *)term
{
    _term = term;
    [[NSUserDefaults standardUserDefaults] setValue:term forKey:@"term"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)doSearch:(BOOL)showIndicator
{
    
    // avoid searching if...
    if (self.searching ||                                                    // already searching
        self.location == nil || self.term == nil || self.term.length <= 0 || // missing paraneters
        (self.total > 0 && [self resultCount] >= self.total))                // at the end of search
        return;
    
    [self startSearching:showIndicator];
    [AZYelpClient searchBusinessesWithParams:[self getParams] success:^(AZYelpSearchResult *result) {
        [self processResult:result];
    } failure:^(NSError *error) {
        [self showError:error];
    }];

}

- (void)processResult:(AZYelpSearchResult *)result
{
    self.total = [result.total integerValue];
    [self.results addObjectsFromArray:result.businesses];
    self.offset = self.results.count;
    [self renderResults];
}

- (BOOL)handleSearchTerm:(NSString *)term
{
    [self clearResults];
    self.term = term;
    [self doSearch:YES];
    return NO;
}

- (NSInteger)resultCount
{
    return self.results.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.total;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (self.results.count < self.total && indexPath.item >= (self.results.count - SCROLL_THRESHOLD))
        [self doSearch:NO];
    
    AZYelpBusinessCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_NAME forIndexPath:indexPath];
    AZYelpBusiness *business = [self.results objectAtIndex:indexPath.item];
    [cell updateBusiness:business onError:^(NSError *error) {
        [self showError:error];
    }];
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    NSInteger index = indexPath.row;
    if (index >= self.offset) index = 0;
    AZYelpBusiness *business = self.results[index];
    CGRect rect = [business.name boundingRectWithSize:CGSizeMake(_searchResultsTableView.frame.size.width, MAXFLOAT)
                                              options:NSStringDrawingUsesLineFragmentOrigin
                                           attributes:@{NSFontAttributeName: _nameFont}
                                              context:nil];
    return rect.size.height + 74;
}

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    BOOL firstTime = self.location == nil;
    self.location = newLocation;
    if (firstTime) [self doSearch:YES];
}

- (id)init
{
    self = [super init];
    if (self) {
        self.title = @"Search";
        self.results = [[NSMutableArray alloc] init];
        NSString *file = [[NSBundle mainBundle] pathForResource:@"categories" ofType:@"plist"];
        self.categories = [NSArray arrayWithContentsOfFile:file];
    }
    return self;
}

- (AZYelpNavigationController *)yelpNavigationController
{
    return (AZYelpNavigationController *)self.navigationController;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // set up table view
    self.searchResultsTableView.separatorInset = UIEdgeInsetsZero;
    self.searchResultsTableView.dataSource = self;
    self.searchResultsTableView.delegate = self;
    [self.searchResultsTableView registerNib:[UINib nibWithNibName:CELL_NAME bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CELL_NAME];
    
    // prototype cell for dynamic cell height measurements
    AZYelpBusinessCell *dummyCell = [self.searchResultsTableView dequeueReusableCellWithIdentifier:CELL_NAME];
    self.nameFont = dummyCell.nameLabel.font;
    
    // enable location tracking for local search
    [AZLocationManager setDelegate:self];
    
    [self clearResults];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[self yelpNavigationController] enableSearch:self];
    [self clearResults];
    [self doSearch:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[self yelpNavigationController] disableSearch];
}

@end
