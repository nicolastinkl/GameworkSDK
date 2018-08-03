//
//  GWUser.m
//  GameworksSDK
//
//  Created by tinkl on 7/1/15.
//  Copyright (c) 2015年 ___GAMEWORK___. All rights reserved.
//

#import "GWUser.h"
#import "GWObject.h"
#import "JSONModel+networking.h"
#import "GWNetEngine.h"
#import "GWUtility.h"
#import "GWMacro.h"
#import "GWUICKeyChainStore.h"
#import "GWSDKPayMent.h"

__strong static GWUser * sharedGWUser = nil;

@implementation GWUser

/*!
 *  from local cache
 *
 *  @return self
 */
+(instancetype)currentUser
{
    if (sharedGWUser == nil) {
        sharedGWUser = [[GWUser alloc] init];
    }
    
    GWUICKeyChainStore * keyChainObj = [GWUICKeyChainStore keyChainStore];
    NSString * currentUID =  [keyChainObj stringForKey:KeyChain_GW_USERCURRENTLOGIN_UID];
    if (currentUID && currentUID.length > 0) {
        //init current'USER object.
        sharedGWUser.userId = currentUID;
        sharedGWUser.username = [keyChainObj stringForKey:[NSString stringWithFormat:@"%@_%@",KeyChain_GW_USER_USERNAME,currentUID]];
        sharedGWUser.password = [keyChainObj stringForKey:[NSString stringWithFormat:@"%@_%@",KeyChain_GW_USER_PASSWORD,currentUID]];
        sharedGWUser.nickname = [keyChainObj stringForKey:[NSString stringWithFormat:@"%@_%@",KeyChain_GW_USER_NICKNAME,currentUID]];
        sharedGWUser.sessionToken = [keyChainObj stringForKey:[NSString stringWithFormat:@"%@_%@",KeyChain_GW_USER_SESSIONTOKEN,currentUID]];
        sharedGWUser.loginWithType = [keyChainObj stringForKey:[NSString stringWithFormat:@"%@_%@",KeyChain_GW_USER_LOGINTYPE,currentUID]];
    }    
    return sharedGWUser;
}

+ (instancetype)newUser
{
   return [[GWUser alloc] init];
}

+(BOOL)isAuthenticated
{

    GWUICKeyChainStore * keyChainObj = [GWUICKeyChainStore keyChainStore];
    NSString *currentuid = [keyChainObj stringForKey:KeyChain_GW_USERCURRENTLOGIN_UID];
    if (currentuid && currentuid.length > 0) {
        return YES;
    }
    return NO;
    
    
}

//注册
+ (void)signUpInBackgroundWithBlock:(NSString *)username
                           password:(NSString *)password
                              block:(GWBooleanResultBlock)block
{
    //检测用户输入的username类型 //邮箱 0、手机号 1、用户名 2
    NSString * userType;
    if ([GWUtility isValidateEmail:username]) {
        userType = @"0";
    }else if ([GWUtility isValidatePhoneNumber:username])
    {
        userType = @"1";
    }else{
        userType = @"2";
    }
    
    [[GWNetEngine sharedGWNetEngine] postRequestWithParameters:[NSMutableDictionary dictionaryWithDictionary:@{@"mail": username,@"password":[GWUtility md5:password],@"platform":@"MINIGAME",@"mark":userType}] Action:@"user/register" success:^(id object, NSError *error) {
        //cache user
        NSString * UID =  [object valueForKey:@"uid"];
        //保存用户到本地数据中
        GWUser *newUser = [GWUser newUser];
        newUser.username = username;
        newUser.password = password;
        newUser.nickname = username;
        newUser.sessionToken = @"";
        newUser.userId = UID;
        newUser.loginWithType = userType;
        newUser.isTempUser = NO;
        [self saveCache:newUser];
        
        [GWSDKPayMent showNotifyToast:[NSString stringWithFormat:@"%@,欢迎回来",[NSString stringWithFormat:@"%@",username]]];
        
        //设置当前登录中的UID
        GWUICKeyChainStore * keyChainObj = [GWUICKeyChainStore keyChainStore];
        [keyChainObj setString:[GWUtility stringSafeOperation:UID] forKey:KeyChain_GW_USERCURRENTLOGIN_UID];
        [keyChainObj synchronize];
        
        block(YES,error);
        [[NSNotificationCenter defaultCenter] postNotificationName:kGWSDKRigisterNotification object:nil];
        
    } error:^(NSInteger number, NSError *error) {
        block(NO,error);
    }];
}

