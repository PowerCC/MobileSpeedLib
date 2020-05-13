//
//  DeviceUtils.h
//  MobileSpeed
//
//  Created by 邹程 on 2020/4/22.
//  Copyright © 2020 邹程. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DeviceUtils : NSObject
/**
 *  获取当前设备的IMSI值
 */
+ (NSString *)getDeviceIMSIValue;

/**
 *  获取当前设备的IMEI值
 */
+ (NSString *)getDeviceIMEIValue;

/**
 *  获取当前设备的MacId值
 */
+ (NSString *)getDeviceMacIdValue;

/**
 *  获取当前设备的通讯运营商名称
 */
+ (NSString *)getDeviceCarrierName;

/**
 *  获取当前设备的网络通讯名称值
 */
+ (NSString *)getDeviceNetworkName;
@end

NS_ASSUME_NONNULL_END
