//
//  GWGameworks.m
//  GameworksSDK
//
//  Created by tinkl on 7/1/15.
//  Copyright (c) 2015年 ___GAMEWORK___. All rights reserved.
//

#import "GWGameWorks.h"
#import "GWObject.h"
#import "JSONModel+networking.h"
#import "GWNetEngine.h"
#import "GWUtility.h"
#import "GWSDKBannerMenuView.h"
#import "GWSDKNavigationController.h"
#import "GWSDKLoginViewController.h"
#import "GWMacro.h"
#import "GWSDKQuarkViewController.h"
#import "GWUICKeyChainStore.h"
#import "GWSDKUserCenterViewController.h"
#import "GWSDKPaymentViewController.h"
#import "GWSDKPayMentModel.h"
#import "GWSDKPayMent.h"
#import "GWSDKPayHistoryViewController.h"
#import "GWUser.h"
#import "GWSDKPayPluginOrder.h"


@interface GWGameWorks ()

@end

/*!
 *  GAMEWORKS 主函数逻辑
 */
@implementation GWGameWorks

+ (void)setApplicationGameKey:(NSString *)gameKey ChannelID:(NSString *)channelid RotateMode:(GWRotateMode)gwrotate
{
    //设置异常信息处理
    NSSetUncaughtExceptionHandler (&UncaughtExceptionHandler);
    
    [GWObject sharedGWObject].GWGAMEKEY     = gameKey;
    [GWObject sharedGWObject].GWCHANNELID   = channelid;
    [GWObject sharedGWObject].GWROTATEMODE  = gwrotate;

    //设置keychain
    [GWUICKeyChainStore setDefaultService:GW_KEYCHAIN_SERVER];
    
    //游戏启动
    [GWGameWorks startGameWorks];
    
    //第三方登录接口处理 social/third
    [GWGameWorks startRequsetThridLoginSupport];
    
    //获取服务器配置信息
    [GWGameWorks startRequsetGameSettings];
    
    //设置悬浮气泡菜单按钮
    [GWGameWorks setupWindowsPopMenu];
    
}

+ (void)setApplicationGameBundle:(GWSDKBundle )bundletype
{
    [GWObject sharedGWObject].GWSDKBundleTYPE = bundletype;
}


#pragma mark- 处理通知

+(void)gwapplicationDidEnterBackground:(NSNotification*)notification
{
    [self EnterBackground];
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    
}

+(void)gwapplicationDidBecomeActive:(NSNotification*)notification
{
    [self BecomeActive];
}

#pragma mark - 统计每次用户在线游戏时长
+(void)BecomeActive
{
    NSMutableString* starttime=[[NSMutableString alloc]initWithCapacity:0];
    [starttime appendString:@"s"];
    [starttime appendString:[GWUtility timestampFromIntDate:[NSDate date]]];
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"timearray"]) {
        NSData* dataarray=[[NSUserDefaults standardUserDefaults] objectForKey:@"timearray"];
        NSMutableArray* array=[NSKeyedUnarchiver unarchiveObjectWithData:dataarray];
        NSMutableString* timstamps=[[NSMutableString alloc]initWithCapacity:0];
        for (NSMutableString* timestr in array) {
            if ([timstamps length]<=0&&[timestr length]>1) {
                NSString* temp=[timestr substringFromIndex:1];
                [timstamps appendString:temp];
            }else{
                if ([[timestr substringToIndex:1] isEqualToString:@"s"])
                {
                    NSString* temp=[timestr substringFromIndex:1];
                    [timstamps appendString:[NSString stringWithFormat:@",%@",temp]];
                }
                else if([[timestr substringToIndex:1] isEqualToString:@"e"])
                {
                    NSString* temp=[timestr substringFromIndex:1];
                    [timstamps appendString:[NSString stringWithFormat:@"|%@",temp]];
                }
            }
        }
        
        //ipstr timstamps
        ///sys/gamedeactivate
        [[GWNetEngine sharedGWNetEngine] postRequestWithParameters:[NSMutableDictionary dictionaryWithDictionary:@{@"cood": [GWUtility stringSafeOperation:[GWObject sharedGWObject].GWSERVERIP],@"timestamp":timstamps}] Action:@"sys/gamedeactivate" success:^(id object, NSError *error) {
        } error:^(NSInteger number, NSError *error) {
        }];
        
    }else {
        
        NSMutableArray* array=[[NSMutableArray alloc]initWithCapacity:0];
        [array addObject:starttime];
        
        NSData* data=[NSKeyedArchiver archivedDataWithRootObject:array];
        NSUserDefaults* defaults=[NSUserDefaults standardUserDefaults];
        [defaults setObject:data forKey:@"timearray"];
        [defaults synchronize];
    }
    
    //ipstr
    [[GWNetEngine sharedGWNetEngine] postRequestWithParameters:[NSMutableDictionary dictionaryWithDictionary:@{@"cood": [GWUtility stringSafeOperation:[GWObject sharedGWObject].GWSERVERIP]}] Action:@"sys/gameactivate" success:^(id object, NSError *error) {
    } error:^(NSInteger number, NSError *error) {
    }];
}

