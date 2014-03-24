//
//  AZYelpBusinessCellTableViewCell.m
//  yelpclient
//
//  Created by Jonathan Azoff on 3/21/14.
//  Copyright (c) 2014 Jonathan Azoff. All rights reserved.
//
#import "AZYelpBusinessCell.h"
#import "UIImageView+AFNetworking.h"

@interface AZYelpBusinessCell ()

@property (weak, nonatomic) IBOutlet UIImageView *thumbImageView;
@property (weak, nonatomic) IBOutlet UIImageView *ratingImageView;
@property (weak, nonatomic) IBOutlet UILabel *reviewsLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *categoriesLabel;

@end

@implementation AZYelpBusinessCell

- (void)updateBusiness:(AZYelpBusiness *)business onError:(void (^)(NSError *))errorHandler
{
    self.business = business;
    self.nameLabel.text = business.name;
    self.reviewsLabel.text = [business displayReviewCount];
    self.addressLabel.text = [business.location shortAddress];
    self.categoriesLabel.text = [business displayCategories];
    [self.thumbImageView setImageWithURLRequest:business.thumbRequest placeholderImage:nil success:nil
        failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
            errorHandler(error);
        }
    ];
    [self.ratingImageView setImageWithURLRequest:business.ratingImageRequest placeholderImage:nil success:nil
        failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
            errorHandler(error);
        }
    ];
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
