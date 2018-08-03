//
//  define.h
//  GDEMO
//
//  Created by zhangzhongming on 14/11/14.
//  Copyright (c) 2014年 游戏工厂. All rights reserved.
//

#ifndef GDEMO_define_h
#define GDEMO_define_h


#define STRING_NULL        @""               //空字符串
#define MSG_SUCCEED        @"Succeed"        //成功
#define MSG_FAILED         @"Failed"         //失败
#define MSG_CANCLE         @"Cancle"         //取消

//##### inof header ######

#define GW_GAME_KEY        @"gamekey"        //游戏开发者申请的密钥，md5形式
#define GW_DEVICE_TOKEN    @"devicetoken"    //iOS上的devicetoken
#define GW_LANG            @"lang"           //语言
#define GW_VERSION         @"version"        //客户端SDK版本
#define GW_OS              @"os"             //客户端操作系统，ios，android
#define GW_OSVER           @"osver"          //手机OS版本号

#define GW_WLAN            @"wlan"           //wlan物理地址，以“:”分隔
#define GW_NETWORK         @"network"        //网络类型 1 3G 2 wifi 3 2G
#define GW_ROOT            @"root"           //手机是否已经破解/越狱 0 未破解 1 已破解
#define GW_DEVICE          @"device"         //设备类型 0 phone 1 pad 2 touch 3….安卓未定
#define GW_SESSION         @"session"        //登录成功（LOGIN_REPLY）后返回的session
#define GW_ACCEPT          @"accept"         //支持协议编码
#define GW_COOKIE          @"cookie"         //Base64 需要记录的信息以|分隔

#define GW_RESOLUTION      @"resolution"     //分辨率
#define GW_SOURCE          @"source"         //来源平台
#define GW_CP              @"cp"             //第三方平台标识（服务端提供）

//#### GWPayOrder #######

#define GW_AMOUNT          @"amount"         //金额
#define GW_ORDER_NO        @"order_no"       //外部订单号
#define GW_SERVERID        @"serverid"         //服务器ID
#define GW_PID             @"product_id"     //商品ID
#define GW_PNUM            @"product_num"    //商品数量
#define GW_GAME_EXTEND     @"gameextend"     //扩展字段（原样返回,base64传递）
#define GW_NOTIFY_URL      @"notify_url"     //服务器回到url


#define CONFING_ACCEPT_ZIP   0
#define CONFING_IOS_PLANFORM @"9e304d4e8df1b74cfa009913198428ab"

#define BaseUrl            @"http://anyapi.mobile.youxigongchang.com"

#define ValidateTokenUrl   @"oauth/request" // 获取整合平台token
#define PayOrderNoUrl      @"order/submit"  // 获取整合平台订单信息
#define OrderStateUrl      @"order/result"  // 获取订单状态
#define UserInfoValidate   @"user/verify"   // 用户信息验证
#define TouristLogin       @"user/tmpuser"  // 临时用户登录



#define SYSTEMCONFIG_FILE_NAME @"Confingure"
#define SYSTMECONFIG_TAG_NAME  @"confingure"

#endif
