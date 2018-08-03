//
//  GWSDKPayMent.m
//  GameWorksSDK
//
//  Created by tinkl on 15/1/15.
//  Copyright (c) 2015年 ___GAMEWORK___. All rights reserved.
//

#import "GWSDKPayMent.h"

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

@implementation GWSDKPayMent

+ (void) requestIAPDataInBackgroundBlock:(PFArrayResultBlock)block
                                   block:(GWIdResultBlock)gameblock
{
    /*!
     *  1.处理游戏信息请求
     2.获取游戏支付方式
     3.view处添加订单
     */
    [[GWNetEngine sharedGWNetEngine] postRequestWithParameters:[NSMutableDictionary dictionaryWithDictionary:@{@"gameid":@"0"}] Action:@"game/info" success:^(id object, NSError *error) {
        
        NSString * gameid = [object valueForKey:@"gameid"];
        
        [[GWNetEngine sharedGWNetEngine] postRequestWithParameters:[NSMutableDictionary dictionaryWithDictionary:@{@"gameid":gameid}] Action:@"order/payment" success:^(id object, NSError *error) {
            NSArray * pmModelArrays = [GWSDKPayMentModel arrayOfModelsFromDictionaries:[object valueForKey:@"list"]];
            if (pmModelArrays && pmModelArrays.count > 0) {
                block(pmModelArrays,nil);
                
                GWSDKPayGameINFO * gameinfo =[[GWSDKPayGameINFO alloc] initWithDictionary:object error:nil];
                gameblock(gameinfo,nil);
            }else{
                block(@[],nil);
                gameblock(nil,nil);
            }
        } error:^(NSInteger number, NSError *error) {
            block(nil,error);
        }];
    } error:^(NSInteger number, NSError *error) {
         block(nil,error);
         gameblock(nil,nil);
    }];
}

+ (void) requestOrderAddInBackground:(NSString *)channelID
                            gameid:(NSString *)gameID
                               block:(PFIdResultBlock)block
{
    [[GWNetEngine sharedGWNetEngine] postRequestWithParameters:[NSMutableDictionary dictionaryWithDictionary:@{@"payid":gameID,@"channelid":channelID}] Action:@"order/add" success:^(id object, NSError *error) {
        GWSDKOrderModel *model = [[GWSDKOrderModel alloc] initWithDictionary:object error:nil];
        if (model) {
            block(model,nil);
        }else{
            model = [[GWSDKOrderModel alloc] init];
            block(model,nil);
        }
    } error:^(NSInteger number, NSError *error) {
         block(nil,error);
    }];
}

+ (void) requestOrderAddInBackground:(NSDictionary *)ordermodel
                               block:(PFIdResultBlock)block
{
    NSMutableDictionary * newOrderModel = [NSMutableDictionary dictionaryWithDictionary:ordermodel];
    if (ordermodel) {
        NSString * mail =  newOrderModel[@"mail"];
        if (![GWUtility isValidateEmail:mail]) {
            newOrderModel[@"mail"] = @"";
        }
    }
    [[GWNetEngine sharedGWNetEngine] postRequestWithParameters:newOrderModel Action:@"order/submit" success:^(id object, NSError *error) {
        block(object,nil);
    } error:^(NSInteger number, NSError *error) {
        block(nil,error);
    }];
}

+ (void) requestOrderThirdInBackground:(NSString *)orderid
                                 block:(PFIdResultBlock)block
{
    [[GWNetEngine sharedGWNetEngine] postRequestWithParameters:[NSMutableDictionary dictionaryWithDictionary:@{@"orderid":orderid}] Action:@"order/third" success:^(id object, NSError *error) {
        block(object,nil);
    } error:^(NSInteger number, NSError *error) {
        block(nil,error);
    }];
}

+ (void) requestOrderResultInBackground:(NSString *)orderid
                                  block:(PFIdResultBlock)block
{
    [[GWNetEngine sharedGWNetEngine] postRequestWithParameters:[NSMutableDictionary dictionaryWithDictionary:@{@"orderid":orderid}] Action:@"order/result" success:^(id object, NSError *error) {
        
        block(object,nil);
        
    } error:^(NSInteger number, NSError *error) {
        block(nil,error);
    }];
}

