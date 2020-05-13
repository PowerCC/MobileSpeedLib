//
//  Tools.h
//  MobileSpeed
//
//  Created by 邹程 on 2020/4/26.
//  Copyright © 2020 邹程. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>
#import "Marco.h"

NS_ASSUME_NONNULL_BEGIN

@interface Tools : NSObject
+ (NSString *)uuidString;

+ (void)showPrompt:(NSString *)text superView:(UIView *)superView numberOfLines:(NSInteger)numberOfLines afterDelay:(NSTimeInterval)afterDelay completion:(nullable MBProgressHUDCompletionBlock)completion;

+ (NSDictionary *)convert2DictionaryWithJSONString:(NSString *)jsonString;

+ (NSString *)dictionaryToJson:(NSDictionary *)dic;

+ (void)saveToUserDefaults:(NSString *)key value:(id)value;

+ (NSString *)loadStringFromUserDefaults:(NSString *)key;

+ (id)loadObjectFromUserDefaults:(NSString *)key;

+ (NSString *)intervalSinceNow:(NSDate *)theDate;
@end

NS_ASSUME_NONNULL_END
