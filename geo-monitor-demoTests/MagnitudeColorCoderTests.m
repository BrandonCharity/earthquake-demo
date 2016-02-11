#import <XCTest/XCTest.h>
#import "MagnitudeColorCoder.h"

@interface MagnitudeColorCoderTests : XCTestCase
@property (nonatomic) MagnitudeColorCoder *mcc;
@end

@implementation MagnitudeColorCoderTests

- (void)testGetColorForMagnitude {
    self.mcc = [[MagnitudeColorCoder alloc] initWithFirstColor:[UIColor greenColor] andSecondColor:[UIColor redColor]];
    XCTAssert([[self.mcc getColorForMagnitude:@0.0] isEqual:[UIColor greenColor]]);
    XCTAssert([[self.mcc getColorForMagnitude:@9.0] isEqual:[UIColor redColor]]);
}

@end
