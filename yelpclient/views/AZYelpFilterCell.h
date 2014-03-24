//
//  AZYelpFilterCell.h
//  yelpclient
//
//  Created by Jonathan Azoff on 3/23/14.
//  Copyright (c) 2014 Jonathan Azoff. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSInteger const AZ_YELP_FILTER_OPTION_HEIGHT = 42;

@protocol AZYelpFilterCellToggleDelegate <NSObject>

@required
-(void)yelpFilterCellToggle:(BOOL)toggled indexPath:(NSIndexPath *)indexPath;

@end

@interface AZYelpFilterCell : UITableViewCell

- (id)initWithName:(NSString *)name accessoryType:(UITableViewCellAccessoryType)accessoryType;
- (id)initWithName:(NSString *)name indexPath:(NSIndexPath *)indexPath on:(BOOL)on;

@property (nonatomic, readonly) NSString *name;
@property (nonatomic) id<AZYelpFilterCellToggleDelegate> toggleDelegate;

@end
