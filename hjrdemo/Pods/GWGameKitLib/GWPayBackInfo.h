//
//  GWPayBackInfo.h
//  GameKit
//
//  Created by zhangzhongming on 14/12/18.
//  Copyright (c) 2014年 游戏工场. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSInteger
{
    PAY_SUCCEED,        //成功
    PAY_FAILED,         //失败
    PAY_CANCLE,         //取消
    
    PAY_PROCESSING,     //正在处理
    PAY_NET_EXCEPTION   //网络异常
    
}PayStatus;

@interface GWPayBackInfo : NSObject

@property (nonatomic,assign) PayStatus status;
@property (nonatomic,copy)   NSString  *orderId;

@end
