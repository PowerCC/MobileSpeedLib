//
//  Marco.h
//  MobileSpeed
//
//  Created by 邹程 on 2020/4/26.
//  Copyright © 2020 邹程. All rights reserved.
//

#ifndef Marco_h
#define Marco_h

#define WeakSelf __weak typeof(self) weakSelf = self;

#define tracertReportUrl @"http://npm.kgogogo.com/tracertReport"

#define getTokenUrl @"http://qos.189.cn/qos-api/getToken?appid=bcmTest"

#define getCmGuandongTokenUrl @"http://120.196.166.156/bdproxy/?appid=shengyuan"

#define getAreaInfoUrl @"https://4gqos.h2comm.com.cn/areaInfo"

#define applyUrl @"http://4gqos.h2comm.com.cn:8090/ivsp/services/AACAPIV1/applyTecentGamesQoS"

#define cancelUrl  @"http://4gqos.h2comm.com.cn:8090/ivsp/services/AACAPIV1/getRemoveTecentGamesQoS?correlationId="

#define netSpeed @"http://120.52.72.43:8081/test.mp4"

#define defaultIp @"120.52.72.43"

#define defaultPort @"80"

/// 加速状态
#define SP_KEY_CORRELATION_ID @"SP_KEY_CORRELATION_ID"

#endif /* Marco_h */
