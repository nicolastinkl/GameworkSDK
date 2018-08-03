//
//  GWNetworkService.m
//  GamePluginSDK
//
//  Created by zhangzhongming on 14/11/10.
//  Copyright (c) 2014年 zhangzhongming. All rights reserved.
//

#import "GWNetworkService.h"
#import "GWLogUtility.h"
#import "GWCommonUtility.h"
#import "GWGzipUtillity.h"

#define SERVICE_JSON_ERROR @"json 数据解析异常"
#define SEND_INFO          @"info"
#define SEND_PARAM         @"param"


@implementation GWNetworkService

// 获取单例对象

+(GWNetworkService *)defaultService
{
    static GWNetworkService *service;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        service = [[GWNetworkService alloc] init];
    });
    return service;
}


-(void)cancleAllService
{
    [self cancle];
}

// 带公共信息info
-(void) requestIntegrationPlatformWithUrl:(NSString *)url
                                   params:(NSDictionary *)parmas
                              sucessBlock:(void (^)(GWGeneralResult *result)) sucessBlock
                                failBlock:(void (^)(NSString *errorMsg)) failedBlock
{
    //数据组装
    NSMutableDictionary *info = [GWCommonUtility achieveSharedSendInfo];
    NSDictionary *sendDic;
    if (parmas)
        sendDic = [[NSDictionary alloc] initWithObjectsAndKeys:info,SEND_INFO,parmas,SEND_PARAM,nil];
    else
        sendDic = [[NSDictionary alloc] initWithObjectsAndKeys:info,SEND_INFO,nil];
    NSString *json = [self jsonFromDictionary:sendDic];
    DLog(@"send json=====:%@",json);
    
    //数据加密
    const char *strChar = [json UTF8String];
    json =  [GWCommonUtility encryptAES_128_CBC_Data:strChar];
    NSData   *sendData = [json dataUsingEncoding:NSUTF8StringEncoding];
    
    //数据压缩
    if([GWCommonUtility acceptZip])
    {
       sendData =  [GWGzipUtillity gzipData:sendData];
    }
    
    //发送数据
    [self sendAsynchronousWithUrl:url data:sendData sucessBlock:^(NSData *respondData) {
        
        NSData *resData = respondData;
        
        //数据解压
        if ([GWCommonUtility acceptZip]) {
            resData = [GWGzipUtillity uncompressZippedData:respondData];
        }
        
        NSString *resString = [[NSString alloc] initWithData:resData encoding:NSUTF8StringEncoding];
        if (resString ==nil || [resString isEqualToString:@""]) {
            if (failedBlock)
                failedBlock(SERVICE_JSON_ERROR);

        }else
        {
            DLog(@"response json=====:%@",resString);
            resString = [GWCommonUtility decryptAES_128_CBC_Data:[resString UTF8String]];
            
            if (resString) {
                DLog(@"解密后=====:%@",resString);
                
                NSError *jsonError;
                NSDictionary *resDic = [NSJSONSerialization JSONObjectWithData:[resString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&jsonError];
                if (!jsonError && resDic) {
                    if (sucessBlock)
                        sucessBlock([[GWGeneralResult alloc] initWithDictionary:resDic]);
                }else
                {
                    if (failedBlock)
                        failedBlock(SERVICE_JSON_ERROR);
                }
            }else
            {
                if (failedBlock)
                    failedBlock(SERVICE_JSON_ERROR);
            }
        }
    } failBlock:failedBlock];
}


-(NSString *) jsonFromDictionary:(NSDictionary *)dictionary
{
    NSString *json = @"{}";
    if (!dictionary) {
        return json;
    }
    NSError *jsonError;
    NSData *data = [NSJSONSerialization dataWithJSONObject:dictionary options:NSJSONWritingPrettyPrinted error:&jsonError];
    if (!jsonError && data) {
        json = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    
    return json;
}

@end
