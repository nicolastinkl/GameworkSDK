//
//  GameKitSDK.m
//  GameKit
//
//  Created by zhangzhongming on 14/11/25.
//  Copyright (c) 2014年 游戏工场. All rights reserved.
//

#import "GameKitSDK.h"
#import <GWDefine.h>
#import <GWprovider.h>
#import <GWCommonUtility.h>
#import <Private.h>

#import <GameWorksPluginSDK/GWGameWorks.h>
#import <GameWorksPluginSDK/GWUser.h>
#import <GameWorksPluginSDK/GWSDKPayPluginOrder.h>

@interface GameKitSDK ()

@property(nonatomic,weak)   id<GameKitObserverProtocol> observer;           //回调信息接受
@property(nonatomic,assign) BOOL                        userIsLogined;          //是否已经登录
@property(nonatomic,assign) bool                        initSucess;         //初始化是否成功
@property(nonatomic,copy)   NSString                    *temp_orderNo;
@property(nonatomic,copy)   NSString                    *zoneID;            //区服号
@property(nonatomic,retain) GWUserInfo                  *loginedUserInfo;   //已经登录用户的信息

@end

@implementation GameKitSDK


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.initSucess = YES;
        /* TODO: 读取配置文件  读取xml 配置*/
        if(!self.gameKitConfigure || !self.parserSucessed)
            self.initSucess = NO;
    }
    return self;
}

#pragma mark - 获取单例对象
+ (GameKitSDK *)defaultSdk
{
    static GameKitSDK *sdk;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sdk = [[GameKitSDK alloc] init];
    });
    return sdk;
}

- (id)jsonStringToObject:(NSString *)jsonStr
{
    NSData *data = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    id object = [NSJSONSerialization JSONObjectWithData:data
                                                options:NSJSONReadingAllowFragments
                                                  error:&error];
    return object;
}

- (void)loginDidFinish:(NSNotification *)notification
{
    NSDictionary * notifyDic = notification.object;
    BOOL loginstatus =  [notifyDic[@"loginstatus"] boolValue];
    if (loginstatus) {
        
        NSString * usertype = notifyDic[@"msg"];
        GWUser * currentUser = [GWUser currentUser];
        self.userIsLogined = YES;
        GWUserInfo *obj = [GWUserInfo new];
        obj.userID = currentUser.userId;
        obj.userName = currentUser.username;
        obj.loginUserType = [usertype isEqualToString:@"normalUser"]?RIGISTER_USER:GUEST_USER;
        obj.cpToken = currentUser.sessionToken;
        obj.nickName = currentUser.nickname;
        obj.CPName = self.gameKitConfigure.CPName;
        obj.uuid = [NSString achieveUUIDWithArchives:YES];
        obj.userLoginToken = currentUser.sessionToken;
        self.loginedUserInfo = obj;
        
        [self.observer loginCompletedWithLoginStatus:LOGIN_SUCCEED responseObj:obj error:nil];
        
    }else{
        if (self.observer && [self.observer respondsToSelector:@selector(loginCompletedWithLoginStatus:responseObj:error:)]) {
            NSString * usertype = notifyDic[@"msg"];
            GWError *error = [GWError new];
            error.errorDesc = usertype;
            error.errorCode = REQUEST_ERROR;
            [self.observer loginCompletedWithLoginStatus:LOGIN_FAILED responseObj:nil error:error];
        }
    }
    
    
}



- (void)loginout:(NSNotification *)notification
{
    if (self.observer && [self.observer respondsToSelector:@selector(LoginOutCompletedISSucceedStatus:error:)]) {
        [self.observer LoginOutCompletedISSucceedStatus:YES error:nil];
    }
}


