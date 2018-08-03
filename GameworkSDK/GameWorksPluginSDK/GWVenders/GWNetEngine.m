//
//  GWNetEngine.m
//  GameWorksSDK
//
//  Created by tinkl on 7/1/15.
//  Copyright (c) 2015年 ___GAMEWORK___. All rights reserved.
//

#import "GWNetEngine.h"
#import "GWMacro.h"
#import "JSONModel+networking.h"
#import "GWObject.h"
#import "GWUtility.h"
#import "GWUser.h"
#import "GWMBase64.h"
#import "JSONKit.h"
//#import <UIColor+iOS7Colors/UIColor+iOS7Colors.h>

@implementation GWNetEngine

SINGLETON_GCD(GWNetEngine)

/*!
 *  公共参数处理
 *
 *  @param parames 参数
 *
 *  @return 返回正常参数
 */
-(NSMutableDictionary *)postPublicParams:(NSMutableDictionary *) parames
{
//    [GWUtility printSystemLog:[UIColor iOS7orangeColor]];
    if (parames == nil) {
        parames = [[NSMutableDictionary alloc] init];
    }
    //[GWUtility platformString]
    NSString * publicStringRSA = F(@"%@|%d|%@|%@|%@|%@|%@|%@|%@|%@|%@|%@|%@|%@|%@",
                                   [GWObject sharedGWObject].GWCHANNELID,
                                   [GWUtility isJailBreak],
                                   [GWUtility resolutionScreen],
                                   [GWUtility systemVersionApp],
                                   @"apple",
                                   GAMEWORK_VERSION,
                                   [GWUtility systemUDID],
                                   [GWUtility sysytemCurrentReachabilityStatus],
                                   [GWUtility sysytemCellularProviderName],
                                   [GWUtility platformString],
                                   [GWUtility sysytemCellularCountryCode],
                                   [GWUtility systemLanguages],
                                   ISAPPSTORE,
                                   ISPRIVATE,
                                   [GWUtility systemUDID]);


    
    NSMutableDictionary * publicParames = [[NSMutableDictionary alloc] init];
    publicParames[GP_VERSION] = GAMEWORK_VERSION;
    publicParames[GP_SYSTEM_OS] = [UIDevice currentDevice].systemName;
    publicParames[GP_SYSTEM_OS_VERSION] = [UIDevice currentDevice].systemVersion;
    publicParames[GP_MAC_ADDRESS] = [GWUtility systemUDID];
    publicParames[GP_CHANNEL] = [GWUtility stringSafeOperation:[GWObject sharedGWObject].GWCHANNELID];
    publicParames[GP_ROOT] = [NSString stringWithFormat:@"%d", [GWUtility isJailBreak]];
    publicParames[GP_DEVICE] = [GWUtility platformString];
    publicParames[GP_SESSION] = [GWUtility stringSafeOperation:[GWUser currentUser].sessionToken];
    publicParames[GP_GAME_KEY] = [GWUtility stringSafeOperation:[GWObject sharedGWObject].GWGAMEKEY];
    publicParames[GP_SUPPORT_GZIP] = @"1";
    publicParames[GP_COOKIE] = [GWUtility base64Encode:publicStringRSA];
    publicParames[GP_DEVICETOKEN] = [GWUtility stringSafeOperation:[GWObject sharedGWObject].GWDEVICETOKENID];
    publicParames[GP_SOURCE] = GW_SOURCE_PARAMS;
    publicParames[GP_RESOLUTION] = [GWUtility resolutionScreen];
    publicParames[GP_NETWORK] = [GWUtility sysytemCurrentReachabilityStatus];
    //NSString * strLanguage = [NSString stringWithFormat:@"%@",[[NSLocale preferredLanguages] firstObject]];
    publicParames[GP_LANGUAGE] = @"2";
    NSMutableDictionary * postParames = [[NSMutableDictionary alloc] init];
    [postParames setObject:publicParames forKey:GP_INFO];
    [postParames setObject:parames forKey:GP_PARAMS];

    //a-z 字母排序处理
    NSArray *keysArray = [postParames allKeys];
    
    [keysArray sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];

    [GWUtility printSystemLog:postParames]; // log
    
    return postParames;
    
}

/*!
 * @params 这里要处理:
    1. public参数列表
    2. 参数加密处理
    3. reponse返回值解密处理
    4. 回调处理
 
   @return 返回结果例子:
    
    "info":{"result":"0","errorinfo":"Operation is successful"},
    "data":{"ip":"61.160.248.180"}
 
 */
-(void)postRequestWithParameters:(NSMutableDictionary *) parames Action:(NSString *) action success:(GWIdResultBlock) success error:(GWIntegerResultBlock) fail
{
    if (parames == nil || [parames isKindOfClass:[NSNull class]]) {
        parames = [[NSMutableDictionary alloc] init];
    }
    
    [GWUtility printSystemLog:[NSString stringWithFormat:@"%@   -------- action: %@",parames,action]]; // log
    
    NSMutableDictionary * newParams = [self postPublicParams:parames];
    
    NSString * jsonStr =  [newParams JSONString];
    NSString *postBody = [GWUtility AESStingWithString:[NSString stringWithFormat:@"%@",jsonStr]]; //加密后的字符串
    if ([GWObject sharedGWObject].NETWORKTIME > 0.0) {
        [JSONHTTPClient setTimeoutInSeconds:[GWObject sharedGWObject].NETWORKTIME]; //默认是10s
    }else{
        [JSONHTTPClient setTimeoutInSeconds:10]; //默认是10s
    }
    
    [JSONHTTPClient postJSONFromURLWithString:F(@"%@%@", [GWUtility systemDOMAINURL],action) bodyString:postBody completion:^(id json, JSONModelError *err) {
        [GWUtility printSystemLog:json]; // log
        if (json && [json isKindOfClass:[NSDictionary class]]) {
            
            NSDictionary * responseInfo =  [json valueForKey:@"info"];
            
            NSDictionary * reponseDict =  [json valueForKey:@"data"];
            
            if ([[responseInfo valueForKey:@"result"]  isKindOfClass:[NSDictionary class]]) {
                success(reponseDict,nil);
            }else{
                
                int reslut =  [[responseInfo valueForKey:@"result"] intValue];
                if ((reslut == 0 && reponseDict) || reslut == 0) {
                    if (reponseDict) {
                        success(reponseDict,nil);
                    }else{
                        success(@{},nil);
                    }
                }else {
                    NSString * errorDescription = [GWUtility stringSafeOperation:[responseInfo valueForKey:@"errorinfo"]];
                    NSInteger errorCode = 0;
                    if ([responseInfo valueForKey:@"result"]) {
                        errorCode = [[responseInfo valueForKey:@"result"] integerValue];
                    }
                    //这里是处理失败 如登录密码错误、注册用户已存在、订单重复等
                    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:errorDescription
                                              forKey:NSLocalizedDescriptionKey];
                    NSError *aError = [NSError errorWithDomain:@"local.youxigongchang.com" code:errorCode userInfo:userInfo];
                    fail(1,aError);
                }
                
            }
        }else{
            //网络请求失败
            NSDictionary *userInfo = [NSDictionary dictionaryWithObject:@"网络请求失败"
                                                                 forKey:NSLocalizedDescriptionKey];
            NSError *aError = [NSError errorWithDomain:@"local.youxigongchang.com" code:1 userInfo:userInfo];
            
            fail(1,aError);
        }
        
    }];
    
}

@end
