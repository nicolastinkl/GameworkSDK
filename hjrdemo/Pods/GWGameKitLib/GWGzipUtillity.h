//
//  GWGzipUtillity.h
//  GWGzipUtillity
//
//  Created by zhangzhongming on 14/11/18.
//  Copyright (c) 2014年 游戏工场. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "zlib.h"

@interface GWGzipUtillity : NSObject

+ (NSData *)gzipData:(NSData *)pUncompressedData;
+ (NSData *)uncompressZippedData:(NSData *)compressedData;
@end
