//
//  AZSearchControllerViewController.m
//  yelpclient
//
//  Created by Jonathan Azoff on 3/22/14.
//  Copyright (c) 2014 Jonathan Azoff. All rights reserved.
//

#import "AZYelpSearchController.h"
#import "AZYelpBusinessTableViewCell.h"
#import "AZYelpBusiness.h"
#import "AZYelpClient.h"
#import "MBProgressHUD.h"

static NSInteger const LIMIT     = 20;
static NSString *const CELL_NAME = @"AZYelpBusinessTableViewCell";

@interface AZYelpSearchController ()

@property (weak, nonatomic) IBOutlet UITableView *searchResultsTableView;

@property (nonatomic) NSInteger offset;
@property (nonatomic) NSInteger total;
@property (nonatomic) NSMutableArray *results;
@property (nonatomic) NSString *term;
@property (nonatomic) UIFont *nameFont;

@end

@implementation AZYelpSearchController

- (void)clearResults
{
    [self.results removeAllObjects];
    self.offset  = 0;
    self.total   = 0;
    self.term    = @"Lunch";//TODO: use real term
    [self renderResults];
}

- (void)renderResults
{
    [self hideLoader];
    [self.searchResultsTableView reloadData];
}

- (void)showLoader
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

- (void)hideLoader
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

- (void)showError:(NSError *)error
{
    [self hideLoader];
    [[[UIAlertView alloc] initWithTitle:@"Oh No!"
                              message:error.localizedDescription
                             delegate:self
                    cancelButtonTitle:@"OK"
                    otherButtonTitles:nil, nil] show];
}

- (NSDictionary *)getParams
{
    return @{
        @"term": self.term,
        @"limit": [[NSNumber numberWithInt:LIMIT] stringValue],
        @"offset": [[NSNumber numberWithInteger:self.offset] stringValue],
        @"location": @"San Francisco" //TODO: change this to use loc
    };
}

- (void)doSearch
{
    if (self.term == nil || self.term.length <= 0)
        return [self clearResults];
    
    if (self.total > 0 && [self resultCount] >= self.total)
        return;
    
    [self showLoader];
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
    if (indexPath.item >= [self resultCount])
        return nil;
    
    AZYelpBusinessTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_NAME forIndexPath:indexPath];
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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Search";
        self.results = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // set up table view
    self.searchResultsTableView.separatorInset = UIEdgeInsetsZero;
    self.searchResultsTableView.dataSource = self;
    self.searchResultsTableView.delegate = self;
    [self.searchResultsTableView registerNib:[UINib nibWithNibName:CELL_NAME bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CELL_NAME];
    
    AZYelpBusinessTableViewCell *dummyCell = (AZYelpBusinessTableViewCell*) [self.searchResultsTableView dequeueReusableCellWithIdentifier:CELL_NAME];
    self.nameFont = dummyCell.nameLabel.font;
    
    [self clearResults];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self doSearch];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
