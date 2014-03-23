//
//  AZYelpBusinessCellTableViewCell.h
//  yelpclient
//
//  Created by Jonathan Azoff on 3/21/14.
//  Copyright (c) 2014 Jonathan Azoff. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AZYelpBusiness.h"

@interface AZYelpBusinessTableViewCell : UITableViewCell

- (void)updateBusiness:(AZYelpBusiness *)business onError:(void (^)(NSError *))errorHandler;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (nonatomic) AZYelpBusiness *business;

@end
