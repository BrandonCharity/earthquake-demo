#import <XCTest/XCTest.h>
#import "ColorInterpolator.h"

@interface ColorInterpolatorTests : XCTestCase
@property (nonatomic) ColorInterpolator *ci;
@end

@implementation ColorInterpolatorTests

- (void)testGetColorWithStep {
    UIColor *redColor = [UIColor redColor];
    UIColor *greenColor = [UIColor greenColor];
    self.ci = [[ColorInterpolator alloc] initWithFirstColor:redColor andSecondColor:greenColor withStepNumber:@4];
    XCTAssert([[self.ci getColorForStep:@1] isEqual:redColor]);
    XCTAssert([[self.ci getColorForStep:@4] isEqual:greenColor]);
}

@end