-(void)payResult:(NSNotification *)notification
{
    NSDictionary *dict = notification.object;
    NSString *orderId = [dict objectForKey:@"oid"];
    if ([[dict objectForKey:@"code"] isEqualToString:@"0"]) {
        if(self.observer && [self.observer respondsToSelector:@selector(payCompletedWithPayStatus:responseObj:error:)])
        {
            GWPayBackInfo * obj = [[GWPayBackInfo alloc] init];
            obj.orderId = orderId;
            obj.status = PAY_SUCCEED;
            [self.observer payCompletedWithPayStatus:PAY_SUCCEED responseObj:obj error:nil];
        }
    }else if([[dict objectForKey:@"code"] isEqualToString:@"1"])
    {
        if(self.observer && [self.observer respondsToSelector:@selector(payCompletedWithPayStatus:responseObj:error:)])
        {
            GWPayBackInfo * obj = [[GWPayBackInfo alloc] init];
            obj.orderId = orderId;
            obj.status = PAY_PROCESSING;
            GWError *error = [[GWError alloc] init];
            error.errorDesc = @"交易处理中";
            error.errorCode = UNKONW_ERROR;
            [self.observer payCompletedWithPayStatus:PAY_FAILED responseObj:obj error:error];
        }
    }else if([[dict objectForKey:@"code"] isEqualToString:@"2"])
    {
        if(self.observer && [self.observer respondsToSelector:@selector(payCompletedWithPayStatus:responseObj:error:)])
        {
            GWPayBackInfo * obj = [[GWPayBackInfo alloc] init];
            obj.orderId = orderId;
            obj.status = PAY_CANCLE;
            GWError *error = [[GWError alloc] init];
            error.errorDesc = @"支付被取消";
            error.errorCode = UNKONW_ERROR;
            [self.observer payCompletedWithPayStatus:PAY_FAILED responseObj:obj error:error];
        }
    }
    else
    {
        if(self.observer && [self.observer respondsToSelector:@selector(payCompletedWithPayStatus:responseObj:error:)])
        {
            GWPayBackInfo * obj = [[GWPayBackInfo alloc] init];
            obj.orderId = orderId;
            obj.status = PAY_FAILED;
            GWError *error = [[GWError alloc] init];
            error.errorDesc = @"交易失败";
            error.errorCode = UNKONW_ERROR;
            [self.observer payCompletedWithPayStatus:PAY_FAILED responseObj:obj error:error];
        }
        
    }
}



#pragma mark - 初始化======================TODO=============================
#pragma mark - 注册统一回调函数
- (void)initWithObserver:(id<GameKitObserverProtocol>) observer params:(GameKitInitParam *)params
{
    if (observer) {
        self.observer = observer;
    }
    if (params && params.zoneID) {
        self.zoneID = params.zoneID;
    }
    
    if (self.initSucess)
    {
        
        __weak GameKitSDK *_self = self;
        [[GWprovider defaultProvider] touristLoginWithBlock:^(GWTouristUserInfo *touristUserInfo) {
            __strong GameKitSDK *self_ = _self;
            if (self_) {
                if (touristUserInfo && touristUserInfo.session && ![touristUserInfo.session isEqualToString:@""])
                {
                    self_.gameKitConfigure.sessionId = touristUserInfo.session;
                    
                    /*
                    GWInitInfoObj *initInfoObj = [[GWInitInfoObj alloc] init];
                    initInfoObj.gwKey = self_.gameKitConfigure.PTGameKey;
                    initInfoObj.gwChannel = self_.gameKitConfigure.PTGameChannel;
                    
                    if(self_.gameKitConfigure.DEV_ISDebugModel)
                    {
                        initInfoObj.gwServerUrl = @"http://anyapi.mobile.youxigongchang.com";
                        initInfoObj.sdkServerUrl = @"http://test.api.mobile.youxigongchang.com";
                    }else
                    {
                        initInfoObj.gwServerUrl = @"http://anyapi.mobile.youxigongchang.com";
                        initInfoObj.sdkServerUrl = @"http://api.mobile.youxigongchang.com";
                    }
                    
                    initInfoObj.sdkAppId = self_.gameKitConfigure.CPAppKey;
                    initInfoObj.sdkAppKey = self_.gameKitConfigure.CPAppID;
                    initInfoObj.orientation = UIDeviceOrientationPortrait;
                    initInfoObj.checkVersion = NO;
                    initInfoObj.hasServerList = NO;
                    
                    [[GameWorksSDK defaultGameWorks] gwInitConfigureWithAppid:initInfoObj];
                    [[GameWorksSDK defaultGameWorks] gwSetDebugMode:self_.gameKitConfigure.DEV_ISDebugModel];
                    */
                    
                    
                    
                    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginDidFinish:) name:kGWSDKLoginResultNotification object:nil];
                    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(payResult:) name:kGWSDKPaymentResultNotification object:nil];
                    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginout:) name:kGWSDKLogoutResultNotification object:nil];
                    
                    
                    [self_ initCallBackWithStatus:YES];
                }
            }
        } failBlock:^(NSString *errorMsg) {
            __strong GameKitSDK *self_ = _self;
            if (self_) {
               [self_ initCallBackWithStatus:NO];
            }
        }];
    }else
    {
        [self initCallBackWithStatus:NO];
    }
}