//登录
+(void)logInWithUsernameInBackground:(NSString *)username password:(NSString *)password block:(GWUserResultBlock)block
{
    
    NSString * userType;
    if ([GWUtility isValidateEmail:username]) {
        userType = @"0";
    }else if ([GWUtility isValidatePhoneNumber:username])
    {
        userType = @"1";
    }else{
        userType = @"2";
    }
    
    NSString *timeStamp = [NSString stringWithFormat:@"%d", (int)[[NSDate date] timeIntervalSince1970]];
    NSString *md5Str = [GWUtility md5:[NSString stringWithFormat:@"%@%@", [GWUtility md5:[GWUtility md5:password]], timeStamp]];
    [[GWNetEngine sharedGWNetEngine] postRequestWithParameters:[NSMutableDictionary dictionaryWithDictionary:@{@"username": username,@"password":md5Str,@"timestamp":timeStamp,@"mark":userType,@"version":GAMEWORK_VERSION}] Action:@"user/login" success:^(id object, NSError *error) {
        //cache user
        NSString *uid = [object valueForKey:@"uid"];
        //设置当前登录中的UID
        GWUICKeyChainStore * keyChainObj = [GWUICKeyChainStore keyChainStore];
        [keyChainObj setString:[GWUtility stringSafeOperation:uid] forKey:KeyChain_GW_USERCURRENTLOGIN_UID];
        [keyChainObj setString:[GWUtility stringSafeOperation:[object valueForKey:@"session"]] forKey:[NSString stringWithFormat:@"%@_%@",KeyChain_GW_USER_SESSIONTOKEN,uid]];
        [keyChainObj synchronize];
        
        GWUser *newUser = [GWUser newUser];
        newUser.username = username;
        newUser.password = password;
        newUser.nickname = username;
        newUser.sessionToken = [GWUtility stringSafeOperation:[object valueForKey:@"session"]];
        newUser.userId = [GWUtility stringSafeOperation:uid];
        newUser.loginWithType = userType;
        newUser.isTempUser = NO;
        [self saveCache:newUser];
        
        [GWSDKPayMent showNotifyToast:[NSString stringWithFormat:@"%@,欢迎回来",[NSString stringWithFormat:@"%@",username]]];
        //设置SESSIONTOKEN
        block([self currentUser],nil);
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kGWSDKLoginResultNotification object:@{@"loginstatus":@(YES),@"msg":@"normalUser"}];
        
    } error:^(NSInteger number, NSError *error) {
        block(nil,error);
        NSString * errorDes = [[error userInfo] valueForKey:NSLocalizedDescriptionKey];
        [[NSNotificationCenter defaultCenter] postNotificationName:kGWSDKLoginResultNotification object:@{@"loginstatus":@(NO),@"msg":errorDes}];
    }];
}

