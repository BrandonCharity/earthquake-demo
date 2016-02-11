//
//  UsgsAgent.m
//  geo-monitor-demo
//
//  Created by Brandon Charity on 1/17/16.
//  Copyright © 2016 bac.fresh. All rights reserved.
//

#import "UsgsAgent.h"

NSString * const UsgsUrlStringBase = @"http://earthquake.usgs.gov/earthquakes/feed/v1.0";

@interface UsgsAgent ()
@property (nonatomic) AFHTTPSessionManager *sessionManager;
@property (nonatomic) NSString *usgsUrlStringFull;
@end

@implementation UsgsAgent

+ (instancetype)sharedInstance {
    static UsgsAgent *sharedObject = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedObject = [[self alloc] init];
    });
    return sharedObject;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.usgsUrlStringFull = [NSString stringWithFormat:@"%@/summary/all_hour.geojson", UsgsUrlStringBase];
        self.sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:UsgsUrlStringBase] sessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        [[self.sessionManager reachabilityManager] startMonitoring];
    }
    return self;
}

- (AFNetworkReachabilityManager *)getReachabilityManager {
    return self.sessionManager.reachabilityManager;
}

- (BOOL)usgsApiIsReachable {
    return [[self.sessionManager reachabilityManager] isReachable];
}

- (BOOL)usgsApiIsReachableByWifi {
    return [[self.sessionManager reachabilityManager] isReachableViaWiFi];
}

- (BOOL)usgsApiIsReachableByWwan {
    return [[self.sessionManager reachabilityManager] isReachableViaWWAN];
}

- (void)getEarthquakesForLastHour:(afCompleted)completed {
    [self.sessionManager GET:self.usgsUrlStringFull parameters:@{} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        if (completed != nil) {
            completed(responseObject, nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (completed != nil) {
            completed(nil, error);
        }
    }];
}

@end
