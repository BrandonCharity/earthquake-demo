#import <XCTest/XCTest.h>
#import "Earthquake.h"
#import "GeoJsonFeature.h"
#import "GeoJsonFeatureCollection.h"
#import "GeoJsonGeometry.h"
#import "GeoJsonKeys.h"
#import "GeoJsonMetaData.h"
#import "GeoJsonToManagedObject.h"
#import "GeoJsonUsgsProperties.h"
#import "Position.h"
#import "UsgsKeys.h"

@interface GeoJsonTests : XCTestCase
@property (nonatomic) NSDictionary *featureTestData;
@property (nonatomic) NSDictionary *featureCollectionTestData;
@end

@implementation GeoJsonTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    /*
    {"type":"FeatureCollection","metadata":{"generated":1455146801000,"url":"http://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_hour.geojson","title":"USGS All Earthquakes, Past Hour","status":200,"api":"1.1.1","count":2},"features":[,
        {"type":"Feature","properties":{"mag":1.73,"place":"15km SSE of Willow Creek, California","time":1455143459690,"updated":1455146584871,"tz":-480,"url":"http://earthquake.usgs.gov/earthquakes/eventpage/nc72589025","detail":"http://earthquake.usgs.gov/earthquakes/feed/v1.0/detail/nc72589025.geojson","felt":null,"cdi":null,"mmi":null,"alert":null,"status":"reviewed","tsunami":0,"sig":46,"net":"nc","code":"72589025","ids":",nc72589025,","sources":",nc,","types":",cap,general-link,geoserve,nearby-cities,origin,phase-data,scitech-link,","nst":8,"dmin":0.2822,"rms":0.13,"gap":241,"magType":"md","type":"earthquake","title":"M 1.7 - 15km SSE of Willow Creek, California"},"geometry":{"type":"Point","coordinates":[-123.5305,40.8201667,16.6]},"id":"nc72589025"}],"bbox":[-123.5305,38.8411674,0.4,-122.7645035,40.8201667,16.6]}
     */
    self.featureTestData = @{
                             GeoJsonTypeKey:@"Feature",
                             GeoJsonPropertiesKey:@{
                                     UsgsMagnitudeKey:@1.08,
                                     UsgsPlaceKey:@"4km WNW of Cobb, California",
                                     UsgsTimeKey:@1455145691690,
                                     UsgsUpdatedKey:@1455146525868,
                                     UsgsDetailKey:@"http://earthquake.usgs.gov/earthquakes/feed/v1.0/detail/nc72589035.geojson"
                                     },
                             GeoJsonGeometryKey:@{
                                     GeoJsonTypeKey:@"Point",
                                     GeoJsonCoordinatesKey:@[@-122.7645035,@38.8411674,@0.4],
                                     GeoJsonIdKey:@"nc72589035"
                                     }
                             };
    self.featureCollectionTestData = @{
                                       GeoJsonMetaDataKey:@{
                                               GeoJsonTitleKey:@"USGS All Earthquakes, Past Hour"
                                               },
                                       GeoJsonFeaturesKey:@[self.featureTestData]
                                       };
}

- (void)testGeoJsonFeatureCollectionInitWithInfo {
    GeoJsonFeatureCollection *featureCollection = [[GeoJsonFeatureCollection alloc] initWithInfo:self.featureCollectionTestData];
    XCTAssert([featureCollection.metadata isKindOfClass:[GeoJsonMetaData class]]);
    XCTAssert([featureCollection.metadata.title isEqualToString:self.featureCollectionTestData[GeoJsonMetaDataKey][GeoJsonTitleKey]]);
    XCTAssert([featureCollection.features[0] isKindOfClass:[GeoJsonFeature class]]);
}

- (void)testGeoJsonFeatureInitWithInfo {
    GeoJsonFeature *feature = [[GeoJsonFeature alloc] initWithInfo:self.featureTestData];
    XCTAssert([feature.geometry isKindOfClass:[GeoJsonGeometry class]]);
    XCTAssert([feature.geometry.coordinates[0] doubleValue] == [self.featureTestData[GeoJsonGeometryKey][GeoJsonCoordinatesKey][0] doubleValue]);
    XCTAssert([feature.geometry.coordinates[1] doubleValue] == [self.featureTestData[GeoJsonGeometryKey][GeoJsonCoordinatesKey][1] doubleValue]);
    XCTAssert([feature.geometry.coordinates[2] doubleValue] == [self.featureTestData[GeoJsonGeometryKey][GeoJsonCoordinatesKey][2] doubleValue]);
    XCTAssert([feature.properties isKindOfClass:[GeoJsonUsgsProperties class]]);
    XCTAssert([feature.properties.magnitude doubleValue] == [self.featureTestData[GeoJsonPropertiesKey][UsgsMagnitudeKey] doubleValue]);
    XCTAssert([feature.properties.place isEqualToString:self.featureTestData[GeoJsonPropertiesKey][UsgsPlaceKey]]);
    XCTAssert([feature.properties.time isEqualToDate:[NSDate dateWithTimeIntervalSince1970:[self.featureTestData[GeoJsonPropertiesKey][UsgsTimeKey] longLongValue] / 1000]]);
    XCTAssert([feature.properties.updated isEqualToDate:[NSDate dateWithTimeIntervalSince1970:[self.featureTestData[GeoJsonPropertiesKey][UsgsUpdatedKey] longLongValue] / 1000]]);
}

- (void)testFeatureToEarthquake {
    Earthquake *eq = [GeoJsonToManagedObject featureToEarthquake:[[GeoJsonFeature alloc] initWithInfo:self.featureTestData]];
    XCTAssert([eq isKindOfClass:[Earthquake class]]);
    XCTAssert([eq.magnitude doubleValue] == [self.featureTestData[GeoJsonPropertiesKey][UsgsMagnitudeKey] doubleValue]);
    XCTAssert([eq.location isEqualToString:self.featureTestData[GeoJsonPropertiesKey][UsgsPlaceKey]]);
    XCTAssert([eq.occurrenceDate isEqualToDate:[NSDate dateWithTimeIntervalSince1970:[self.featureTestData[GeoJsonPropertiesKey][UsgsTimeKey] longLongValue] / 1000]]);
    XCTAssert([eq.updated isEqualToDate:[NSDate dateWithTimeIntervalSince1970:[self.featureTestData[GeoJsonPropertiesKey][UsgsUpdatedKey] longLongValue] / 1000]]);
    [eq.coordinates enumerateObjectsUsingBlock:^(Position * _Nonnull obj, BOOL * _Nonnull stop) {
        XCTAssert([obj.longitude doubleValue] == [self.featureTestData[GeoJsonGeometryKey][GeoJsonCoordinatesKey][0] doubleValue]);
        XCTAssert([obj.latitude doubleValue] == [self.featureTestData[GeoJsonGeometryKey][GeoJsonCoordinatesKey][1] doubleValue]);
        XCTAssert([obj.depth doubleValue] == [self.featureTestData[GeoJsonGeometryKey][GeoJsonCoordinatesKey][2] doubleValue]);
    }];
}

@end