-(void) initCallBackWithStatus:(BOOL) isSucceed
{
    if (self.observer && [self.observer respondsToSelector:@selector(gameKitInitCompletedISSucceedStatus:error:)]) {
        if (isSucceed) {
           [self.observer gameKitInitCompletedISSucceedStatus:isSucceed error:nil];
           
            dispatch_async(dispatch_get_main_queue(), ^
                           {
                               [GWGameWorks setProductionMode:YES];
                               
                               [GWGameWorks setApplicationGameKey:self.gameKitConfigure.PTGameKey
                                                        ChannelID:self.gameKitConfigure.PTGameChannel
                                                       RotateMode:GWRotateModeLandscapeAuto];
                               
                               [GWGameWorks setApplicationGameBundle:GWSDKBundleForgame];
                               
                               
                           });

            
        }else
        {
            GWError *error = [[GWError alloc] init];
            error.errorCode = SDK_INIT_ERROR;
            error.errorDesc = @"平台初始化失败";
            [self.observer gameKitInitCompletedISSucceedStatus:isSucceed error:error];
        }
    }
}

#pragma mark -  常规接口
#pragma mark -  登录操作======================TODO=============================
- (void)nomalLogin
{
    if(!self.isLogined){
        //[[GameWorksSDK defaultGameWorks] gwLogin:0];
        [GWGameWorks showGWSDKUserLoginCenterViewController];
    }
}

/*!
 *  游客登录
 */
- (void)guestLogin
{
    [GWGameWorks showGWSDKtempUserLoginCenterViewController];
}

/*!
 *  游客转正式用户
 */
- (void)guestRegist
{
    if(self.isLogined){
        //[[GameWorksSDK defaultGameWorks] gwLogin:0];
        [GWGameWorks showGWSDKUserCenterViewController];
    }
   
}

- (bool)isLogined
{
    return self.userIsLogined;
}

- (GWUserInfo *)loginUserInfo
{
    return self.loginedUserInfo;
}

#pragma mark -  检查更新======================TODO=============================
- (void)checkUpdate
{
}

#pragma mark -  支付======================TODO=============================
- (void)pay:(GWPayOrder *)order
{
        if (order && self.gameKitConfigure) {
            if (self.userIsLogined) {
                
                /*
                 * 关于区服号码:
                 * @1:官方sdk  不需要发布分配的区服号码
                 * @2:其他渠道  针对整合平台需要传递游戏的区服号码   正对渠道而言  需要发布分配的区服号
                 */
                
                //TODO: Step 1: 整合平台获取订单信息  Step 2: 提交订单信息
                order.notifyUrl= order.notifyUrl?order.notifyUrl:self.gameKitConfigure.PAY_PayNotifyUrl;
                //NSString *productid = [self.gameKitConfigure.DATA_Product objectForKey:order.productName];
                
                NSString *sendServerid = @"";
                if (self.zoneID && ![self.zoneID isEqualToString:@""]) {
                    sendServerid = self.zoneID;
                }
                if (order.zoneId && ![order.zoneId isEqualToString:@""]) {
                    sendServerid = order.zoneId;
                }
                
                //TODO:官方sdk 的区服号与 其他渠道的处理有些不一样,不需要发现分配的区服号码
                GWSDKPayPluginOrder * payorder = [[GWSDKPayPluginOrder alloc] init];
                payorder.amount = order.amount;
                payorder.productId = order.productId;
                payorder.productName = order.productName;
                payorder.productCount = order.productCount;
                payorder.payDescription = order.payDescription;
                payorder.roleId = order.roleId;
                payorder.zoneId = order.zoneId;
                payorder.gameextend = order.gameextend;
                payorder.productDisplayTitle = order.productDisplayTitle;
                
                if ([GWUser isAuthenticated]) {
                    [GWGameWorks showGWSDKPaymentViewController:payorder];
                }else{
                    NSLog(@"您还未登录");
                }
            }else
            {
                if (self.observer && [self.observer respondsToSelector:@selector(payCompletedWithPayStatus:responseObj:error:)]) {
                    GWError *error = [[GWError alloc] init];
                    error.errorDesc = @"用户未登录";
                    error.errorCode = USER_UNLOGIN;
                    [self.observer payCompletedWithPayStatus:PAY_FAILED responseObj:nil error:error];
                }
            }
        }else
        {
        if (self.observer && [self.observer respondsToSelector:@selector(payCompletedWithPayStatus:responseObj:error:)]) {
            GWError *error = [[GWError alloc] init];
            error.errorDesc = @"平台未初始化";
            error.errorCode = SDK_INIT_ERROR;
            [self.observer payCompletedWithPayStatus:PAY_FAILED responseObj:nil error:error];
        }
    }
}



