//
//  GameKitConfigure.m
//  GameKit
//
//  Created by zhangzhongming on 14/11/25.
//  Copyright (c) 2014年 游戏工场. All rights reserved.
//

#import "GameKitConfigure.h"


@implementation GameKitConfigure

- (NSString *)descGameKitConfigure
{
    NSMutableString *desc = [NSMutableString new];

    [desc appendFormat:@"sessionId:%@\n",_sessionId];
    [desc appendFormat:@"PTGameKey:%@\n",_PTGameKey];
    [desc appendFormat:@"PTGameChannel:%@\n",_PTGameChannel];
    
    [desc appendFormat:@"CPName:%@\n",_CPName];
    [desc appendFormat:@"CPVersion:%@\n",_CPVersion];
    [desc appendFormat:@"CPAppID:%@\n",_CPAppID];
    [desc appendFormat:@"CPAppKey:%@\n",_CPAppKey];
    [desc appendFormat:@"CPGameKey:%@\n",_CPGameKey];
    [desc appendFormat:@"CPGameChannel:%@\n",_CPGameChannel];
    [desc appendFormat:@"CPPrivateKey:%@\n",_CPPrivateKey];
    [desc appendFormat:@"CPServerNo:%@\n",_CPServerNo];
    [desc appendFormat:@"CPAutoLogin:%@\n",_CPAutoLogin?@"yes":@"no"];
    [desc appendFormat:@"CPForceLogin:%@\n",_CPForceLogin?@"yes":@"no"];
    [desc appendFormat:@"CPForceUpdate:%@\n",_CPForceUpdate?@"yes":@"no"];
    
    [desc appendFormat:@"DEV_ISDebugModel:%@\n",_DEV_ISDebugModel?@"debug":@"release"];
    [desc appendFormat:@"DEV_ShowFloatWindowOrBar:%@\n",_DEV_ShowFloatWindowOrBar?@"show":@"hidden"];
    [desc appendFormat:@"DEV_FloatWindowOrBarScreenPlace:%d\n",(int)_DEV_FloatWindowOrBarScreenPlace];
    [desc appendFormat:@"DEV_SupportScreenOrientation:%@\n",self.DEV_SupportScreenOrientation];
    
    [desc appendFormat:@"PAY_DefaultPayAmount:%@\n",_PAY_DefaultPayAmount];
    [desc appendFormat:@"PAY_ShopingPrivateInfo:%@\n",_PAY_ShopingPrivateInfo];
    [desc appendFormat:@"PAY_PayNotifyUrl:%@\n",_PAY_PayNotifyUrl];
    [desc appendFormat:@"PAY_AlipayScheme:%@\n",_PAY_AlipayScheme];
    [desc appendFormat:@"PAY_MerchantId:%@\n",_PAY_MerchantId];
    [desc appendFormat:@"PAY_AppScheme:%@\n",_PAY_AppScheme];
    [desc appendFormat:@"DATA_Product:%@\n",_DATA_Product];
    
    return desc;
}


-(void)encodeWithCoder:(NSCoder*)coder{
    
    [coder encodeObject:self.PTGameKey forKey:@"PTGameKey"];
    [coder encodeObject:self.PTGameChannel forKey:@"PTGameChannel"];
    
    [coder encodeObject:self.CPName forKey:@"CPName"];
    [coder encodeObject:self.CPVersion forKey:@"CPVersion"];
    [coder encodeObject:self.CPAppID forKey:@"CPAppID"];
    [coder encodeObject:self.CPAppKey forKey:@"CPAppKey"];
    [coder encodeObject:self.CPGameKey forKey:@"CPGameKey"];
    [coder encodeObject:self.CPGameChannel forKey:@"CPGameChannel"];
    [coder encodeObject:self.CPPrivateKey forKey:@"CPPrivateKey"];
    [coder encodeObject:self.CPServerNo forKey:@"CPServerNo"];
    [coder encodeBool  :self.CPAutoLogin forKey:@"CPAutoLogin"];
    [coder encodeBool  :self.CPForceLogin forKey:@"CPForceLogin"];
    [coder encodeBool  :self.CPForceUpdate forKey:@"CPForceUpdate"];
    
    [coder encodeBool:self.DEV_ISDebugModel forKey:@"DEV_ISDebugModel"];
    [coder encodeBool:self.DEV_ShowFloatWindowOrBar forKey:@"DEV_ShowFloatWindowOrBar"];
    [coder encodeInt:self.DEV_FloatWindowOrBarScreenPlace forKey:@"DEV_FloatWindowOrBarScreenPlace"];
    [coder encodeObject:self.DEV_SupportScreenOrientation forKey:@"DEV_SupportScreenOrientation"];
    
    [coder encodeObject:self.PAY_DefaultPayAmount forKey:@"PAY_DefaultPayAmount"];
    [coder encodeObject:self.PAY_ShopingPrivateInfo forKey:@"PAY_ShopingPrivateInfo"];
    [coder encodeObject:self.PAY_PayNotifyUrl forKey:@"PAY_PayNotifyUrl"];
    [coder encodeObject:self.PAY_AlipayScheme forKey:@"PAY_AlipayScheme"];
    [coder encodeObject:self.PAY_MerchantId forKey:@"PAY_MerchantId"];
    [coder encodeObject:self.PAY_AppScheme forKey:@"PAY_AppScheme"];
    [coder encodeObject:self.sessionId forKey:@"sessionId"];
    [coder encodeObject:self.DATA_Product forKey:@"DATA_Product"];
}