+(void)EnterBackground
{
    NSMutableString* endtime=[[NSMutableString alloc]initWithCapacity:0];
    [endtime appendString:@"e"];
    [endtime appendString:[GWUtility timestampFromIntDate:[NSDate date]]];
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"timearray"]) {
        
        NSData* data=[[NSUserDefaults standardUserDefaults] objectForKey:@"timearray"];
        NSMutableArray*array=[NSKeyedUnarchiver unarchiveObjectWithData:data];
        [array addObject:endtime];
        
        NSData * enddata=[NSKeyedArchiver archivedDataWithRootObject:array];
        NSUserDefaults* defaults=[NSUserDefaults standardUserDefaults];
        [defaults setObject:enddata forKey:@"timearray"];
        [defaults synchronize];
        //  DLog(@"timearray %@",array);
        NSMutableString* timstamps=[[NSMutableString alloc]initWithCapacity:0];
        for (NSMutableString* timestr in array) {
            if ([timstamps length]<=0) {
                NSString* temp=[timestr substringFromIndex:1];
                [timstamps appendString:temp];
            }
            else{
                if ([[timestr substringToIndex:1] isEqualToString:@"s"])
                {
                    NSString* temp=[timestr substringFromIndex:1];
                    [timstamps appendString:[NSString stringWithFormat:@",%@",temp]];
                }
                else if([[timestr substringToIndex:1] isEqualToString:@"e"])
                {
                    NSString* temp=[timestr substringFromIndex:1];
                    [timstamps appendString:[NSString stringWithFormat:@"|%@",temp]];
                }
            }
        }

        [[GWNetEngine sharedGWNetEngine] postRequestWithParameters:[NSMutableDictionary dictionaryWithDictionary:@{@"cood": [GWUtility stringSafeOperation:[GWObject sharedGWObject].GWSERVERIP],@"timestamp":timstamps}] Action:@"sys/gamedeactivate" success:^(id object, NSError *error) {
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"timearray"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        } error:^(NSInteger number, NSError *error) {
            
        }];
        
    }

}



+ (NSString *)getApplicationGameKey
{
    return [GWObject sharedGWObject].GWGAMEKEY;
}

+ (NSString *)getChannelID
{
    return [GWObject sharedGWObject].GWCHANNELID;
}

+ (NSTimeInterval)networkTimeoutInterval
{
    return [GWObject sharedGWObject].NETWORKTIME;
}

+ (void)setNetworkTimeoutInterval:(NSTimeInterval)time
{
    [GWObject sharedGWObject].NETWORKTIME = time;
}

+ (void)setLogLevel:(GWLogLevel)level
{
    [GWObject sharedGWObject].LOGLEVEL = level;
}

