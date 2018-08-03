//
//  GWSDKPresentViewController.m
//  GWSDKPresentViewController
//
// 
//  Created by tinkl on 8/1/15.
//  Copyright (c) 2015年 ___GAMEWORK___. All rights reserved.
//

#import "GWSDKNavigationController.h"
#import "GWSDKNavigationBar.h"
#import "GWSDKViewController.h"
#import "GWObject.h"

//#import <POP.h>
#import "GWUtility.h"
#import <QuartzCore/QuartzCore.h>
#import <AvailabilityMacros.h>

#define DefaultSize CGSizeMake(200,250)

@interface GWSDKNavigationController ()
@property (strong,nonatomic) UIView *containerView;
@property (strong,nonatomic) UIView *containerBackgroundView;
@property (strong,nonatomic) UIView *grayBackgroundView;
@property (strong,nonatomic) NSMutableArray *viewControllers;
@property (assign,nonatomic) BOOL animating;
@property (strong,nonatomic) GWSDKViewController *tempCurrentVC;
@property (strong,nonatomic) GWSDKViewController *tempToVC;
//@property (strong,nonatomic) NSMutableArray *navigationBars;

@end

__strong static GWSDKNavigationController *present = nil;

@implementation GWSDKNavigationController

+(instancetype)shareInstance{
   
    return present;
}

