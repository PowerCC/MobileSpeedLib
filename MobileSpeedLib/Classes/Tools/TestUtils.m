//
//  TestUtils.m
//  MobileSpeed
//
//  Created by 邹程 on 2020/4/23.
//  Copyright © 2020 邹程. All rights reserved.
//

#import "TestUtils.h"
#import <GBDeviceInfo/GBDeviceInfo.h>
#import <FCUUID/FCUUID.h>
#import <INTULocationManager/INTULocationManager.h>

@interface TestUtils ()

@end

@implementation TestUtils

static TestUtils *testUtils = nil;
+ (instancetype)sharedInstance {
    if (testUtils == nil) {
        testUtils = [[TestUtils alloc]init];
        testUtils.speedUpUtils = [[SpeedUpUtils alloc] init];
    }
    return testUtils;
}

- (void)getDeviceInfo:(DeviceInfoHandler)infoHandler {
    DeviceInfoModel *infoModel = [DeviceInfoModel shared];
    GBDeviceInfo *deviceInfo = [GBDeviceInfo deviceInfo];

    infoModel.osVer = [NSString stringWithFormat:@"%lu.%lu.%lu", (unsigned long)deviceInfo.osVersion.major, (unsigned long)deviceInfo.osVersion.minor, (unsigned long)deviceInfo.osVersion.patch];
    infoModel.phoneModel = [NSString stringWithFormat:@"%@（%@）", deviceInfo.modelString, deviceInfo.rawSystemInfoString];
    infoModel.mobileNetworkStandard = [NSString stringWithFormat:@"%@%@", [DeviceUtils getDeviceCarrierName], [DeviceUtils getDeviceNetworkName]];
    infoModel.uuid = [FCUUID uuid];

    PhoneNetManager *phoneNetManager = [PhoneNetManager shareInstance];

    if ([phoneNetManager.netGetNetworkInfo.deviceNetInfo.netType isEqual:@"WIFI"]) {
        infoModel.intranetIP = phoneNetManager.netGetNetworkInfo.deviceNetInfo.wifiIPV4;
    } else {
        infoModel.intranetIP = phoneNetManager.netGetNetworkInfo.deviceNetInfo.cellIPV4;
    }

    [_speedUpUtils getAreaInfo:^(SpeedUpAreaInfoModel *_Nullable model) {
        infoModel.publicIP = model.ip;
        infoModel.cityCode = model.areaId;
        infoModel.location = model.regionName;
        infoModel.ispId = model.ispId;

        INTULocationManager *locMgr = [INTULocationManager sharedInstance];
        [locMgr requestLocationWithDesiredAccuracy:INTULocationAccuracyCity
                                           timeout:10.0
                              delayUntilAuthorized:YES
                                             block:^(CLLocation *currentLocation, INTULocationAccuracy achievedAccuracy, INTULocationStatus status) {
            if (status == INTULocationStatusSuccess) {
                NSString *la = [NSString stringWithFormat:@"%f", currentLocation.coordinate.latitude];
                NSString *lo = [NSString stringWithFormat:@"%f", currentLocation.coordinate.longitude];
                infoModel.latitude = la;
                infoModel.longitude = lo;
            } else if (status == INTULocationStatusTimedOut) {
                infoModel.latitude = @"";
                infoModel.longitude = @"";
            } else {
                infoModel.latitude = @"";
                infoModel.longitude = @"";
            }

            if (infoHandler) {
                infoHandler(infoModel);
            }
        }];
    }];
}

- (void)ping:(NSString *_Nonnull)host port:(NSUInteger)port count:(NSUInteger)count complete:(PNTcpPingHandler _Nonnull)complete {
    _tcpPing = [PNTcpPing start:host port:port count:count complete:complete];
}

- (void)stopPing {
    if (_tcpPing) {
        [_tcpPing stopTcpPing];
    }
}

- (void)httpDownloadFile:(NSString *)fileUrl progress:(void (^)(NSProgress *downloadProgress))downloadProgressBlock completionHandler:(void (^)(NSURLResponse *response, NSURL *filePath, NSError *error))completionHandler {
    if (_speedUpUtils == nil) {
        _speedUpUtils = [[SpeedUpUtils alloc] init];
    }

    _downloadTask = [_speedUpUtils downloadFile:fileUrl progress:downloadProgressBlock completionHandler:completionHandler];
}

- (void)stopHttpDownloadFile {
    if (_downloadTask) {
        [_downloadTask cancel];
    }
}

- (void)udpTest:(NSString *_Nonnull)host port:(uint16_t)port aDelegate:(id<GCDAsyncUdpSocketDelegate>)aDelegate {
    if (_udpSocket == nil) {
        _udpSocket = [[GCDAsyncUdpSocket alloc]initWithDelegate:aDelegate delegateQueue:dispatch_get_main_queue()];

        NSError *error = nil;
        [_udpSocket bindToPort:port error:&error];
        if (error) {//监听错误打印错误信息
            NSLog(@"error:%@", error);
        } else {//监听成功则开始接收信息
            [_udpSocket beginReceiving:&error];
        }
    }

    [_udpSocket sendData:[@"test" dataUsingEncoding:NSUTF8StringEncoding] toHost:host port:port withTimeout:-1 tag:0];
}

