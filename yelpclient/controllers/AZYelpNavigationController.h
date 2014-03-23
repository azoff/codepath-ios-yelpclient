//
//  AZYelpNavigationController.h
//  yelpclient
//
//  Created by Jonathan Azoff on 3/23/14.
//  Copyright (c) 2014 Jonathan Azoff. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AZYelpNavigationSearchHandler <NSObject>

@required
-(BOOL)handleSearchTerm:(NSString*)term;

@end

@interface AZYelpNavigationController : UINavigationController<UITextFieldDelegate>

- (void)enableSearch:(id<AZYelpNavigationSearchHandler>)delegate;
- (void)disableSearch;

@end
