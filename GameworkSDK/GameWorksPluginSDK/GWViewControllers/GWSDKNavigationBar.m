//
//  GWSDKNavigationBar.m
//  GWSDKPresentViewController
//
// 
//  Created by tinkl on 8/1/15.
//  Copyright (c) 2015年 ___GAMEWORK___. All rights reserved.
//

#import "GWSDKNavigationBar.h"
#import "GWSDKViewController.h"
#import "UIColor+iOS7Colors.h"
#import "GWUtility.h"
@interface GWSDKNavigationBar()
@property (nonatomic,strong) UIBarButtonItem *leftItem;
@property (nonatomic,strong) UIBarButtonItem *rightItem;
@property (nonatomic,strong) UIBarButtonItem *titleItem;
@property (nonatomic,strong) UIButton        *backbutton;
@property (nonatomic,strong) UIButton        *closebutton;
@property (nonatomic,strong) UILabel            *titleLabel;
@property (nonatomic,strong) UIImageView        *customImage;

//@property (nonatomic,strong) UILabel *leftLabel;
//@property (nonatomic,strong) UILabel *rightLabel;
@end
@implementation GWSDKNavigationBar


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
 
//        UIBarButtonItem *flexible = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
//
//        self.leftItem = [[UIBarButtonItem alloc] initWithTitle:@"    " style:UIBarButtonItemStyleBordered target:self action:@selector(leftClick)];
//        self.rightItem = [[UIBarButtonItem alloc] initWithTitle:@"    " style:UIBarButtonItemStyleBordered target:self action:@selector(rightClick)];
//        self.titleItem = [[UIBarButtonItem alloc] initWithTitle:@"        " style:UIBarButtonItemStyleBordered target:nil action:nil];
//        NSArray *items = @[self.leftItem,flexible,flexible,self.rightItem];
//        NSArray *items = @[self.leftItem,self.rightItem];
//        self.items = items;
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
//        self.titleLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithContentsOfFile:[GWUtility getFilePathFromBound:@"ass_tb_bg_right@2x"]]];
        
        self.titleLabel.backgroundColor = [UIColor colorWithRed:29/255.0 green:211/255.0 blue:4/255.0 alpha:1];
        
        //[UIColor iOS7greenColor];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.text = @"";
        [self addSubview:self.titleLabel];
        
        
        self.opaque = NO;
        self.backgroundColor = [UIColor clearColor];  //设置为背景透明，可以在这里设置背景图片
        //self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]];
        self.clearsContextBeforeDrawing = YES;
                  
//        self.translucent = YES;
    
    }
    return self;
}
-(void)clear{
    self.leftBlock = nil;
    self.rightTitle = nil;
    self.leftTitle = nil;
    self.rightBlock = nil;
    self.title = nil;
    self.backbutton = nil;
    self.closebutton = nil;
}

-(void)setShowBackButtton:(BOOL) show
{
    if (show) {
        self.backbutton = [UIButton buttonWithType:UIButtonTypeCustom];
        //32 60
        self.backbutton.frame = CGRectMake(10, 10, 60, 32);
        [self.backbutton addTarget:self action:@selector(leftClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.backbutton];
        [self.backbutton setImage:[UIImage imageWithContentsOfFile:[GWUtility getFilePathFromBound:@"toolbar_back_hl@2x"]] forState:UIControlStateNormal];
        [self.backbutton setImage:[UIImage imageWithContentsOfFile:[GWUtility getFilePathFromBound:@"toolbar_back@2x"]] forState:UIControlStateHighlighted];

    }else{
        [self.backbutton removeFromSuperview];
    }
}

-(void)setShowCloseButtton:(BOOL) show
{
    if (show) {
        self.closebutton = [UIButton buttonWithType:UIButtonTypeCustom];
        //32 60
        self.closebutton.frame = CGRectMake(10, 10, 30, 30);
        [self.closebutton addTarget:self action:@selector(leftClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.closebutton];
        [self.closebutton setImage:[UIImage imageWithContentsOfFile:[GWUtility getFilePathFromBound:@"close_cameraview@2x"]] forState:UIControlStateNormal];
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.titleLabel.frame = self.bounds;
    self.backbutton.frame = CGRectMake(10, 10, 60, 32);
    self.closebutton.frame = CGRectMake(10, 10, 30, 30);
}
-(void)leftClick{
    if(self.leftBlock){
        self.leftBlock();
    }
}
-(void)rightClick{
    if(self.rightBlock){
        self.rightBlock();
    }
}
-(void)setTitle:(NSString *)title{
    if(title!=_title){
        _title = title;
        self.titleLabel.text = title;
    }
}

-(void)setLeftTitle:(NSString *)leftTitle{
    if(leftTitle!=_leftTitle){
        _leftTitle = leftTitle;
        self.leftItem.title = leftTitle;
    }
}

-(void)setRightTitle:(NSString *)rightTitle{
    if(rightTitle!=_rightTitle){
        _rightTitle = rightTitle;
        self.rightItem.title = rightTitle;
    }
}
-(void)setTitleAlpha:(CGFloat)titleAlpha{
    if(titleAlpha<0){
        self.alpha = 0;
    }else if(titleAlpha>1){
        self.alpha = 1.0f;
    }else{
        self.alpha = titleAlpha;
    }
}

- (void)drawRect:(CGRect)rect {
    // do nothing
}

-(CGFloat)titleAlpha{
    return self.alpha;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