#pragma mark -  订单查询======================TODO=============================
- (void)checkOrder:(NSString *)orderId
{
    __weak GameKitSDK *self_ = self;
    if (self.userIsLogined) {
        [[GWprovider defaultProvider] checkOrderState:orderId sucessBlock:^(GWPayResult *result) {
            __strong GameKitSDK *_self = self_;
            if (_self) {
                
                if (_self.observer && [_self.observer respondsToSelector:@selector(checkOrderCompletedWithData:error:)]) {
                    
                    GWCheckOrderInfo *obj = [[GWCheckOrderInfo alloc] init];
                    obj.status = (result.status == _Sucess_OrderStatus)?TRADE_SUCCEED:TRADE_FAILED;
                    obj.statusDesc = result.desc?result.desc:nil;
                    [_self.observer checkOrderCompletedWithData:obj error:nil];
                }
            }
            
        } failBlock:^(NSString *errorMsg){
            __strong GameKitSDK *_self = self_;
            if (_self) {
                if (_self.observer && [_self.observer respondsToSelector:@selector(checkOrderCompletedWithData:error:)]) {
                    GWError *error = [[GWError alloc] init];
                    error.errorDesc = @"订单查询失败";
                    error.errorCode = REQUEST_ERROR;
                    
                    [_self.observer checkOrderCompletedWithData:nil error:error];
                }
            }
        }];
    }else
    {
        if (self.observer && [self.observer respondsToSelector:@selector(checkOrderCompletedWithData:error:)]) {
            GWError *error = [[GWError alloc] init];
            error.errorDesc = @"未登录";
            error.errorCode = USER_UNLOGIN;
            [self.observer checkOrderCompletedWithData:nil error:error];
        }
    }
}

#pragma mark -  注销登录======================TODO=============================
- (void)loginOut
{
    self.userIsLogined = NO;
    
    [GWUser logOutInBackgroundblock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSLog(@"注销成功");
        }else{
            NSLog(@"注销失败");
        }
    }];
    
    //[[GameWorksSDK defaultGameWorks] gwLogout:0];
}

#pragma mark -  用户中心======================TODO=============================
- (void)userCenter
{
    if (self.userIsLogined) {
         //[[GameWorksSDK defaultGameWorks] gwEnterAccountManage];
        [GWGameWorks showGWSDKUserCenterViewController];
    }else
    {
        NSLog(@"用户未登录");
    }
 
    
}



#pragma mark -  切换用户======================TODO=============================
- (void)swapAccount
{
     self.userIsLogined = NO;
    //[self loginOut];
    [GWGameWorks showGWSDKUserLoginCenterViewController];
    
}

#pragma mark -  是否显示浮动窗口或者操作栏======================TODO=============================
- (void)showFloatWindowOrBar:(BOOL) isShow
{
    [GWGameWorks showBanner:isShow];
}

#pragma mark -  统计

//用户登录统计
- (void)statisticsUserLogin:(NSDictionary *)info
{

}

// 支付统计
- (void)statisticsPay:(NSDictionary *)order
{

}
// 玩家设计统计
- (void)statisticsUserUpGrade:(NSDictionary *)info
{

}
// 玩家创建角色统计
- (void)statisticsCreateRole:(NSDictionary *)info
{

}
// 按钮点击统计（非必须接入）
- (void)statisticsBtnClickEvent:(NSDictionary *)info
{

}

#pragma mark -  游戏状态
//继续游戏
- (void)gameContinueEvent
{

}
//暂停游戏
- (void)gameSuspendEvent
{
    
}

// 停止游戏
- (void)gameStopEvent
{

}
// open url 跳转回调
- (void)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
//    [[NSNotificationCenter defaultCenter] postNotificationName:kDJPlatfromAlixQuickPayEnd object:url];
}


@end