//提示
+ (void) showNotifyToast:(NSString * ) toast
{
    UIWindow *window = [[UIApplication sharedApplication].windows firstObject];
    UIView * view = window.rootViewController.view;
    
    UIImageView *_barView = (UIImageView *)[view viewWithTag:101];
    if (_barView == nil) {
        //ass_tb_bg_left@2x   timeline_new_status_background
        UIImage *img = [[UIImage imageNamed:[GWUtility getFilePathFromBound:@"ass_tb_bg_left@2x"]] stretchableImageWithLeftCapWidth:5 topCapHeight:5];
        _barView = [[UIImageView alloc] initWithImage:img];
        _barView.backgroundColor = [UIColor colorWithRed:29/255.0 green:211/255.0 blue:4/255.0 alpha:1.0];
        {
            CGRect frame = _barView.frame;
            frame.size.width = 280;//view.frame.size.width * .8;
            frame.size.height = 50;//view.frame.size.width * .8;
            _barView.frame = frame;
        }
        
        _barView.tag = 101;
        [view addSubview:_barView];
        [GWUtility printSystemLog:[NSString stringWithFormat:@"%@  ------ %@  ------",_barView,view]];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
        label.tag = 100;
        label.font = [UIFont systemFontOfSize:16.0f];
        label.textColor = [UIColor whiteColor];
        label.backgroundColor = [UIColor clearColor];
        [_barView addSubview:label];
    }
    
    if (NSFoundationVersionNumber <= NSFoundationVersionNumber_iOS_7_1)
    {
        CGSize sizeFix = [GWUtility fixedScreenSize]; // 兼容ios6 ios7 ios8
        CGRect frame = _barView.frame;
        frame.origin.x = (sizeFix.width - 280.0)/2;
        _barView.frame = frame;
        
    }else{
        _barView.center = view.center;
    }
    {
        CGRect frame = _barView.frame;
        frame.origin.y = -300;
        _barView.frame = frame;
    }
    
    UILabel *label = (UILabel *)[_barView viewWithTag:100];
    label.text = toast;
    [label sizeToFit];
    CGRect frame = label.frame;
    frame.origin = CGPointMake((_barView.frame.size.width - frame.size.width)/2, (_barView.frame.size.height - frame.size.height)/2);
    label.frame = frame;
    _barView.hidden = NO;
//    http://www.csdn.net/article/2014-06-17/2820265-git
    
    [self performSelector:@selector(updateUI) withObject:nil afterDelay:.5];    
}

+ (void)updateUI {
    UIWindow *window = [[UIApplication sharedApplication].windows firstObject];
    UIView * _barView =  [window.rootViewController.view viewWithTag:101];
    
    [UIView animateWithDuration:0.8 animations:^{
        CGRect frame = _barView.frame;
        frame.origin.y = 0;
        _barView.frame = frame;
    } completion:^(BOOL finished){
        if (finished) {
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDelay:2.0];
            [UIView setAnimationDuration:0.6];
            CGRect frame = _barView.frame;
            frame.origin.y = -300;
            _barView.frame = frame;
//            _barView.hidden = YES;
            [UIView commitAnimations];
        }
    }];
}


+(void)requestGameIdInBackgroundblock:(PFIdResultBlock)gameblock
{

    [[GWNetEngine sharedGWNetEngine] postRequestWithParameters:[NSMutableDictionary dictionaryWithDictionary:@{@"gameid":@"0"}] Action:@"game/info" success:^(id object, NSError *error) {
        NSString * gameid = [GWUtility stringSafeOperation:[object valueForKey:@"gameid"]];
        if (gameid.length > 0) {
            gameblock(gameid,nil);
        }else
        {
            gameblock(nil,nil);
        }
    } error:^(NSInteger number, NSError *error) {
        gameblock(nil,nil);
    }];
    
}

+ (void)requestPayHistoryInBackground:(NSInteger) startid
                           gameid:(NSInteger) gameid
                            block:(PFArrayResultBlock)successResultBlock
{
    [[GWNetEngine sharedGWNetEngine] postRequestWithParameters:[NSMutableDictionary dictionaryWithDictionary:@{@"gameid":@(gameid),@"count":@10,@"startid":@(startid),@"type":@1}] Action:@"order/history" success:^(id object, NSError *error) {
        NSArray * pmModelArrays = [GWSDKPayHistoryGameINFO arrayOfModelsFromDictionaries:[object valueForKey:@"list"]];
        if (pmModelArrays && pmModelArrays.count > 0) {
            successResultBlock(pmModelArrays,nil);
        }else{
            successResultBlock(@[],nil);
        }
    } error:^(NSInteger number, NSError *error) {
        successResultBlock(nil,error);
    }];
    
}



@end
