//
//  SpeedUpModels.h
//  MobileSpeed
//
//  Created by 邹程 on 2020/4/26.
//  Copyright © 2020 邹程. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>
#import "Marco.h"

NS_ASSUME_NONNULL_BEGIN

@interface SpeedUpAreaInfoModel : JSONModel
@property (copy, nonatomic) NSString *areaId;
@property (copy, nonatomic) NSString *code;
@property (copy, nonatomic) NSString *ip;
@property (copy, nonatomic) NSString *ispId;
@property (copy, nonatomic) NSString *regionName;
@end

@interface SpeedUpApplyTecentGamesQoSModel : JSONModel
@property (copy, nonatomic) NSString *ResultCode;
@property (copy, nonatomic) NSString *ResultMessage;
@end

@interface SpeedUpCancelTecentGamesQoSModel : JSONModel
@property (copy, nonatomic) NSString *ResultCode;
@property (copy, nonatomic) NSString *ResultMessage;
@end

NS_ASSUME_NONNULL_END
