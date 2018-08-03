//
//  GameKitConfigure.h
//  GameKit
//
//  Created by zhangzhongming on 14/11/25.
//  Copyright (c) 2014年 游戏工场. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum : NSInteger
{
    PLACE_TOP_LEFT,     //上左
    PLACE_TOP_MIDDLE,   //上中
    PLACE_TOP_RIGHT,    //上右
    
    PLACE_MIDDLE_LEFT,  //中左
    PLACE_MIDDLE_RIGHT, //中右
    
    PLACE_BOTTOM_LEFT,  //底左
    PLACE_BOTTOM_MIDDLE,//底中
    PLACE_BOTTOM_RIGHT  //底右
    
}FloatWindowOrBarPlace;


/***  根据项目配置文件读取xml配置*/
@interface GameKitConfigure : NSObject<NSCoding,NSCopying>

@property (nonatomic,copy)    NSString                *sessionId;

//配置相关
@property (nonatomic,copy)    NSString                *PTGameKey;       //整合平台key
@property (nonatomic,copy)    NSString                *PTGameChannel;   //整合平台渠道号

@property (nonatomic,copy)    NSString                *CPName;          //渠道名称
@property (nonatomic,copy)    NSString                *CPVersion;       //渠道版本号
@property (nonatomic,copy)    NSString                *CPAppID;         //渠道分配appid
@property (nonatomic,copy)    NSString                *CPAppKey;        //渠道分配appKey
@property (nonatomic,copy)    NSString                *CPGameKey;       //渠道key
@property (nonatomic,copy)    NSString                *CPGameChannel;   //渠道渠道号
@property (nonatomic,copy)    NSString                *CPPrivateKey;    //给平台预留的私有key
@property (nonatomic,copy)    NSString                *CPServerNo;      //渠道分配的分区编号
@property (nonatomic,assign)  BOOL                    CPAutoLogin;      //是否开启自动登录
@property (nonatomic,assign)  BOOL                    CPForceUpdate;    //是否强制更新
@property (nonatomic,assign)  BOOL                    CPForceLogin;     //是否强制登录

//显示相关
@property (nonatomic,assign)  BOOL                    DEV_ISDebugModel;                 //是否为调试模式
@property (nonatomic,assign)  BOOL                    DEV_ShowFloatWindowOrBar;         //是否显示浮动框或者操作条
@property (nonatomic,assign)  FloatWindowOrBarPlace   DEV_FloatWindowOrBarScreenPlace;  //悬浮框停靠的未知
@property (nonatomic,copy)    NSString                *DEV_SupportScreenOrientation;    //支持的屏幕方向

//支付相关
@property (nonatomic,copy)    NSString                *PAY_DefaultPayAmount;            //设置充值页面初始化金额
@property (nonatomic,copy)    NSString                *PAY_ShopingPrivateInfo;          //商户私有信息
@property (nonatomic,copy)    NSString                *PAY_PayNotifyUrl;                //支付回调地址
@property (nonatomic,copy)    NSString                *PAY_AlipayScheme;                //app 之间通信  支付宝
@property (nonatomic,copy)    NSString                *PAY_MerchantId;                  //商户ID;
@property (nonatomic,copy)    NSString                *PAY_AppScheme;                   //应用Scheme

@property (nonatomic,copy)    NSDictionary            *DATA_Product;                    //商品信息（name:id/name:id）

- (NSString *)descGameKitConfigure;

@end
