//
//  yelpclientTests.m
//  yelpclientTests
//
//  Created by Jonathan Azoff on 3/19/14.
//  Copyright (c) 2014 Jonathan Azoff. All rights reserved.
//

#import "XCTestCase+AsyncTesting.h"
#import "AZYelpClient.h"

@interface yelpclientTests : XCTestCase

@property (nonatomic) AZYelpClient *client;

@end

@implementation yelpclientTests

- (void)testSearchNoParams
{
    
    [AZYelpClient searchBusinessesWithParams:nil success:^(AZYelpSearchResult *result) {
        XCTFail(@"No business data should be received");
    } failure:^(NSError *error) {
        XCTAssertEqualObjects([error.userInfo valueForKey:@"type"], @"UNSPECIFIED_LOCATION", @"%@", error);
        [self notify:XCTAsyncTestCaseStatusSucceeded];
    }];
    
    [self waitForStatus:XCTAsyncTestCaseStatusSucceeded timeout:5];
    
}

- (void)testSearchSanFrancisco
{
    NSDictionary *params = @{@"location": @"San Francisco"};
    [AZYelpClient searchBusinessesWithParams:params success:^(AZYelpSearchResult *result) {
        XCTAssertTrue(result.total > 0);
        [self notify:XCTAsyncTestCaseStatusSucceeded];
    } failure:^(NSError *error) {
        XCTFail(@"%@", error);
    }];
    
    [self waitForStatus:XCTAsyncTestCaseStatusSucceeded timeout:5];
    
}

@end
