//
//  GWResultToken.m
//  GameWorksSDK
//
//  Created by zhangzhongming on 14/11/19.
//  Copyright (c) 2014年 游戏工场. All rights reserved.
//

#import "GWResultToken.h"
#import "GWCommonUtility.h"

#define ASK_TOKEN    @"token"
#define ASK_CP       @"cp"
#define ASK_GUDI     @"guid"
#define ASK_ORIGINAL @"original"


@implementation GWResultToken

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        if (dictionary) {
            if (dictionary[ASK_TOKEN] && [dictionary[ASK_TOKEN] isKindOfClass:[NSString class]])
                self.token = dictionary[ASK_TOKEN];
            if (dictionary[ASK_CP] && [dictionary[ASK_CP] isKindOfClass:[NSString class]])
                self.cp = dictionary[ASK_CP];
            if (dictionary[ASK_GUDI] && [dictionary[ASK_GUDI] isKindOfClass:[NSString class]])
                self.guid = dictionary[ASK_GUDI];
            if (dictionary[ASK_ORIGINAL] && [dictionary[ASK_ORIGINAL] isKindOfClass:[NSString class]])
                self.original = [NSString decodeBase64String:dictionary[ASK_ORIGINAL]];//base64解码
        }
    }
    return self;
}

@end