+ (void)relogInWithUsernameInBackground:(NSString *)username
                                  block:(GWUserResultBlock)block
{
    NSString * userType;
    if ([GWUtility isValidateEmail:username])
    {
        userType = @"0";
    }else if ([GWUtility isValidatePhoneNumber:username])
    {
        userType = @"1";
    }else{
        userType = @"2";
    }
    
    [[GWNetEngine sharedGWNetEngine] postRequestWithParameters:[NSMutableDictionary dictionaryWithDictionary:@{@"username": username,@"mark":userType}] Action:@"user/relogin" success:^(id object, NSError *error) {
        //cache user
        [GWSDKPayMent showNotifyToast:[NSString stringWithFormat:@"%@,欢迎回来",[NSString stringWithFormat:@"%@",username]]];
        
        NSString *uid = [object valueForKey:@"uid"];
        //设置当前登录中的UID
        GWUICKeyChainStore * keyChainObj = [GWUICKeyChainStore keyChainStore];
        [keyChainObj setString:[GWUtility stringSafeOperation:uid] forKey:KeyChain_GW_USERCURRENTLOGIN_UID];
        [keyChainObj setString:[GWUtility stringSafeOperation:[object valueForKey:@"session"]] forKey:[NSString stringWithFormat:@"%@_%@",KeyChain_GW_USER_SESSIONTOKEN,uid]];
        
        [keyChainObj synchronize];
        
        NSArray * serverArray = [object valueForKey:@"serverlist"];
        if (serverArray && serverArray.count > 0) {
            [self saveServerInfoCache:[serverArray firstObject]];
        }
        
        //设置SESSIONTOKEN
        block([self currentUser],nil);

        [[NSNotificationCenter defaultCenter] postNotificationName:kGWSDKLoginResultNotification object:@{@"loginstatus":@(YES),@"msg":@"normalUser"}];
    } error:^(NSInteger number, NSError *error) {
        block(nil,error);
        NSString * errorDes = [[error userInfo] valueForKey:NSLocalizedDescriptionKey];
        [[NSNotificationCenter defaultCenter] postNotificationName:kGWSDKLoginResultNotification object:@{@"loginstatus":@(NO),@"msg":errorDes}];
    }];
}

//游客登录
+ (void)logInWithTempUsernameInBackgroundblock:(GWUserResultBlock)block
{
    //ipstr
    [[GWNetEngine sharedGWNetEngine] postRequestWithParameters:nil Action:@"user/tmpuser" success:^(id object, NSError *error) {
        
        //标识临时用户
        //保存用户到本地数据中
        GWUser *newUser = [GWUser newUser];
        newUser.username = [GWUtility base64Decode:[NSString stringWithFormat:@"%@",[object valueForKey:@"username"]]];
        newUser.password = [object valueForKey:@"initialpwd"];
        newUser.nickname = [GWUtility base64Decode:[NSString stringWithFormat:@"%@",[object valueForKey:@"nickname"]]];
        newUser.sessionToken = [object valueForKey:@"session"];
        newUser.userId = [GWUtility stringSafeOperation:[object valueForKey:@"uid"]];
        newUser.loginWithType = [object valueForKey:@"mark"];
        newUser.isTempUser = YES;
        [self saveCache:newUser];

        [GWSDKPayMent showNotifyToast:[NSString stringWithFormat:@"%@,欢迎回来",[NSString stringWithFormat:@"%@",newUser.nickname]]];
        
        NSArray * serverArray = [object valueForKey:@"serverlist"];
        if (serverArray && serverArray.count > 0) {
            [self saveServerInfoCache:[serverArray firstObject]];
        }
        
        //设置当前登录中的UID
        GWUICKeyChainStore * keyChainObj = [GWUICKeyChainStore keyChainStore];
        [keyChainObj setString:[GWUtility stringSafeOperation:[object valueForKey:@"uid"]] forKey:KeyChain_GW_USERCURRENTLOGIN_UID];
        [keyChainObj synchronize];
        
        //处理回调事件
        block(newUser,nil);
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kGWSDKLoginResultNotification object:@{@"loginstatus":@(YES),@"msg":@"tempUser"}];
    } error:^(NSInteger number, NSError *error) {
        //notify error
         block(nil,error);
        
        NSString * errorDes = [[error userInfo] valueForKey:NSLocalizedDescriptionKey];
        [[NSNotificationCenter defaultCenter] postNotificationName:kGWSDKLoginResultNotification object:@{@"loginstatus":@(NO),@"msg":errorDes}];
    }];
}

/*!
 *  存储服务器信息
 *
 *  @param dictionary json dict
 */
+(void)saveServerInfoCache:(NSDictionary *) dictionary
{
    if (dictionary) {
        NSString * server_id = [dictionary valueForKey:@"server_id"];
        NSString * server_no = [dictionary valueForKey:@"server_no"];
        NSString * server_name = [dictionary valueForKey:@"server_name"];
        
        [GWObject sharedGWObject].GWSERVER_S_ID = server_id;
        [GWObject sharedGWObject].GWSERVER_S_NO = server_no;
        [GWObject sharedGWObject].GWSERVER_S_NAME = server_name;
        
    }
}