- (void)stopUdpTest {
    [_udpSocket pauseReceiving];
}

- (void)trace:(NSString *_Nonnull)host port:(NSString *)port stepCallback:(TracerouteStepCallback)stepCallback finish:(TracerouteFinishCallback)finish {
    _traceroute = [Traceroute startTracerouteWithHost:host port:port queue:dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0) stepCallback:stepCallback finish:finish];
}

- (void)stopTrace {
    _traceroute.maxTtl = 0;
}

- (void)uploadTestResult:(NSString *_Nonnull)method port:(NSString *)port duration:(NSString *)duration testParams:(NSDictionary *)testPrarms {
    if (_speedUpUtils) {
        DeviceInfoModel *infoModel = [DeviceInfoModel shared];
        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
        params[@"appId"] = @"zhongxin";
        params[@"duration"] = duration;
        params[@"ispId"] = infoModel.ispId;
        params[@"latitude"] = infoModel.latitude;
        params[@"longitude"] = infoModel.longitude;
        params[@"msgId"] = [Tools uuidString];
        params[@"privateIp"] = infoModel.intranetIP;
        params[@"publicIp"] = infoModel.publicIP;
        params[@"serverPort"] = port;
        params[@"testMethod"] = method;
        params[@"userId"] = @"testUserId";
        [params addEntriesFromDictionary:testPrarms];

        [_speedUpUtils tracertReport:params];
    }
}

- (void)speedUp:(NSString *_Nonnull)publicIP intranetIP:(NSString *_Nonnull)intranetIP ispId:(NSString *_Nonnull)ispId areaId:(NSString *_Nonnull)areaId res:(nullable void (^)(SpeedUpApplyTecentGamesQoSModel *qoModel))res {
    if ([ispId integerValue] <= 0) {
        SpeedUpApplyTecentGamesQoSModel *model = [[SpeedUpApplyTecentGamesQoSModel alloc] init];
        model.ResultCode = @"0";
        model.ResultMessage = @"网络运营商不支持4G加速";
        res(model);
    } else if (([ispId isEqualToString:@"1"] && [areaId isEqualToString:@"440000"]) || [ispId isEqualToString:@"2"]) {
        WeakSelf;
        // 是否需要获取Token
        if ([ispId isEqualToString:@"2"]) {
            [_speedUpUtils getToken:getTokenUrl res:^(NSString *_Nonnull token) {
                [weakSelf.speedUpUtils applyTecentGamesQoS:intranetIP publicIp:publicIP applyTecentGamesQoS:^(SpeedUpApplyTecentGamesQoSModel *_Nullable model) {
                    NSLog(@"%@", model);
                    if ([model.ResultCode integerValue] == 200) {
                        [Tools saveToUserDefaults:SP_KEY_CORRELATION_ID value:@"1"];
                    }

                    res(model);
                } token:token];
            }];
        } else {
            [_speedUpUtils getToken:getCmGuandongTokenUrl res:^(NSString *_Nonnull token) {
                [weakSelf.speedUpUtils applyTecentGamesQoS:intranetIP publicIp:publicIP applyTecentGamesQoS:^(SpeedUpApplyTecentGamesQoSModel *_Nullable model) {
                    NSLog(@"%@", model);
                    if ([model.ResultCode integerValue] == 200) {
                        [Tools saveToUserDefaults:SP_KEY_CORRELATION_ID value:@"1"];
                    }

                    res(model);
                } token:token];
            }];
        }
    } else {
        // 直接调用加速
        [_speedUpUtils applyTecentGamesQoS:intranetIP publicIp:publicIP applyTecentGamesQoS:^(SpeedUpApplyTecentGamesQoSModel *_Nullable model) {
            NSLog(@"%@", model);
            if ([model.ResultCode integerValue] == 200) {
                [Tools saveToUserDefaults:SP_KEY_CORRELATION_ID value:@"1"];
            }

            res(model);
        } token:@""];
    }
}

- (void)cancalSpeedUp:(NSString *_Nonnull)publicIP res:(nullable void (^)(SpeedUpCancelTecentGamesQoSModel *qoModel))res {
    if (_speedUpUtils) {
        // 取消加速
        [_speedUpUtils cancelTecentGamesQoS:publicIP cancelTecentGamesQoS:^(SpeedUpCancelTecentGamesQoSModel *_Nullable model) {
            NSLog(@"%@", model);
            if ([model.ResultCode integerValue] == 200) {
                [Tools saveToUserDefaults:SP_KEY_CORRELATION_ID value:@"0"];
            }
            res(model);
        }];
    }
}

@end
