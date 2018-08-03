//
//  GWSDKViewController.m
//  GWSDKPresentViewController
//
// 
//  Created by tinkl on 8/1/15.
//  Copyright (c) 2015年 ___GAMEWORK___. All rights reserved.
//

#import "GWSDKViewController.h"
#import "GWSDKNavigationController.h"

@interface GWSDKViewController ()

@end

@implementation GWSDKViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self prepareNavigationBar];
    }
    return self;
}

-(id)init{
    if(self = [super init]){

        [self prepareNavigationBar];
    }
    return self;
}

-(void)prepareNavigationBar{
    self.navigationBar = [[GWSDKNavigationBar alloc] initWithFrame:CGRectZero];
    self.navigationBar.hidden = YES;
    
//    UIImage *toolBarIMG = [UIImage imageNamed: @"bllw_bar"];
//    
//    if ([self.navigationBar respondsToSelector:@selector(setBackgroundImage:forToolbarPosition:barMetrics:)]) {
////        [self.navigationBar setBackgroundImage:toolBarIMG forToolbarPosition:0 barMetrics:UIBarMetricsDefault];
//    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    NSLog(@"vc viewDidLoad");
    // Do any additional setup after loading the view.
    __weak GWSDKViewController *mySelf = self;
    self.navigationBar.leftBlock = ^{
        [mySelf.gwSDKNavigationController popGWSDKViewControllerAnimated:YES];
    };
}

-(GWSDKNavigationController *)gwSDKNavigationController{
    return [GWSDKNavigationController shareInstance];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

-(void)dealloc
{
    self.view = nil;
}

//-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
//    LOG;
//    if([keyPath isEqualToString:@"title"]){
//        self.navigationBar.title = change[@"new"];
//    }
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
 

@end
