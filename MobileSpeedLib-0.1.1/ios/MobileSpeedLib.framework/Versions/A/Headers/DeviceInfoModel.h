//
//  DeviceInfoModel.h
//  MobileSpeed
//
//  Created by 邹程 on 2020/5/8.
//  Copyright © 2020 邹程. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DeviceInfoModel : NSObject

/**
 OS版本
 */
@property (copy, nonatomic) NSString *osVer;

/**
 手机型号
*/
@property (copy, nonatomic) NSString *phoneModel;

/**
 移动网络类型
*/
@property (copy, nonatomic) NSString *mobileNetworkStandard;

/**
 UUID
*/
@property (copy, nonatomic) NSString *uuid;

/**
 公网IP
*/
@property (copy, nonatomic) NSString *publicIP;

/**
 内网IP
*/
@property (copy, nonatomic) NSString *intranetIP;

/**
 城市编码
*/
@property (copy, nonatomic) NSString *cityCode;

/**
 经度
*/
@property (copy, nonatomic) NSString *latitude;

/**
 纬度
*/
@property (copy, nonatomic) NSString *longitude;

/**
 位置
*/
@property (copy, nonatomic) NSString *location;

/**
 ispId
*/
@property (copy, nonatomic) NSString *ispId;

+ (instancetype)shared;

@end

NS_ASSUME_NONNULL_END