+(GWLogLevel)logLevel
{
    return [GWObject sharedGWObject].LOGLEVEL;
}

//是否debug模式 or relese模式
+ (void)setProductionMode:(BOOL)isProduction
{

    [GWObject sharedGWObject].isPRODECTION = isProduction;
    
}


/*!
 *  1. 获取公网IP
    2. 上传公网IP
 */
+ (void)startGameWorks
{
    [[GWNetEngine sharedGWNetEngine] postRequestWithParameters:nil Action:@"sys/net" success:^(id object, NSError *error) {
        NSString * serverIP = [object valueForKey:@"ip"];
        if (![GWUtility IsNilOrEmpty:serverIP]) {
            
            [GWObject sharedGWObject].GWSERVERIP = serverIP;
            
            static dispatch_once_t onceToken;
            dispatch_once(&onceToken, ^{
                [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gwapplicationDidEnterBackground:) name:UIApplicationDidEnterBackgroundNotification object:nil];
                
                [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gwapplicationDidBecomeActive:) name:UIApplicationWillEnterForegroundNotification object:nil];
            });
            
            [[GWNetEngine sharedGWNetEngine] postRequestWithParameters:[NSMutableDictionary dictionaryWithDictionary:@{@"cood":serverIP}] Action:@"sys/gamestart" success:^(id object, NSError *error) {
                // game init success
            } error:^(NSInteger number, NSError *error) {
                
            }];
        }
    } error:^(NSInteger number, NSError *error) {
        
    }];
}


+ (void)exchangeUserAccountAction
{
    
}


+(void) startRequsetThridLoginSupport
{
    [[GWNetEngine sharedGWNetEngine] postRequestWithParameters:nil Action:@"social/third" success:^(id object, NSError *error) {
        // game init success
    } error:^(NSInteger number, NSError *error) {
        
    }];
}

+(void) startRequsetGameSettings
{
    [[GWNetEngine sharedGWNetEngine] postRequestWithParameters:nil Action:@"game/serviceconfig" success:^(id object, NSError *error) {
        // game init success
        [GWObject sharedGWObject].GWPASSSERVICETEL = [GWUtility stringSafeOperation:[object valueForKey:@"passservicetel"]];
        
        [GWObject sharedGWObject].GWSERVICETEL = [GWUtility stringSafeOperation:[object valueForKey:@"payservicetel"]];
        [GWObject sharedGWObject].GWSERVICEQQ = [GWUtility stringSafeOperation:[object valueForKey:@"serviceqq"]];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kGWSDKInitSuccessNotification object:nil];
    } error:^(NSInteger number, NSError *error) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kGWSDKInitFailNotification object:nil];
    }];
}

