//
//  Created by tinkl on 8/1/15.
//  Copyright (c) 2015年 ___GAMEWORK___. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GWSDKBannerMenuView;

@protocol GWSDKBannerMenuViewDelegate <NSObject>

@required

- (NSInteger)bannerMenuView:(GWSDKBannerMenuView *)bannerMenuView;

- (UIView *)bannerMenuView:(GWSDKBannerMenuView *)bannerMenuView menuForRowAtIndexPath:(NSUInteger)index;

@optional

- (void)bannerMenuView:(GWSDKBannerMenuView *)bannerMenuView didSelectRowAtIndexPath:(NSUInteger)index;

@end

typedef void (^SelectBlock) (NSUInteger index);

@interface GWSDKBannerMenuView : UIView

@property (nonatomic, assign) id<GWSDKBannerMenuViewDelegate> delegate;

/*
 *frame设置浮标位置及长宽
 *nWidth设置展出后增加的菜单宽带，可以动态计算传值
 */
- (id)initWithFrame:(CGRect)frame menuWidth:(float)nWidth;
/**
 *  定制按钮菜单及回调block事件
 */
- (id)initWithFrame:(CGRect)frame menuWidth:(float)nWidth buttonTitle:(NSArray *)arButtonTitle withBlock:(SelectBlock) block;
/**
 通用方式，拥有类似UITableView的回调实现
 */
- (id)initWithFrame:(CGRect)frame menuWidth:(float)nWidth delegate:(id<GWSDKBannerMenuViewDelegate>)delegate;

@end
