//
//  AZYelpFilterController.m
//  yelpclient
//
//  Created by Jonathan Azoff on 3/23/14.
//  Copyright (c) 2014 Jonathan Azoff. All rights reserved.
//

#import "AZYelpFilterController.h"
#import "AZYelpFilterLabel.h"

static NSString *const CELL_NAME = @"AZYelpFilterCell";

@interface AZYelpFilterController ()

@property (nonatomic) NSMutableArray *rowNames;
@property (nonatomic) NSMutableArray *rowValues;
@property (nonatomic) NSMutableArray *sectionNames;
@property (nonatomic) NSMutableArray *sectionParams;
@property (nonatomic) NSMutableArray *sectionOpenStates;
@property (nonatomic) NSMutableArray *sectionHasToggles;
@property (nonatomic) NSMutableDictionary *sections;
@property (weak, nonatomic) IBOutlet UITableView *filterTableView;

@end

@implementation AZYelpFilterController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        NSString *file = [[NSBundle mainBundle] pathForResource:@"filters" ofType:@"plist"];
        self.sections          = [NSDictionary dictionaryWithContentsOfFile:file];
        self.sectionOpenStates = [NSMutableArray array];
        self.sectionHasToggles = [NSMutableArray array];
        self.sectionNames      = [NSMutableArray array];
        self.sectionParams     = [NSMutableArray array];
        self.rowNames          = [NSMutableArray array];
        self.rowValues         = [NSMutableArray array];
        [self.sections enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            [self.sectionNames addObject:[obj valueForKey:@"name"]];
            [self.sectionParams addObject:key];
            NSMutableArray *optionNames  = [NSMutableArray array];
            NSMutableArray *optionValues = [NSMutableArray array];
            NSDictionary *options = [obj valueForKey:@"options"];
            if (options) {
                [self.sectionHasToggles addObject:@NO];
                [self.sectionOpenStates addObject:@NO];
                [options enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
                    [optionNames addObject:obj];
                    [optionValues addObject:key];
                }];
            } else {
                NSDictionary *toggles = [obj valueForKey:@"toggles"];
                [self.sectionHasToggles addObject:@YES];
                [self.sectionOpenStates addObject:@YES];
                [toggles enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
                    [optionNames addObject:obj];
                    [optionValues addObject:key];
                }];
            }
            [self.rowNames addObject:optionNames];
            [self.rowValues addObject:optionValues];
        }];
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.filterTableView.separatorInset = UIEdgeInsetsZero;
    self.filterTableView.dataSource = self;
    self.filterTableView.delegate = self;
    [self.filterTableView registerNib:[UINib nibWithNibName:CELL_NAME bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CELL_NAME];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AZYelpFilterCell *cell = [self.filterTableView dequeueReusableCellWithIdentifier:CELL_NAME forIndexPath:indexPath];
    BOOL toggles = [self.sectionHasToggles[indexPath.section] boolValue];
    NSString *sectionParam = toggles ? self.rowValues[indexPath.section][indexPath.row] : self.sectionParams[indexPath.section];
    NSString *sectionValue = [[NSUserDefaults standardUserDefaults] valueForKey:sectionParam];
    if (sectionValue == nil && !toggles) sectionValue = self.rowValues[indexPath.section][0];
    
    // closed section, use the selected value
    if (![self.sectionOpenStates[indexPath.section] boolValue]) {
        
        NSDictionary *options = [[self.sections valueForKey:sectionParam] valueForKey:@"options"];
        NSString *rowName = [options valueForKey:sectionValue];
        return [cell initWithName:rowName accessoryType:UITableViewCellAccessoryCheckmark];

    // open section, selected cell
    } else {
    
        NSString *rowName = self.rowNames[indexPath.section][indexPath.row];
        if (toggles) {
            cell = [cell initWithName:rowName indexPath:indexPath on:[@"1"isEqualToString:sectionValue]];
            cell.toggleDelegate = self;
            return cell;
        } else if ([sectionValue isEqualToString:self.rowValues[indexPath.section][indexPath.row]]) {
            return [cell initWithName:rowName accessoryType:UITableViewCellAccessoryCheckmark];
        } else {
            NSString *optionName = self.rowNames[indexPath.section][indexPath.row];
            return [cell initWithName:optionName accessoryType:UITableViewCellAccessoryNone];
        }
        
    }

}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [[AZYelpFilterLabel alloc] initWithName:self.sectionNames[section]];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return AZ_YELP_FILTER_LABEL_HEIGHT;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return AZ_YELP_FILTER_OPTION_HEIGHT;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (![self.sectionOpenStates[section] boolValue]) return 1;
    NSArray *values = self.rowValues[section];
    return values.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.sectionParams.count;
}

- (void)yelpFilterCellToggle:(BOOL)toggled indexPath:(NSIndexPath *)indexPath
{
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    NSString *key = self.rowValues[indexPath.section][indexPath.row];
    if (toggled) {
        [standardUserDefaults setValue:@"1" forKey:key];
    } else {
        [standardUserDefaults removeObjectForKey:key];
    }
    [standardUserDefaults synchronize];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [self.filterTableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([self.sectionHasToggles[indexPath.section] boolValue]) return;
    
    // closed section, open it up
    if (![self.sectionOpenStates[indexPath.section] boolValue]) {
        
        self.sectionOpenStates[indexPath.section] = @YES;
        
    // open section, select and close
    } else {
        
        NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
        NSString *sectionParam = self.sectionParams[indexPath.section];
        NSString *optionValue = self.rowValues[indexPath.section][indexPath.row];
        [standardUserDefaults setValue:optionValue forKey:sectionParam];
        [standardUserDefaults synchronize];
        self.sectionOpenStates[indexPath.section] = @NO;
        
    }
    
    // force the table view to redraw
    NSIndexSet *sections = [[NSIndexSet alloc] initWithIndex:indexPath.section];
    [self.filterTableView reloadSections:sections withRowAnimation:UITableViewRowAnimationAutomatic];
    
}

@end