+(void) setupWindowsPopMenu
{
    BOOL isIpad = ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad);
    UIWindow * windowView = [[UIApplication sharedApplication].windows firstObject];
    UIViewController * rootViewContr =  windowView.rootViewController;
    [GWUtility printSystemLog:rootViewContr];
    GWSDKBannerMenuView *bannerMV2 = [[GWSDKBannerMenuView alloc] initWithFrame:CGRectMake(0, 60, isIpad?75:45, isIpad?75:45) menuWidth:(isIpad?200:220-70) buttonTitle:@[@"用户中心", @"切换用户"] withBlock:^(NSUInteger index) {
        GWSDKViewController * openViewcontr;
        GWUICKeyChainStore * keyChainObj = [GWUICKeyChainStore keyChainStore];
        if (index == 0) {
        
            if ([keyChainObj stringForKey:KeyChain_GW_USER_UID] && [keyChainObj stringForKey:KeyChain_GW_USER_UID].length > 0) {
                //是否登录
                if ([GWUser isAuthenticated]) {
                    openViewcontr = [[GWSDKUserCenterViewController alloc] initWithNibName:[GWUtility stringByViewController:NSStringFromClass([GWSDKUserCenterViewController class])] bundle:nil];
                }else {
                     openViewcontr = [[GWSDKQuarkViewController alloc] initWithNibName:[GWUtility stringByViewController:NSStringFromClass([GWSDKQuarkViewController class])] bundle:nil];
                }

            }else{
                openViewcontr = [[GWSDKLoginViewController alloc] initWithNibName:[GWUtility stringByViewController:NSStringFromClass([GWSDKLoginViewController class])] bundle:nil];
            }
        
        }else if (index == 1)
        {
             if ([keyChainObj stringForKey:KeyChain_GW_USER_UID] && [keyChainObj stringForKey:KeyChain_GW_USER_UID].length > 0) {
                 openViewcontr = [[GWSDKQuarkViewController alloc] initWithNibName:[GWUtility stringByViewController:NSStringFromClass([GWSDKQuarkViewController class])] bundle:nil];
             }else{
                 openViewcontr = [[GWSDKLoginViewController alloc] initWithNibName:[GWUtility stringByViewController:NSStringFromClass([GWSDKLoginViewController class])] bundle:nil];
             }
        }
        
        if (openViewcontr) {
            CGSize size_screen = [GWUtility fixedScreenSize];
            GWSDKNavigationController *nav = [[GWSDKNavigationController alloc] initWithSize:CGSizeMake(isIpad?size_screen.width*0.85*0.5:size_screen.width*0.90,isIpad?size_screen.height*0.8*0.5:size_screen.height*0.8) rootViewController:openViewcontr];
            nav.touchSpaceHide = NO;
            nav.panPopView = YES;
            openViewcontr.title = @"登录";
            [nav show:YES animated:YES];
        }
    }];
    bannerMV2.tag = kGWtoastShowTAG;
    
    [rootViewContr.view addSubview:bannerMV2];
    
}


void UncaughtExceptionHandler(NSException *exception) {
    
    NSArray *arr = [exception callStackSymbols];
    
    NSString *reason = [exception reason];
    
    NSString *name = [exception name];
    
    NSString* errorstr=[NSString stringWithFormat:@"[%@:%@--------#%@-----#%@]",name,reason,[arr componentsJoinedByString:@"<br>"],[[NSNumber numberWithDouble:[[NSDate date] timeIntervalSince1970]] stringValue]];
    [GWGameWorks crashReport:errorstr];
}

+ (void) crashReport:(NSString*)errorstr
{
    
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"gperrorarray"]) {
        NSMutableArray* array=[[NSMutableArray alloc]initWithCapacity:0];
        [array addObject:errorstr];
        
        NSData* data=[NSKeyedArchiver archivedDataWithRootObject:array];
        NSUserDefaults* defaults=[NSUserDefaults standardUserDefaults];
        [defaults setObject:data forKey:@"gperrorarray"];
        [defaults synchronize];
        
    }
    else{
        NSData* tempData=[[NSUserDefaults standardUserDefaults] objectForKey:@"gperrorarray"];
        NSMutableArray* tempArray=[[NSMutableArray alloc]initWithCapacity:0];
        NSMutableArray* array=[NSKeyedUnarchiver unarchiveObjectWithData:tempData];
        for (NSString* str in array) {
            [tempArray addObject:str];
        }
        [tempArray addObject:errorstr];
        
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"gperrorarray"];
        
        NSData* data=[NSKeyedArchiver archivedDataWithRootObject:tempArray];
        NSUserDefaults* defaults=[NSUserDefaults standardUserDefaults];
        [defaults setObject:data forKey:@"gperrorarray"];
        [defaults synchronize];
    }
}

/*!
 *  上传crash日志
 */
