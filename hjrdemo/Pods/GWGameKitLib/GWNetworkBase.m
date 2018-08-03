//
//  GWNetworkBase.m
//  GamePluginSDK
//
//  Created by zhangzhongming on 14/11/10.
//  Copyright (c) 2014年 zhangzhongming. All rights reserved.
//

#import "GWNetworkBase.h"
#import "GWLogUtility.h"

#define TIMEOUT                30
#define NETWORK_ERROR_INFO     @"网络访问失败"

@implementation GWNetworkBase

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.operationQueue = [[NSOperationQueue alloc] init];
    }
    return self;
}

-(void)cancle
{
    if (self.operationQueue) {
        [self.operationQueue cancelAllOperations];
    }
}

-(void)sendAsynchronousWithUrl:(NSString *)url
                          data:(NSData *)sendData
                   sucessBlock:(void (^)(NSData *respondData)) sucessBlock
                     failBlock:(void (^)(NSString *errorMsg)) failBlock
{
    DLog(@"start request:%@",url);
    
    NSURL *sendUrl = [NSURL URLWithString:url];
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:sendUrl cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:TIMEOUT];
    [urlRequest setHTTPMethod:@"POST"];
    //[urlRequest setValue:@"text/json" forHTTPHeaderField:@"content-type"];
    [urlRequest setHTTPBody:sendData];
    
    [NSURLConnection sendAsynchronousRequest:urlRequest
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
    {
        DLog(@"end request:%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        if ([data length]>0 && !connectionError) {
            if (sucessBlock)
                sucessBlock(data);
        }else
        {
            failBlock(NETWORK_ERROR_INFO);
            DLog(@"net work error=>>>:%@",connectionError?[[connectionError userInfo] description]:NETWORK_ERROR_INFO);
        }
    }];
}


-(void)sendSynchronousWithUrl:(NSString *)url
                         data:(NSData *)sendData
                  sucessBlock:(void (^)(NSData *respondData)) sucessBlock
                    failBlock:(void (^)(NSString *errorMsg)) failBlock
{
    
    NSURL *sendUrl = [NSURL URLWithString:url];
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:sendUrl cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:TIMEOUT];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setValue:@"text/json" forHTTPHeaderField:@"content-type"];
    [urlRequest setHTTPBody:sendData];
    
    NSURLResponse *response;
    NSError *error;
    NSData *data = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&response error:&error];
    if(!error)
    {
        if (sucessBlock)
            sucessBlock(data);
    }else
    {
        if (failBlock)
        {
           failBlock(NETWORK_ERROR_INFO);
           DLog(@"net work error=>>>:%@",error?[[error userInfo] description]:NETWORK_ERROR_INFO);
        }
    }
}

@end
