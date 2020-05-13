//
//  NSString+Extension.m
//  MobileSpeed
//
//  Created by 邹程 on 2020/5/3.
//  Copyright © 2020 邹程. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

- (BOOL)match:(NSString *)pattern {
    // 1.创建正则表达式
    NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:pattern options:0 error:nil];
    // 2.测试字符串
    NSArray *results = [regex matchesInString:self options:0 range:NSMakeRange(0, self.length)];

    return results.count > 0;
}

@end