+ (void)uploadCrashReport
{
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"gperrorarray"]) {
        NSData* tempData=[[NSUserDefaults standardUserDefaults] objectForKey:@"gperrorarray"];
        NSMutableArray* array=[NSKeyedUnarchiver unarchiveObjectWithData:tempData];
        NSMutableString* contentstr=[[NSMutableString alloc]initWithCapacity:0];
        for (NSString* str in array) {
            [contentstr appendString:str];
        }
        [[GWNetEngine sharedGWNetEngine] postRequestWithParameters:[NSMutableDictionary dictionaryWithDictionary:@{@"content":[GWUtility base64Encode:contentstr]}] Action:@"sys/abnormal" success:^(id object, NSError *error) {
            // game init success
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"gperrorarray"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
        } error:^(NSInteger number, NSError *error) {
            
        }];
    }
}

+ (void)showGWSDKUserCenterViewController
{
    GWSDKViewController * openViewcontr;
    GWUICKeyChainStore * keyChainObj = [GWUICKeyChainStore keyChainStore];
    if ([keyChainObj stringForKey:KeyChain_GW_USER_UID] && [keyChainObj stringForKey:KeyChain_GW_USER_UID].length > 0)
    {
        //有登录
        openViewcontr = [[GWSDKUserCenterViewController alloc] initWithNibName:[GWUtility stringByViewController:NSStringFromClass([GWSDKUserCenterViewController class])] bundle:nil];
    }else{
        openViewcontr = [[GWSDKLoginViewController alloc] initWithNibName:[GWUtility stringByViewController:NSStringFromClass([GWSDKLoginViewController class])] bundle:nil];
        
    }
    BOOL isIpad = ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad);
    if (openViewcontr) {
        CGSize size_screen = [GWUtility fixedScreenSize];
        GWSDKNavigationController *nav = [[GWSDKNavigationController alloc] initWithSize:CGSizeMake(isIpad?size_screen.width*0.85*0.5:size_screen.width*0.90,isIpad?size_screen.height*0.8*0.5:size_screen.height*0.8) rootViewController:openViewcontr];
        
        nav.touchSpaceHide = NO;
        nav.panPopView = YES;
        [nav show:YES animated:YES];
    }
}


+ (void)showGWSDKUserLoginCenterViewController
{
    GWSDKViewController * openViewcontr;
    GWUICKeyChainStore * keyChainObj = [GWUICKeyChainStore keyChainStore];
    if ([keyChainObj stringForKey:KeyChain_GW_USER_UID] && [keyChainObj stringForKey:KeyChain_GW_USER_UID].length > 0)
    {
        //有登录
         openViewcontr = [[GWSDKQuarkViewController alloc] initWithNibName:[GWUtility stringByViewController:NSStringFromClass([GWSDKQuarkViewController class])] bundle:nil];
    }else{
        openViewcontr = [[GWSDKLoginViewController alloc] initWithNibName:[GWUtility stringByViewController:NSStringFromClass([GWSDKLoginViewController class])] bundle:nil];
        
    }
    BOOL isIpad = ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad);
    if (openViewcontr) {
        
        CGSize size_screen = [GWUtility fixedScreenSize];
        GWSDKNavigationController *nav = [[GWSDKNavigationController alloc] initWithSize:CGSizeMake(isIpad?size_screen.width*0.85*0.5:size_screen.width*0.90,isIpad?size_screen.height*0.8*0.5:size_screen.height*0.8) rootViewController:openViewcontr];
        
        nav.touchSpaceHide = NO;
        nav.panPopView = YES;
        openViewcontr.title = @"登录";
        [nav show:YES animated:YES];
    }
}

+ (void)showGWSDKtempUserLoginCenterViewController
{
    GWSDKViewController * openViewcontr = [[GWSDKLoginViewController alloc] initWithNibName:[GWUtility stringByViewController:NSStringFromClass([GWSDKLoginViewController class])] bundle:nil];
    BOOL isIpad = ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad);
    if (openViewcontr) {
        
        CGSize size_screen = [GWUtility fixedScreenSize];
        GWSDKNavigationController *nav = [[GWSDKNavigationController alloc] initWithSize:CGSizeMake(isIpad?size_screen.width*0.85*0.5:size_screen.width*0.90,isIpad?size_screen.height*0.8*0.5:size_screen.height*0.8) rootViewController:openViewcontr];
        
        nav.touchSpaceHide = NO;
        nav.panPopView = YES;
        openViewcontr.title = @"登录";
        [nav show:YES animated:YES];
    }
}

