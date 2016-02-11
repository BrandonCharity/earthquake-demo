//
//  UsgsAgent.h
//  geo-monitor-demo
//
//  Created by Brandon Charity on 1/17/16.
//  Copyright © 2016 bac. All rights reserved.
//

#import <AFNetworking/AFHTTPSessionManager.h>

typedef void(^afCompleted)(id responseObject, NSError *error);

@interface UsgsAgent : NSObject
+ (instancetype)sharedInstance;
- (AFNetworkReachabilityManager *)getReachabilityManager;
- (BOOL)usgsApiIsReachable;
- (BOOL)usgsApiIsReachableByWifi;
- (BOOL)usgsApiIsReachableByWwan;
- (void)getEarthquakesForLastHour:(afCompleted)completed;
@end
