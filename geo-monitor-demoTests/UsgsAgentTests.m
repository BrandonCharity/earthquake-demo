//
//  UsgsAgentTests.m
//  geo-monitor-demo
//
//  Created by Brandon Charity on 2/10/16.
//  Copyright © 2016 bac.fresh. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "UsgsAgent.h"

@interface UsgsAgentTests : XCTestCase
@property (nonatomic) UsgsAgent *usgsAgent;
@end

@implementation UsgsAgentTests

- (void)setUp {
    [super setUp];
    self.usgsAgent = [[UsgsAgent alloc] init];
}

- (void)testGetEarthquakesForLastHour {
    XCTestExpectation *usgsExpectation = [self expectationWithDescription:@"usgs get earthquakes"];
    [self.usgsAgent getEarthquakesForLastHour:^(id responseObject, NSError *error) {
        if (error) {
            XCTAssert(NO);
        }
        else {
            NSDictionary *resultsDic = (NSDictionary *)responseObject;
            XCTAssert(resultsDic[@"type"] != nil);
            XCTAssert(resultsDic[@"metadata"][@"title"] != nil);
        }
        [usgsExpectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:10 handler:nil];
}

@end
