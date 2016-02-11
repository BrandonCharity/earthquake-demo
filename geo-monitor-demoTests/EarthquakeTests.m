
#import <XCTest/XCTest.h>
#import "CoreDataManager.h"
#import "Earthquake.h"

@interface EarthquakeTests : XCTestCase
@property (nonatomic) Earthquake *eq;
@property (nonatomic) NSDate *dateOne;
@property (nonatomic) NSDate *dateTwo;
@end

@implementation EarthquakeTests

- (void)setUp {
    [super setUp];
    self.eq = nil;
    [[[CoreDataManager sharedInstance] mainUIContext] reset];
    self.dateOne = [NSDate date];
    self.dateTwo = [NSDate date];
    self.eq = [NSEntityDescription insertNewObjectForEntityForName:@"Earthquake" inManagedObjectContext:[[CoreDataManager sharedInstance] mainUIContext]];
    self.eq.magnitude = @8.1;
    self.eq.location = @"somewhere in the ocean";
    self.eq.occurrenceDate = [self.dateOne copy];
    self.eq.updated = [self.dateTwo copy];
}

- (void)tearDown {
    [super tearDown];
    self.eq = nil;
    [[[CoreDataManager sharedInstance] mainUIContext] reset];
}

- (void)testGetEarthquakes {
    XCTestExpectation *queryExpectation = [self expectationWithDescription:@"get earthquakes expectation"];
    [[CoreDataManager sharedInstance] saveToDiskAsync:[[CoreDataManager sharedInstance] mainUIContext] completionBlock:^(BOOL completed) {
        NSArray<Earthquake *> *eqs = [Earthquake getEarthquakes:[[CoreDataManager sharedInstance] mainUIContext]];
        XCTAssert(eqs.count > 0);
        [queryExpectation fulfill];
    }];
    [self waitForExpectationsWithTimeout:1 handler:nil];
}

- (void)testRemoveAllEarthquakes {
    [Earthquake removeAllEarthquakes:[[CoreDataManager sharedInstance] mainUIContext]];
    XCTAssert([[CoreDataManager sharedInstance] mainUIContext].deletedObjects.count > 0);
}

@end