-(void)show:(BOOL)isShow animated:(BOOL)animated{
    //把根视图加进去
  
    if(isShow){
        
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window addSubview:self.view];
        
        self.view.hidden = NO;
        if(animated){
            CAKeyframeAnimation *popAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
            popAnimation.duration = 0.4;
            popAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.01f, 0.01f, 1.0f)],
                                    [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0f, 1.0f, 1.0f)],
                                    [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0f, 1.0f, 1.0f)],
                                    [NSValue valueWithCATransform3D:CATransform3DIdentity]];
            popAnimation.keyTimes = @[@0.0f, @0.9f, @0.75f, @1.0f];
            popAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                             [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                             [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
            [self.containerBackgroundView.layer addAnimation:popAnimation forKey:nil];
        }
        
    }else{
//        [self.grayBackgroundView removeFromSuperview];
        if(animated){
            
            ((GWSDKViewController *)self.viewControllers.lastObject).navigationBar.translucent = NO;
            [UIView animateWithDuration:0.2 animations:^{
                self.grayBackgroundView.alpha = 0.3;
                self.containerBackgroundView.alpha = 0.3;
            } completion:^(BOOL finished) {
                [self clear];
                if (self.view) {
                    // here : # message sent to deallocated instance &DHKFSJ
                    [self.view removeFromSuperview];
                }
                present = nil;
            }];
        }else{
            [self clear];
            if (self.view) {
                [self.view removeFromSuperview];
            }
            present = nil;
        }
    }
}
-(void)clear{
    self.rootViewController = nil;
    for (UIViewController *vc in self.childViewControllers) {
        [vc removeFromParentViewController];
    }
    self.viewControllers = nil;
}
-(void)setRootViewController:(GWSDKViewController *)rootViewController{
    if(_rootViewController!=rootViewController && rootViewController!=nil){
        _rootViewController = rootViewController;
        [self.viewControllers removeAllObjects];
        [self.viewControllers addObject:rootViewController];
    }
}
-(id)init{
   
    return [self initWithSize:DefaultSize rootViewController:nil];

}
-(id)initWithSize:(CGSize)size rootViewController:(GWSDKViewController *)viewController{
    
    if(self=[super init]){
        
        self.viewControllers = [NSMutableArray array];
        _size = size;
        
        self.containerBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.size.width, self.size.height)];
        self.containerBackgroundView.backgroundColor = [UIColor clearColor];

        //圆角
        self.containerBackgroundView.layer.cornerRadius = 4.0f;
        self.containerBackgroundView.clipsToBounds = YES;
        
        self.containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 44, size.width, size.height-44)];
        self.containerView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self.containerBackgroundView addSubview:self.containerView];
        
        self.rootViewController = viewController;
        if(self.rootViewController){
            [self.viewControllers addObject:self.rootViewController];
        }
        
        
        present = self;
    }
    return self;
}
-(void)tapHandle{
    if(self.touchSpaceHide){
        [self show:NO animated:YES];
    }
}
-(void)panHandle:(UIPanGestureRecognizer *)gesture{
    if(self.panPopView && self.viewControllers.count>1){
        
        CGPoint loc = [gesture locationInView:self.containerView];
        CGPoint loc2 = [gesture locationInView:gesture.view];
        CGPoint tran = [gesture translationInView:self.containerView];

        CGFloat flag = loc.x-loc2.x;
        if(gesture.state == UIGestureRecognizerStateBegan){
            if(flag>=0){
                self.tempCurrentVC = self.viewControllers.lastObject;
                self.tempToVC = self.viewControllers[self.viewControllers.count-2];
                
               
                [self.containerView addSubview:self.tempToVC.view];
                [self.containerView sendSubviewToBack:self.tempToVC.view];
                self.tempToVC.view.center = CGPointMake(0, self.tempToVC.view.center.y);
                self.tempToVC.view.hidden = NO;
                self.tempToVC.view.center = CGPointMake(self.tempToVC.view.center.x+tran.x*0.5, self.tempToVC.view.center.y);
                self.tempCurrentVC.view.center = CGPointMake(self.tempCurrentVC.view.center.x+tran.x, self.tempCurrentVC.view.center.y);
                
                self.tempToVC.navigationBar.title = self.tempToVC.title;
                self.tempToVC.navigationBar.hidden = NO;
                self.tempToVC.navigationBar.alpha = 0;
            }
            
        }else if(gesture.state == UIGestureRecognizerStateChanged){
            if(flag>0 && flag<self.size.width){
                self.tempToVC.view.center = CGPointMake(self.tempToVC.view.center.x+tran.x*0.5, self.tempToVC.view.center.y);
                self.tempCurrentVC.view.center = CGPointMake(self.tempCurrentVC.view.center.x+tran.x, self.tempCurrentVC.view.center.y);
                CGFloat alpha = self.tempCurrentVC.view.frame.origin.x/self.size.width;
                self.tempToVC.navigationBar.titleAlpha = alpha*1.5;
                self.tempCurrentVC.navigationBar.titleAlpha = 1.0-alpha*1.5;
            }
        }else{
            if(self.tempCurrentVC.view.center.x>=self.size.width){

                [self.tempCurrentVC willMoveToParentViewController:nil];
                [self addChildViewController:self.tempToVC];
                CGFloat duration = (self.size.width-self.tempCurrentVC.view.frame.origin.x)/self.size.width*0.3;
                [UIView animateWithDuration:duration animations:^{
                    self.tempToVC.view.center = CGPointMake(self.size.width/2, self.tempToVC.view.center.y);
                    self.tempCurrentVC.view.frame = CGRectMake(self.size.width, 0, self.size.width, self.containerView.bounds.size.height);
                    self.tempCurrentVC.navigationBar.alpha = 0;
                    self.tempToVC.navigationBar.alpha = 1.0f;
                } completion:^(BOOL finished) {
                    self.tempCurrentVC.navigationBar.hidden = YES;
                    self.tempCurrentVC.navigationBar.alpha = 1.0f;
                    [self.tempCurrentVC.navigationBar clear];
                    [self.tempCurrentVC.navigationBar removeFromSuperview];
                    [self.tempCurrentVC removeFromParentViewController];
                    [self.tempToVC didMoveToParentViewController:self];
                    [self.viewControllers removeLastObject];
                }];
                
            }else{
                CGFloat duration = self.tempCurrentVC.view.frame.origin.x/self.size.width*0.3;
                [UIView animateWithDuration:duration animations:^{
                    self.tempCurrentVC.navigationBar.alpha = 1.0;
//                    [self.containerBackgroundView bringSubviewToFront:self.tempCurrentVC.navigationBar];
                    self.tempCurrentVC.view.center = CGPointMake(self.size.width/2, self.tempCurrentVC.view.center.y);
                } completion:^(BOOL finished) {
                    [self.tempToVC.view removeFromSuperview];
                }];
            }
        }
        
        [gesture setTranslation:CGPointZero inView:self.containerView];
        
    }
    
}
-(void)setSize:(CGSize)size{

    _size = size;
    if(self.containerBackgroundView){
        CGPoint point = self.containerBackgroundView.center;
        self.containerBackgroundView.frame = CGRectMake(0, 0, size.width, size.height);
        self.containerBackgroundView.center = point;
        self.containerView.frame = self.containerBackgroundView.bounds;
        ((GWSDKViewController *)self.viewControllers.lastObject).navigationBar.frame = CGRectMake(0, 0, size.width, 44);
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.frame = [UIScreen mainScreen].bounds;
    
    if (NSFoundationVersionNumber <= NSFoundationVersionNumber_iOS_7_1)
    {
        CGRect frameview = self.view.frame;
        if (frameview.size.width > frameview.size.height ) {
            frameview.size.height = frameview.size.width;
        }else
        {
            frameview.size.width = frameview.size.height;
        }
        self.view.frame = frameview;
        
    }
    
    self.view.backgroundColor = [UIColor clearColor];
    UIView *backgroundView = [[UIView alloc] initWithFrame:self.view.frame];
    backgroundView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
    [self.view addSubview:backgroundView];
    self.grayBackgroundView = backgroundView;
    
    /*!
     MARK这里处理点击透明区域dismiss当前viewcontroller
     */
    //UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHandle)];
    //[backgroundView addGestureRecognizer:tap];

    self.containerBackgroundView.center = self.view.center;
    [self.view addSubview:self.containerBackgroundView];
    
    if(self.rootViewController){
       
        [self addChildViewController:self.rootViewController];
        [self.containerView addSubview:self.rootViewController.view];
        self.rootViewController.view.frame = self.containerView.bounds;
        [self.rootViewController didMoveToParentViewController:self];
        self.rootViewController.navigationBar.title = self.rootViewController.title;
        
        self.rootViewController.navigationBar.frame = CGRectMake(0, 0, self.size.width, 44);
        self.rootViewController.navigationBar.hidden = NO;
        [self.containerBackgroundView addSubview:self.rootViewController.navigationBar];
        
        
        self.rootViewController.navigationBar.leftTitle = @"关闭";
        __weak typeof(self) weakSelf = self;
        self.rootViewController.navigationBar.leftBlock = ^{
            [weakSelf show:NO animated:YES];
        };
        
    }
    
    
    if (NSFoundationVersionNumber <= NSFoundationVersionNumber_iOS_7_1)
    {
        
        [self positionCurrentView:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self                                              selector:@selector(positionCurrentView:) name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
    }
    
    
}

- (void)positionCurrentView:(NSNotification*)notification {
    
    CGFloat keyboardHeight = 0.0f;
    double animationDuration = 0.0;
    
    
#if !defined(SV_APP_EXTENSIONS)
    UIInterfaceOrientation orientation = UIApplication.sharedApplication.statusBarOrientation;
#else
    UIInterfaceOrientation orientation = CGRectGetWidth(self.view.frame) > CGRectGetHeight(self.view.frame) ? UIInterfaceOrientationLandscapeLeft : UIInterfaceOrientationPortrait;
#endif
    
    
    CGRect orientationFrame = self.view.bounds;
#if !defined(SV_APP_EXTENSIONS)
    CGRect statusBarFrame = UIApplication.sharedApplication.statusBarFrame;
#else
    CGRect statusBarFrame = CGRectZero;
#endif
    
    BOOL ignoreOrientation = NO;
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000
    if ([[NSProcessInfo processInfo] respondsToSelector:@selector(operatingSystemVersion)]) {
        ignoreOrientation = YES;
    }
#endif
    
    if(!ignoreOrientation && UIInterfaceOrientationIsLandscape(orientation)) {
        float temp = CGRectGetWidth(orientationFrame);
        orientationFrame.size.width = CGRectGetHeight(orientationFrame);
        orientationFrame.size.height = temp;
        
        temp = CGRectGetWidth(statusBarFrame);
        statusBarFrame.size.width = CGRectGetHeight(statusBarFrame);
        statusBarFrame.size.height = temp;
    }
    
    CGFloat activeHeight = CGRectGetHeight(orientationFrame);
    
    if(keyboardHeight > 0)
        activeHeight += CGRectGetHeight(statusBarFrame)*2;
    
    activeHeight -= keyboardHeight;
    CGFloat posY = floor(activeHeight*0.45);
    CGFloat posX = CGRectGetWidth(orientationFrame)/2;
    
    CGPoint newCenter;
    CGFloat rotateAngle;
    
    switch (orientation) {
        case UIInterfaceOrientationPortraitUpsideDown:
            rotateAngle = M_PI;
            newCenter = CGPointMake(posX, CGRectGetHeight(orientationFrame)-posY);
            break;
        case UIInterfaceOrientationLandscapeLeft:
            rotateAngle = -M_PI/2.0f;
            newCenter = CGPointMake(posY, posX);
            break;
        case UIInterfaceOrientationLandscapeRight:
            rotateAngle = M_PI/2.0f;
            newCenter = CGPointMake(CGRectGetHeight(orientationFrame)-posY, posX);
            break;
        default: // as UIInterfaceOrientationPortrait
            rotateAngle = 0.0;
            newCenter = CGPointMake(posX, posY);
            break;
    }
    
    if(notification) {
        [UIView animateWithDuration:animationDuration
                              delay:0
                            options:UIViewAnimationOptionAllowUserInteraction
                         animations:^{
                             [self moveToPoint:newCenter rotateAngle:rotateAngle];
                            
                         } completion:NULL];
    } else {
        [self moveToPoint:newCenter rotateAngle:rotateAngle];
       
    }
    
}

- (void)moveToPoint:(CGPoint)newCenter rotateAngle:(CGFloat)angle {
    self.view.transform = CGAffineTransformMakeRotation(angle);
    self.grayBackgroundView.transform = CGAffineTransformMakeRotation(angle);
    UIWindow * windowView = [[UIApplication sharedApplication].windows firstObject];
    UIViewController * rootViewContr =  windowView.rootViewController;
    self.view.center =  rootViewContr.view.center;
    [self.view setNeedsDisplay];
//    [self.containerBackgroundView  setNeedsDisplay];
//    [self.grayBackgroundView  setNeedsDisplay];
    
}




-(void)pushGWSDKViewController:(GWSDKViewController *)viewController animated:(BOOL)animated{
    if(viewController){
        GWSDKViewController *currentViewController = self.viewControllers.lastObject;
        
        GWSDKNavigationBar *currentNavigationBar = currentViewController.navigationBar;
        GWSDKNavigationBar *toNavigationBar = viewController.navigationBar;
        
        [self.viewControllers addObject:viewController];
        [currentViewController willMoveToParentViewController:nil];
        [self addChildViewController:viewController];
        [self.containerView addSubview:viewController.view];
        
        toNavigationBar.frame = currentNavigationBar.frame;
        toNavigationBar.title = viewController.title;
        toNavigationBar.hidden = NO;
        [toNavigationBar setShowBackButtton:YES];
        [self.containerBackgroundView addSubview:toNavigationBar];
        
        //添加滑动手势
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panHandle:)];
        [viewController.view addGestureRecognizer:pan];
        viewController.view.userInteractionEnabled = YES;
        
        if(animated){
            self.animating = YES;
            toNavigationBar.alpha = 0.0f;
            viewController.view.frame = CGRectMake(self.size.width, 0, self.size.width, self.containerView.bounds.size.height);
            [self transitionFromViewController:currentViewController toViewController:viewController duration:0.2 options:UIViewAnimationOptionCurveLinear animations:^{
                toNavigationBar.alpha = 1.0f;
                currentNavigationBar.alpha = 0.0f;
                viewController.view.frame = self.containerView.bounds;
                currentViewController.view.frame = CGRectMake(-self.size.width/2, 0, self.size.width, self.containerView.bounds.size.height);
            } completion:^(BOOL finished){
                if(finished){
                    
                    currentNavigationBar.hidden = YES;
                    currentNavigationBar.alpha = 1.0f;
                    [viewController didMoveToParentViewController:self];
                    [currentViewController removeFromParentViewController];
                    self.animating = NO;
                }
            }];

        }else{
            viewController.view.frame = self.containerView.bounds;
            currentNavigationBar.hidden = YES;
            [viewController didMoveToParentViewController:self];
            [currentViewController removeFromParentViewController];
            
        }
    }
}
-(void)popGWSDKViewControllerAnimated:(BOOL)animated{
    
    if(self.viewControllers.count>1){
  
        GWSDKViewController *currentViewController = self.viewControllers.lastObject;
        GWSDKViewController *toViewController = self.viewControllers[self.viewControllers.count-2];
        
        GWSDKNavigationBar *currentNavigationBar = currentViewController.navigationBar;
        GWSDKNavigationBar *toNavigationBar = toViewController.navigationBar;
        
        [currentViewController willMoveToParentViewController:nil];
        [self addChildViewController:toViewController];
        [self.containerView addSubview:toViewController.view];
        toViewController.view.frame = CGRectMake(self.size.width/2, 0, self.size.width, self.containerView.bounds.size.height);
        [self.containerView sendSubviewToBack:toViewController.view];
        
        toNavigationBar.title = toViewController.title;
        toNavigationBar.hidden = NO;
        
        
        if(animated){
            
            self.animating = YES;
            toNavigationBar.alpha = 0.0f;
            toViewController.view.frame = CGRectMake(-self.size.width/2, 0, self.size.width, self.containerView.bounds.size.height);
            [self transitionFromViewController:currentViewController toViewController:toViewController duration:0.2 options:UIViewAnimationOptionCurveLinear animations:^{
                toNavigationBar.alpha = 1.0f;
                currentNavigationBar.alpha = 0.0f;
                toViewController.view.frame = self.containerView.bounds;
                currentViewController.view.frame = CGRectMake(self.size.width, 0, self.size.width, self.containerView.bounds.size.height);
                
            } completion:^(BOOL finished) {
                if(finished){
                  
                    currentNavigationBar.hidden = YES;
                    currentNavigationBar.alpha = 1.0f;
                    [currentNavigationBar clear];
                    [currentNavigationBar removeFromSuperview];
                    [currentViewController removeFromParentViewController];
                    [toViewController didMoveToParentViewController:self];
                    [self.viewControllers removeLastObject];
                    self.animating = NO;
                }
            }];
        }else{
            
            currentNavigationBar.hidden = YES;
            [currentNavigationBar clear];
            [currentNavigationBar removeFromSuperview];
            [currentViewController removeFromParentViewController];
            [toViewController didMoveToParentViewController:self];
            [self.viewControllers removeLastObject];
        }
    }
    
}