-(id)initWithCoder:(NSCoder *)coder{
    
    if(self=[super init]){
        
        self.PTGameKey=[coder decodeObjectForKey:@"PTGameKey"];
        self.PTGameChannel=[coder decodeObjectForKey:@"PTGameChannel"];
        
        self.CPName=[coder decodeObjectForKey:@"CPName"];
        self.CPVersion=[coder decodeObjectForKey:@"CPVersion"];
        self.CPAppID=[coder decodeObjectForKey:@"CPAppID"];
        self.CPAppKey=[coder decodeObjectForKey:@"CPAppKey"];
        self.CPGameKey = [coder decodeObjectForKey:@"CPGameKey"];
        self.CPGameChannel = [coder decodeObjectForKey:@"CPGameChannel"];
        self.CPPrivateKey = [coder decodeObjectForKey:@"CPPrivateKey"];
        self.CPServerNo =  [coder decodeObjectForKey:@"CPServerNo"];
        self.CPAutoLogin = [coder decodeBoolForKey:@"CPAutoLogin"];
        self.CPForceLogin = [coder decodeBoolForKey:@"CPForceLogin"];
        self.CPForceUpdate = [coder decodeBoolForKey:@"CPForceUpdate"];
        
        self.DEV_ISDebugModel = [coder decodeBoolForKey:@"DEV_ISDebugModel"];
        self.DEV_ShowFloatWindowOrBar = [coder decodeBoolForKey:@"DEV_ShowFloatWindowOrBar"];
        self.DEV_FloatWindowOrBarScreenPlace = [coder decodeIntegerForKey:@"DEV_FloatWindowOrBarScreenPlace"];
        self.DEV_SupportScreenOrientation = [coder decodeObjectForKey:@"DEV_SupportScreenOrientation"];
        
        self.PAY_DefaultPayAmount = [coder decodeObjectForKey:@"PAY_DefaultPayAmount"];
        self.PAY_ShopingPrivateInfo = [coder decodeObjectForKey:@"PAY_ShopingPrivateInfo"];
        self.PAY_AlipayScheme = [coder decodeObjectForKey:@"PAY_AlipayScheme"];
        self.PAY_PayNotifyUrl = [coder decodeObjectForKey:@"PAY_PayNotifyUrl"];
        self.PAY_MerchantId = [coder decodeObjectForKey:@"PAY_MerchantId"];
        self.PAY_AppScheme = [coder decodeObjectForKey:@"PAY_AppScheme"];
        self.sessionId = [coder decodeObjectForKey:@"sessionId"];
        self.DATA_Product = [coder decodeObjectForKey:@"DATA_Product"];
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone
{
    id copy = [[[self class] alloc] init];
    
    if (copy)
    {
        [copy setPTGameKey:[self.PTGameKey copyWithZone:zone]];
        [copy setPTGameChannel:[self.PTGameChannel copyWithZone:zone]];
        
        [copy setCPName:[self.CPName copyWithZone:zone]];
        [copy setCPVersion:[self.CPVersion copyWithZone:zone]];
        [copy setCPAppID:[self.CPAppID copyWithZone:zone]];
        [copy setCPAppKey:[self.CPAppKey copyWithZone:zone]];
        [copy setCPGameKey:[self.CPGameKey copyWithZone:zone]];
        [copy setCPGameChannel:[self.CPGameChannel copyWithZone:zone]];
        [copy setCPPrivateKey:[self.CPPrivateKey copyWithZone:zone]];
        [copy setCPServerNo:[self.CPServerNo copyWithZone:zone]];
        [copy setCPAutoLogin:self.CPAutoLogin];
        [copy setCPForceLogin:self.CPForceLogin];
        [copy setCPForceUpdate:self.CPForceUpdate];
        
        [copy setDEV_ISDebugModel:self.DEV_ISDebugModel];
        [copy setDEV_ShowFloatWindowOrBar:self.DEV_ShowFloatWindowOrBar];
        [copy setDEV_FloatWindowOrBarScreenPlace:self.DEV_FloatWindowOrBarScreenPlace];
        [copy setDEV_SupportScreenOrientation:self.DEV_SupportScreenOrientation];
        
        [copy setPAY_DefaultPayAmount:[self.PAY_DefaultPayAmount copyWithZone:zone]];
        [copy setPAY_ShopingPrivateInfo:[self.PAY_ShopingPrivateInfo copyWithZone:zone]];
        [copy setPAY_AlipayScheme:[self.PAY_AlipayScheme copyWithZone:zone]];
        [copy setPAY_PayNotifyUrl:[self.PAY_PayNotifyUrl copyWithZone:zone]];
        [copy setPAY_MerchantId:[self.PAY_MerchantId copyWithZone:zone]];
        [copy setPAY_AppScheme:[self.PAY_AppScheme copyWithZone:zone]];
        [copy setSessionId:[self.sessionId copyWithZone:zone]];
        [copy setDATA_Product:[self.DATA_Product copyWithZone:zone]];
        
    }
    
    return copy;
}

@end