+ (void)logOutInBackgroundblock:(GWBooleanResultBlock)block
{
     [[GWNetEngine sharedGWNetEngine] postRequestWithParameters:nil Action:@"user/logout" success:^(id object, NSError *error) {
         
         if (object) {
             
             //设置当前登录中的UID
             GWUICKeyChainStore * keyChainObj = [GWUICKeyChainStore keyChainStore];
             [keyChainObj setString:@"" forKey:KeyChain_GW_USERCURRENTLOGIN_UID];
             [keyChainObj synchronize];
             
             [[NSNotificationCenter defaultCenter] postNotificationName:kGWSDKLogoutResultNotification object:nil];
             
             block(YES,nil);
             
             
         }else{

             block(NO,error);
         }

     } error:^(NSInteger number, NSError *error) {
         //notify error
         block(NO,error);
     }];
}

/*!
 *  修改密码
 *
 */
+ (void)requestPasswordResetForPasswordInBackground:(NSString *)pass
                                             newpwd:(NSString*)newpass
                                              block:(GWBooleanResultBlock)block
{
    
    [[GWNetEngine sharedGWNetEngine] postRequestWithParameters:[NSMutableDictionary dictionaryWithDictionary:@{@"oldpass": [GWUtility md5:pass],@"newpass": [GWUtility md5:newpass]}] Action:@"user/changepass" success:^(id object, NSError *error) {
        [GWUtility printSystemLog:object];
        if (object) {
            // 1. 更新本地keychain密码数据
            // 2. 更新UI
            block(YES,error);
            GWUICKeyChainStore * keyChainObj = [GWUICKeyChainStore keyChainStore];
            NSString * uid = [keyChainObj stringForKey:KeyChain_GW_USERCURRENTLOGIN_UID];
            [keyChainObj setString:newpass forKey:[NSString stringWithFormat:@"%@_%@",KeyChain_GW_USER_PASSWORD,uid]];
            [keyChainObj synchronize];

            [[NSNotificationCenter defaultCenter] postNotificationName:kGWSDKCHANGEPWDNotification object:newpass];
        }else{
            block(NO,error);
        }
    } error:^(NSInteger number, NSError *error) {
        //notify error
        block(NO,error);
    }];
}



/*!
 *  缓存用户到本地
 *  @param gwuser gwuser
 */
+ (void) saveCache:(GWUser *) gwuser
{
    GWUICKeyChainStore * keyChainObj = [GWUICKeyChainStore keyChainStore];
    if ([keyChainObj stringForKey:KeyChain_GW_USER_UID]) {
        
        //找到原有数据源
        NSString * continString = [keyChainObj stringForKey:KeyChain_GW_USER_UID];
        
        NSArray *strArray = [continString componentsSeparatedByString:@"-"];
        [GWUtility printSystemLog:strArray];
        
        NSMutableArray * newArray = [NSMutableArray arrayWithArray:strArray];
        
        [newArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            //遍历所有元素 然后找到临时用户替换之.
            /*!
             * po "newArray" : (
                    "",
                    "5928@MINIGAME"
                ) 
             */
            NSString * isTempUser = [keyChainObj stringForKey:[NSString stringWithFormat:@"%@_%@",KeyChain_GW_USER_STATUS_TEMP,obj]];
            if ([isTempUser isEqualToString:@"1"] && gwuser.isTempUser) {
                // TURE
                [newArray removeObject:obj];
            }
        }];
        
        /*!
         *  MARK:需要判断是否是临时用户,只能允许一个临时账户
         *       生成新的字符串
         */
        if (![newArray containsObject:[NSString stringWithFormat:@"%@",gwuser.userId]]) {
            [newArray insertObject:[NSString stringWithFormat:@"%@",gwuser.userId] atIndex:0];
        }
        NSString * resultContinString = [[newArray valueForKey:@"description"] componentsJoinedByString:@"-"];
//        resultContinString = [resultContinString stringByAppendingString:[NSString stringWithFormat:@"-%@",gwuser.userId]];
        [keyChainObj setString:resultContinString forKey:KeyChain_GW_USER_UID];
       
    }else{
        //add init
        [keyChainObj setString:gwuser.userId forKey:KeyChain_GW_USER_UID];
    }
    [keyChainObj setString:gwuser.username forKey:[NSString stringWithFormat:@"%@_%@",KeyChain_GW_USER_USERNAME,gwuser.userId]];
    [keyChainObj setString:gwuser.password forKey:[NSString stringWithFormat:@"%@_%@",KeyChain_GW_USER_PASSWORD,gwuser.userId]];
    [keyChainObj setString:gwuser.nickname forKey:[NSString stringWithFormat:@"%@_%@",KeyChain_GW_USER_NICKNAME,gwuser.userId]];
    [keyChainObj setString:gwuser.sessionToken forKey:[NSString stringWithFormat:@"%@_%@",KeyChain_GW_USER_SESSIONTOKEN,gwuser.userId]];
    [keyChainObj setString:gwuser.loginWithType forKey:[NSString stringWithFormat:@"%@_%@",KeyChain_GW_USER_LOGINTYPE,gwuser.userId]];
    [keyChainObj setString:[NSString stringWithFormat:@"%d",gwuser.isTempUser] forKey:[NSString stringWithFormat:@"%@_%@",KeyChain_GW_USER_STATUS_TEMP,gwuser.userId]];
    
    [keyChainObj synchronize];
}


