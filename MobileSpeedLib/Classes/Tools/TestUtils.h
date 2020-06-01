//
//  TestUtils.h
//  MobileSpeed
//
//  Created by 邹程 on 2020/4/23.
//  Copyright © 2020 邹程. All rights reserved.
//

#import "Marco.h"
#import "Tools.h"
#import "DeviceUtils.h"
#import "DeviceInfoModel.h"
#import "SpeedUpUtils.h"
#import "Traceroute.h"
#import "SpeedUpModels.h"
#import "PhoneNetSDK.h"
#import "GCDAsyncUdpSocket.h"

NS_ASSUME_NONNULL_BEGIN

typedef void (^DeviceInfoHandler)(DeviceInfoModel *_Nullable infoModel);

@interface TestUtils : NSObject

@property (strong, nonatomic) SpeedUpUtils *speedUpUtils;
@property (strong, nonatomic) PNTcpPing *tcpPing;
@property (strong, nonatomic) NSURLSessionDownloadTask *downloadTask;
@property (strong, nonatomic) GCDAsyncUdpSocket *udpSocket;
@property (strong, nonatomic) Traceroute *traceroute;

/**
 实例
 */
+ (instancetype)sharedInstance;

/**
 获取设备信息
 @param infoHandler 设备信息DeviceInfoModel
*/
- (void)getDeviceInfo:(DeviceInfoHandler)infoHandler;

/**
 ping探测
 @param host 测试网址或IP
 @param port 端口号
 @param count 测试次数
*/
- (void)ping:(NSString *_Nonnull)host port:(NSUInteger)port count:(NSUInteger)count complete:(PNTcpPingHandler _Nonnull)complete;

/**
 停止ping探测
 */
- (void)stopPing;

/**
 http探测（文件下载）
 @param fileUrl 文件地址
 @param downloadProgressBlock 下载进度
 @param completionHandler 结果Handler
*/
- (void)httpDownloadFile:(NSString *_Nonnull)fileUrl progress:(void (^)(NSProgress *downloadProgress))downloadProgressBlock completionHandler:(void (^)(NSURLResponse *response, NSURL *filePath, NSError *error))completionHandler;

/**
 停止http探测（文件下载）
 */
- (void)stopHttpDownloadFile;

/**
 udp检测
 @param host 测试网址或IP
 @param port 端口号
 @param aDelegate GCDAsyncUdpSocketDelegate 代理
*/
- (void)udpTest:(NSString *_Nonnull)host port:(uint16_t)port aDelegate:(id<GCDAsyncUdpSocketDelegate>)aDelegate;

/**
 停止udp探测（文件下载）
*/
- (void)stopUdpTest;

/**
 trace探测
 @param host 测试网址或IP
 @param port 端口号
 @param stepCallback Traceroute中每一跳的结果回调
 @param finish Traceroute结束的回调
*/
- (void)trace:(NSString *_Nonnull)host port:(NSString *)port stepCallback:(TracerouteStepCallback)stepCallback finish:(TracerouteFinishCallback)finish;

/**
 停止Trace探测
*/
- (void)stopTrace;

/**
 上报探测数据
 @param method 测试方法（PING、HTTP、UDP、TRACE）
 @param port 端口号
 @param duration 持续时间
*/
- (void)uploadTestResult:(NSString *_Nonnull)method port:(NSString *)port duration:(NSString *)duration testParams:(NSDictionary *)testPrarms;

/**
 加速
 @param publicIP 公网IP
 @param intranetIP 内网IP
 @param ispId isPId
 @param areaId 区域码
 @param res SpeedUpCancelTecentGamesQoSModel（code，message）
*/
- (void)speedUp:(NSString *_Nonnull)publicIP intranetIP:(NSString *_Nonnull)intranetIP ispId:(NSString *_Nonnull)ispId areaId:(NSString *_Nonnull)areaId res:(nullable void (^)(SpeedUpApplyTecentGamesQoSModel *qoModel))res;

/**
 取消加速
 @param publicIP 公网IP
 @param res SpeedUpCancelTecentGamesQoSModel（code，message）
*/
- (void)cancalSpeedUp:(NSString *_Nonnull)publicIP res:(nullable void (^)(SpeedUpCancelTecentGamesQoSModel *qoModel))res;

@end
NS_ASSUME_NONNULL_END