/*

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    
    
    GWRotateMode  GWROTATEMODE = [GWObject sharedGWObject].GWROTATEMODE;
    
    switch (GWROTATEMODE) {
        case GWRotateModeLandscapeAuto:
            return  (interfaceOrientation == UIDeviceOrientationLandscapeLeft || interfaceOrientation == UIDeviceOrientationLandscapeRight);
            break;
        case GWRotateModePortraitAuto:
            return  (interfaceOrientation == UIDeviceOrientationPortrait || interfaceOrientation == UIDeviceOrientationPortraitUpsideDown);
            break;
        case GWRotateModeLandscapeRight:
            return  (interfaceOrientation == UIDeviceOrientationLandscapeRight);
            break;
        case GWRotateModeLandscapeLeft:
            return  (interfaceOrientation == UIDeviceOrientationLandscapeLeft);
            break;
        case GWRotateModePortrait:
            return  (interfaceOrientation == UIDeviceOrientationPortrait);
            break;
        case GWRotateModePortraitUpsideDown:
            return  (interfaceOrientation == UIDeviceOrientationPortraitUpsideDown);
            break;
        default:
            break;
    }
    
    return (interfaceOrientation == UIInterfaceOrientationUnknown);
    
    
}



- (NSUInteger)supportedInterfaceOrientations
{
    GWRotateMode  GWROTATEMODE = [GWObject sharedGWObject].GWROTATEMODE;
    
    switch (GWROTATEMODE) {
        case GWRotateModeLandscapeAuto:
                return  UIInterfaceOrientationMaskLandscape;
            break;
        case GWRotateModePortraitAuto:
                return  UIInterfaceOrientationMaskPortrait;
            break;
        case GWRotateModeLandscapeRight:
                return  UIInterfaceOrientationMaskLandscapeRight;
            break;
        case GWRotateModeLandscapeLeft:
                return  UIInterfaceOrientationMaskLandscapeLeft;
            break;
        case GWRotateModePortrait:
                return  UIInterfaceOrientationMaskPortrait;
            break;
        case GWRotateModePortraitUpsideDown:
                return  UIInterfaceOrientationMaskPortraitUpsideDown;
            break;
        default:
            break;
    }
    
    return UIInterfaceOrientationMaskAll;
}
*/

// 是否支持转屏
- (BOOL)shouldAutorotate
{
    return YES;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

// 支持的屏幕方向，此处可直接返回 UIInterfaceOrientationMask 类型
// 也可以返回多个 UIInterfaceOrientationMask 取或运算后的值
- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
