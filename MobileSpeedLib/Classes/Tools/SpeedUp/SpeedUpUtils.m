//
//  SpeedUpUtils.m
//  MobileSpeed
//
//  Created by 邹程 on 2020/4/26.
//  Copyright © 2020 邹程. All rights reserved.
//

#import "SpeedUpUtils.h"
#import "Marco.h"
#import <AFNetworking/AFNetworking.h>
#import "Tools.h"

@implementation SpeedUpUtils

- (void)request:(NSString *)urlString method:(NSString *)method parameters:(nullable id)parameters completionHandler:(nullable void (^)(NSURLResponse *response, id _Nullable responseObject, NSError *_Nullable error))completionHandler {
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];

    if ([method isEqualToString:@"GET"]) {
        AFHTTPResponseSerializer *responseSerializer = (AFHTTPResponseSerializer *)manager.responseSerializer;
        responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    }

    NSURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:method URLString:urlString parameters:parameters error:nil];
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request uploadProgress:nil downloadProgress:nil completionHandler:completionHandler];
    [dataTask resume];
}

- (NSURLSessionDownloadTask *)downloadFile:(NSString *)fileUrl progress:(void (^)(NSProgress *downloadProgress))downloadProgressBlock completionHandler:(void (^)(NSURLResponse *response, NSURL *filePath, NSError *error))completionHandler {
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];

    NSURL *URL = [NSURL URLWithString:fileUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];

    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:downloadProgressBlock destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
    } completionHandler:completionHandler];
    [downloadTask resume];
    return downloadTask;
}

- (void)getToken:(NSString *)urlString res:(nullable void (^)(NSString *token))res {
    [self request:urlString method:@"GET" parameters:nil completionHandler:^(NSURLResponse *response, id _Nullable responseObject, NSError *_Nullable error) {
        if (error) {
            NSLog(@"Error: %@", error);
            res(nil);
        } else {
            NSLog(@"%@ %@", response, responseObject);
            res([NSString stringWithFormat:@"%@", responseObject]);
        }
    }];
}

- (void)getAreaInfo:(AreaInfo)areaInfo {
    [self request:getAreaInfoUrl method:@"POST" parameters:nil completionHandler:^(NSURLResponse *response, id _Nullable responseObject, NSError *_Nullable error) {
        if (error) {
            NSLog(@"Error: %@", error);
            areaInfo(nil);
        } else {
            NSLog(@"%@ %@", response, responseObject);
            SpeedUpAreaInfoModel *model = [[SpeedUpAreaInfoModel alloc] initWithDictionary:responseObject error:nil];
            areaInfo(model);
        }
    }];
}

- (void)applyTecentGamesQoS:(NSString *)ip publicIp:(NSString *)publicIp applyTecentGamesQoS:(ApplyTecentGamesQoS)applyTecentGamesQoS token:(NSString *)token {
    NSDictionary *ipDic1 = @{ @"DestinationIpAddress": @"223.111.237.4",
                              @"Direction": @"2",
                              @"MaximumDownStreamSpeedRate": @"50000",
                              @"MaximumUpStreamSpeedRate": @"100000",
                              @"Protocol": @"ip",
                              @"SourceIpAddress": ip };

    NSDictionary *ipDic2 = @{ @"DestinationIpAddress": @"120.204.3.140",
                              @"Direction": @"2",
                              @"MaximumDownStreamSpeedRate": @"50000",
                              @"MaximumUpStreamSpeedRate": @"100000",
                              @"Protocol": @"ip",
                              @"SourceIpAddress": ip };

    NSDictionary *resourceFeaturePropertiesDic = @{ @"FlowProperties": @[ipDic1, ipDic2],
                                                    @"MinimumDownStreamSpeedRate": @"100000",
                                                    @"MinimumUpStreamSpeedRate": @"50000",
                                                    @"Priority": @"1",
                                                    @"Type": @"2" };

    NSDictionary *userIdentifierDic = @{ @"IP": ip,
                                         @"PublicIP": publicIp };

    NSDictionary *paramsDic = @{ @"Duration": @"3600",
                                 @"OTTchargingId": @"a1234567890",
                                 @"Partner_ID": @"demoapp",
                                 @"ResourceFeatureProperties": resourceFeaturePropertiesDic,
                                 @"ServiceId": @"Games100K",
                                 @"UserIdentifier": userIdentifierDic,
                                 @"security_token": token };
    NSLog(@"请求参数：%@", paramsDic);
    [self request:applyUrl method:@"POST" parameters:paramsDic completionHandler:^(NSURLResponse *response, id _Nullable responseObject, NSError *_Nullable error) {
        if (error) {
            NSLog(@"Error: %@", error);
            applyTecentGamesQoS(nil);
        } else {
            NSLog(@"%@ %@", response, responseObject);
            SpeedUpApplyTecentGamesQoSModel *model = [[SpeedUpApplyTecentGamesQoSModel alloc] initWithDictionary:responseObject error:nil];
            applyTecentGamesQoS(model);
        }
    }];
}

- (void)cancelTecentGamesQoS:(NSString *)publicIp cancelTecentGamesQoS:(CancelTecentGamesQoS)cancelTecentGamesQoS {
    NSDictionary *paramsDic = @{ @"correlationId": SP_KEY_CORRELATION_ID, @"Partner_ID": @"demoapp", @"PublicIP": publicIp };
    [self request:cancelUrl method:@"GET" parameters:paramsDic completionHandler:^(NSURLResponse *response, id _Nullable responseObject, NSError *_Nullable error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            NSLog(@"%@ %@", response, responseObject);
            SpeedUpCancelTecentGamesQoSModel *model = [[SpeedUpCancelTecentGamesQoSModel alloc] initWithDictionary:responseObject error:nil];
            cancelTecentGamesQoS(model);
        }
    }];
}

- (void)tracertReport:(NSDictionary *)paramsDic {
    if (paramsDic && paramsDic.count > 0) {
        [self request:tracertReportUrl method:@"POST" parameters:paramsDic completionHandler:^(NSURLResponse *_Nonnull response, id _Nullable responseObject, NSError *_Nullable error) {
            NSLog(@"%@ %@", response, responseObject);
            if (error) {
                NSLog(@"Error: %@", error);
            } else {
            }
        }];
    }
}

@end
