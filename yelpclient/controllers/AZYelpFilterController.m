//
//  AZYelpFilterController.m
//  yelpclient
//
//  Created by Jonathan Azoff on 3/23/14.
//  Copyright (c) 2014 Jonathan Azoff. All rights reserved.
//

#import "AZYelpFilterController.h"

@interface AZYelpFilterController ()

@property (nonatomic) NSArray *sections;
@property (weak, nonatomic) IBOutlet UITableView *filterTableView;

@end

@implementation AZYelpFilterController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        NSString *valuesFile = [[NSBundle mainBundle] pathForResource:@"filterValues" ofType:@"plist"];
        self.sections = [NSArray arrayWithContentsOfFile:valuesFile];
    }
    return self;
}

- (NSDictionary *)section:(NSInteger)index
{
    return self.sections[index];
}

- (NSArray *)sectionValues:(NSInteger)index
{
    NSArray *values = [[self section:index] objectForKey:@"values"];
    return values == nil ? @[] : values;
}

- (NSDictionary *)sectionValue:(NSIndexPath *)index
{
    return [self sectionValues:index.section][index.row];
}

- (NSString *)sectionValueName:(NSIndexPath *)index
{
    return [[self sectionValue:index] objectForKey:@"name"];
}

- (NSString *)sectionName:(NSInteger)index
{
    return [[self section:index] objectForKey:@"name"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.filterTableView.separatorInset = UIEdgeInsetsZero;
    self.filterTableView.dataSource = self;
    self.filterTableView.delegate = self;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
    label.text = [self sectionValueName:indexPath];
    [cell addSubview:label];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 80)];
    label.text = [self sectionName:section];
    return  label;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 80;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self sectionValues:section].count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.sections.count;
}

@end
