#import <XCTest/XCTest.h>
#import "LayoutConstraintManager.h"

@interface LayoutConstraintManagerTests : XCTestCase
@property (nonatomic) UIView *parentView;
@property (nonatomic) UIView *childViewOne;
@property (nonatomic) UIView *childViewTwo;
@property (nonatomic, assign) CGRect parentFrame;
@end

@implementation LayoutConstraintManagerTests

- (void)setUp {
    [super setUp];
    self.parentFrame = CGRectMake(0, 0, 100, 100);
    self.parentView = [[UIView alloc] initWithFrame:self.parentFrame];
    self.childViewOne = [[UIView alloc] init];
    self.childViewTwo = [[UIView alloc] init];
    [self.parentView addSubview:self.childViewOne];
    [self.parentView addSubview:self.childViewTwo];
    [self.childViewOne setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.childViewTwo setTranslatesAutoresizingMaskIntoConstraints:NO];
}

- (void)tearDown {
    [self.childViewOne removeFromSuperview];
    [self.childViewTwo removeFromSuperview];
    self.parentView = nil;
    self.childViewOne = nil;
    self.childViewTwo = nil;
    [super tearDown];
}

- (void)testMatchChildWithParent {
    [LayoutConstraintManager matchChild:self.childViewOne withParent:self.parentView];
    [self.parentView layoutIfNeeded];
    XCTAssert(self.childViewOne.frame.size.width == self.parentView.frame.size.width);
    XCTAssert(self.childViewOne.frame.size.height == self.parentView.frame.size.height);
}

- (void)testSetHeight {
    [LayoutConstraintManager setHeight:10 ofView:self.childViewOne];
    [self.childViewOne layoutIfNeeded];
    XCTAssert(self.childViewOne.frame.size.height == 10);
}

- (void)testSetWidth {
    [LayoutConstraintManager setWidth:10 ofView:self.childViewOne];
    [self.childViewOne layoutIfNeeded];
    XCTAssert(self.childViewOne.frame.size.width == 10);
}

- (void)testStickViewToParentViewBottom {
    [LayoutConstraintManager stickView:self.childViewOne toParentViewBottom:self.parentView];
    [self.parentView layoutIfNeeded];
    XCTAssert(self.childViewOne.frame.size.width == self.parentView.frame.size.width);
}

- (void)testStickViewToParentViewTop {
    [LayoutConstraintManager stickView:self.childViewOne toParentViewTop:self.parentView];
    [self.parentView layoutIfNeeded];
    XCTAssert(self.childViewOne.frame.size.width == self.parentView.frame.size.width);
}

- (void)testStickViewToParentViewRight {
    [LayoutConstraintManager stickView:self.childViewOne toParentViewRight:self.parentView];
    [self.parentView layoutIfNeeded];
    XCTAssert(self.childViewOne.frame.size.height == self.parentView.frame.size.height);
}

- (void)testStickViewToParentViewLeft {
    [LayoutConstraintManager stickView:self.childViewOne toParentViewLeft:self.parentView];
    [self.parentView layoutIfNeeded];
    XCTAssert(self.childViewOne.frame.size.height == self.parentView.frame.size.height);
}

- (void)testSetViewBelowViewWithParentView {
    [LayoutConstraintManager setWidth:10 ofView:self.childViewOne];
    [LayoutConstraintManager setHeight:10 ofView:self.childViewOne];
    [LayoutConstraintManager setWidth:10 ofView:self.childViewTwo];
    [LayoutConstraintManager setHeight:10 ofView:self.childViewTwo];
    [LayoutConstraintManager setView:self.childViewOne belowView:self.childViewTwo withParentView:self.parentView];
    [self.parentView layoutIfNeeded];
    XCTAssert(self.childViewOne.frame.origin.y == self.childViewTwo.frame.origin.y + 10);
}

- (void)testSetViewAboveViewWithParentView {
    [LayoutConstraintManager setWidth:10 ofView:self.childViewOne];
    [LayoutConstraintManager setHeight:10 ofView:self.childViewOne];
    [LayoutConstraintManager setWidth:10 ofView:self.childViewTwo];
    [LayoutConstraintManager setHeight:10 ofView:self.childViewTwo];
    [LayoutConstraintManager setView:self.childViewOne aboveView:self.childViewTwo withParentView:self.parentView];
    [self.parentView layoutIfNeeded];
    XCTAssert(self.childViewOne.frame.origin.y == self.childViewTwo.frame.origin.y - 10);
}

- (void)testSetViewLeftOfViewWithParentView {
    [LayoutConstraintManager setWidth:10 ofView:self.childViewOne];
    [LayoutConstraintManager setHeight:10 ofView:self.childViewOne];
    [LayoutConstraintManager setWidth:10 ofView:self.childViewTwo];
    [LayoutConstraintManager setHeight:10 ofView:self.childViewTwo];
    [LayoutConstraintManager setView:self.childViewOne leftOfView:self.childViewTwo withParentView:self.parentView];
    [self.parentView layoutIfNeeded];
    XCTAssert(self.childViewOne.frame.origin.x == self.childViewTwo.frame.origin.x - 10);
}

- (void)testSetViewRightOfViewWithParentView {
    [LayoutConstraintManager setWidth:10 ofView:self.childViewOne];
    [LayoutConstraintManager setHeight:10 ofView:self.childViewOne];
    [LayoutConstraintManager setWidth:10 ofView:self.childViewTwo];
    [LayoutConstraintManager setHeight:10 ofView:self.childViewTwo];
    [LayoutConstraintManager setView:self.childViewOne rightOfView:self.childViewTwo withParentView:self.parentView];
    [self.parentView layoutIfNeeded];
    XCTAssert(self.childViewOne.frame.origin.x == self.childViewTwo.frame.origin.x + 10);
}

@end
