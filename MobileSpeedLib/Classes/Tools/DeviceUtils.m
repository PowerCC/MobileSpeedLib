//
//  DeviceUtils.m
//  MobileSpeed
//
//  Created by 邹程 on 2020/4/22.
//  Copyright © 2020 邹程. All rights reserved.
//

#import "DeviceUtils.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
//#import <UIKit/UIKit.h>

@implementation DeviceUtils
/*获取当前设备的IMSI值*/
+ (NSString *)getDeviceIMSIValue
{
    return nil;
}

/*获取当前设备的IMEI值*/
+ (NSString *)getDeviceIMEIValue
{
    return nil;
}

/*获取当前设备的MacId值*/
+ (NSString *)getDeviceMacIdValue
{
    return nil;
}

/*获取当前设备的通讯运营商名称*/
+ (NSString *)getDeviceCarrierName
{
    CTTelephonyNetworkInfo *info = [CTTelephonyNetworkInfo new];
    CTCarrier *carrier = [info subscriberCellularProvider];
    NSString *carrierString = [carrier carrierName];
    return carrierString ? carrierString : @"";
}

/*获取当前设备的网络通讯名称值*/
+ (NSString *)getDeviceNetworkName
{
    /*
        CTRadioAccessTechnologyGPRS             //介于2G和3G之间(2.5G)
        CTRadioAccessTechnologyEdge             //GPRS到第三代移动通信的过渡(2.75G)
        CTRadioAccessTechnologyWCDMA
        CTRadioAccessTechnologyHSDPA            //亦称为3.5G(3?G)
        CTRadioAccessTechnologyHSUPA            //3G到4G的过度技术
        CTRadioAccessTechnologyCDMA1x           //3G
        CTRadioAccessTechnologyCDMAEVDORev0     //3G标准
        CTRadioAccessTechnologyCDMAEVDORevA
        CTRadioAccessTechnologyCDMAEVDORevB
        CTRadioAccessTechnologyeHRPD            //电信一种3G到4G的演进技术(3.75G)
        CTRadioAccessTechnologyLTE              //接近4G
     */
    CTTelephonyNetworkInfo *info = [CTTelephonyNetworkInfo new];
    NSString *infoString = [info currentRadioAccessTechnology];
    return infoString ? infoString : @"";
}

@end