+ (void)requestUserInfoByUID:(NSString *)userid
                       block:(GWStringResultBlock)block
{
    if (!userid) {
        return;
    }
    [[GWNetEngine sharedGWNetEngine] postRequestWithParameters:[NSMutableDictionary dictionaryWithDictionary:@{@"uid": userid}] Action:@"user/getinfo" success:^(id object, NSError *error) {
        //处理回调事件
        block([GWUtility base64Decode:[GWUtility stringSafeOperation:[object valueForKey:@"nickname"]]],nil);
        
    } error:^(NSInteger number, NSError *error) {
        //notify error
         block(nil,error);
    }];
}

+ (void)bindWithUsernameInBackground:(NSString *)username
                            password:(NSString *)password
                               block:(GWBooleanResultBlock)block
{
    NSString * userType;
    if ([GWUtility isValidateEmail:username]) {
        userType = @"0";
    }else if ([GWUtility isValidatePhoneNumber:username])
    {
        userType = @"1";
    }else{
        userType = @"2";
    }
    
    //ipstr
    [[GWNetEngine sharedGWNetEngine] postRequestWithParameters:[NSMutableDictionary dictionaryWithDictionary:@{@"email": username,@"mail": username,@"password":[GWUtility md5:password],@"mark":userType}] Action:@"user/improvemail" success:^(id object, NSError *error) {
        
        GWUICKeyChainStore * keyChainObj = [GWUICKeyChainStore keyChainStore];
        NSString * uid =  [keyChainObj stringForKey:KeyChain_GW_USERCURRENTLOGIN_UID];
        
        NSString * isTempUser = [keyChainObj stringForKey:[NSString stringWithFormat:@"%@_%@",KeyChain_GW_USER_STATUS_TEMP,uid]];
        if ([isTempUser isEqualToString:@"1"]) {
            // set NO
            [keyChainObj setString:@"0" forKey:[NSString stringWithFormat:@"%@_%@",KeyChain_GW_USER_STATUS_TEMP,uid]];
        }
        [keyChainObj setString:username forKey:[NSString stringWithFormat:@"%@_%@",KeyChain_GW_USER_USERNAME,uid]];
        [keyChainObj setString:username forKey:[NSString stringWithFormat:@"%@_%@",KeyChain_GW_USER_NICKNAME,uid]];
        [keyChainObj setString:password forKey:[NSString stringWithFormat:@"%@_%@",KeyChain_GW_USER_PASSWORD,uid]];
        
        [keyChainObj synchronize];
        
        [GWSDKPayMent showNotifyToast:[NSString stringWithFormat:@"%@,绑定成功",[NSString stringWithFormat:@"%@",username]]];
        
        //处理回调事件
        block(YES,nil);
        
    } error:^(NSInteger number, NSError *error) {
        //notify error
        block(NO,error);
    }];
}


@end
