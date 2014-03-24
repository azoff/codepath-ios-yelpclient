//
//  AZYelpFilterCell.m
//  yelpclient
//
//  Created by Jonathan Azoff on 3/23/14.
//  Copyright (c) 2014 Jonathan Azoff. All rights reserved.
//

#import "AZYelpFilterCell.h"

@interface AZYelpFilterCell ()

@property (weak, nonatomic) IBOutlet UILabel *filterNameLabel;
@property (weak, nonatomic) IBOutlet UISwitch *filterSwitch;
@property (nonatomic) NSIndexPath *indexPath;

@end

@implementation AZYelpFilterCell

- (id)initWithName:(NSString *)name accessoryType:(UITableViewCellAccessoryType)accessoryType
{
    self.accessoryType = accessoryType;
    self.filterSwitch.hidden = YES;
    return [self initWithName:name];
}

- (id)initWithName:(NSString *)name indexPath:(NSIndexPath *)indexPath on:(BOOL)on
{
    self.accessoryType = UITableViewCellAccessoryNone;
    self.filterSwitch.hidden = NO;
    self.filterSwitch.on = on;
    _indexPath = indexPath;
    if (indexPath != nil)
        [self.filterSwitch addTarget:self action:@selector(triggerToggleDelegate) forControlEvents:UIControlEventTouchUpInside];
    return [self initWithName:name];
}

- (id)initWithName:(NSString *)name
{
    self.filterNameLabel.text = _name = name;
    return self;
}

-(IBAction)triggerToggleDelegate
{
    if (self.toggleDelegate != nil)
        [self.toggleDelegate yelpFilterCellToggle:self.filterSwitch.isOn indexPath:self.indexPath];
}


- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
