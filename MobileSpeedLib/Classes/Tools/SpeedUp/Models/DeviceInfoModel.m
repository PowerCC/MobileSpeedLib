//
//  DeviceInfoModel.m
//  MobileSpeed
//
//  Created by 邹程 on 2020/5/8.
//  Copyright © 2020 邹程. All rights reserved.
//

#import "DeviceInfoModel.h"

@implementation DeviceInfoModel

static DeviceInfoModel *model = nil;
+ (instancetype)shared {
    if (model == nil) {
        model = [[DeviceInfoModel alloc]init];
    }
    return model;
}

@end
