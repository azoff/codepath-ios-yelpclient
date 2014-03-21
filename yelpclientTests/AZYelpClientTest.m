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

- (void)setUp
{
    [super setUp];
    _client = [AZYelpClient client];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testNotNil
{
    XCTAssertNotNil(_client);
}

- (void)testAuthorized
{
    XCTAssertTrue(_client.isAuthorized);
}

- (void)testSearch
{
    [_client searchParameters:nil success:^(id response) {
        NSLog(@"%@", response);
        [self notify:XCTAsyncTestCaseStatusSucceeded];
    } failure:^(NSError *err) {
        NSLog(@"%@", err);
        [self notify:XCTAsyncTestCaseStatusFailed];
    }];
    
    [self waitForStatus:XCTAsyncTestCaseStatusSucceeded timeout:5];
}

@end