+ (void)showGWSDKPaymentHistoryViewController
{
    GWSDKPayHistoryViewController *openViewcontr = [[GWSDKPayHistoryViewController alloc] initWithNibName:[GWUtility stringByViewController:NSStringFromClass([GWSDKPayHistoryViewController class])] bundle:nil];
    
    UIWindow *window = [[UIApplication sharedApplication].windows firstObject];
    [window.rootViewController presentViewController:openViewcontr animated:YES completion:^{
        
    }];
}

+ (void)showGWSDKPaymentViewController:(id)payorder
{
    
    GWSDKPaymentViewController *openViewcontr = [[GWSDKPaymentViewController alloc] initWithNibName:[GWUtility stringByViewController:NSStringFromClass([GWSDKPaymentViewController class])] bundle:nil];
    openViewcontr.payorder = payorder;
    UIWindow *window = [[UIApplication sharedApplication].windows firstObject];
    [window.rootViewController presentViewController:openViewcontr animated:YES completion:^{
        
    }];
}

+ (void) checkorderstatusblock:(void(^)(BOOL succeeded, NSString *string,NSString *msg))successResultBlock
{
    GWUICKeyChainStore * keyChainObj = [GWUICKeyChainStore keyChainStore];
    
    NSString * uid =  [keyChainObj stringForKey:KeyChain_GW_USERCURRENTLOGIN_UID];
    NSString * orderid = [keyChainObj stringForKey:[NSString stringWithFormat:@"%@-%@",KeyChain_GW_ORDERID,uid]];
    if (orderid && orderid.length > 0) {
        [GWSDKPayMent requestOrderResultInBackground:orderid block:^(id object, NSError *error) {
            if (object) {
                /*
                 amount = "1.00";
                 errMsg = "";
                 msg = RmFpbGVkIHRvIHJlY2hhcmdlIHRvIHRoZSBnYW1l;
                 ordernumber = 1501227003000009;
                 status = 6;
                 success = 0;
                 
                 0：已下单
                 1：已向第三方平台申请
                 
                 5： 已收到第三方支付成功
                 6： 向游戏充值
                 7： 游戏充值成功
                 8： 完成
                 */
                NSString * msg = @"";
                id status = [object valueForKey:@"status"];
                if (status) {
                    switch ([status intValue]) {
                        case 0:
                            msg = @"已下单";
                            break;
                        case 1:
                            msg = @"已向第三方平台申请";
                            break;
                        case 5:
                            msg = @"已收到第三方支付成功";
                            break;
                        case 6:
                            msg = @"向游戏充值";
                            break;
                        case 7:
                            msg = @"游戏充值成功";
                            break;
                        case 8:
                            msg = @"完成";
                            break;
                            
                        default:
                            break;
                    }
                }
                successResultBlock(YES,orderid,msg);
            }else{
                successResultBlock(NO,orderid,@"");
            }
        }];
    }else{
         successResultBlock(NO,orderid,@"");
    }
}

+ (void) showBanner:(BOOL) show
{
    
    UIWindow * windowView = [[UIApplication sharedApplication].windows firstObject];
    UIViewController * rootViewContr =  windowView.rootViewController;
    
    [rootViewContr.view.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIView * view = (UIView *) obj;
        if (view.tag ==kGWtoastShowTAG ) {
            if (show) {
                view.hidden = NO;
            }else {
                view.hidden = YES;
            }
        }
        
    }];
}

+ (void) hiddenBanner:(BOOL) hidden
{
    [self showBanner:NO];
}

@end
