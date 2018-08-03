//
//  GWSDKAboutUSViewController.m
//  GameWorksSDK
//
//  Created by tinkl on 21/1/15.
//  Copyright (c) 2015年 ___GAMEWORK___. All rights reserved.
//

#import "GWSDKAboutUSViewController.h"
#import "GWUtility.h"
#import "GWObject.h"


@interface GWSDKAboutUSViewController ()

@property (unsafe_unretained, nonatomic) IBOutlet UILabel *label_bg;

@property (weak, nonatomic) IBOutlet UIImageView *imageview_bg2;
@property (weak, nonatomic) IBOutlet UIImageView *imageview_icon1;
@property (weak, nonatomic) IBOutlet UIImageView *imageview_icon2;
@property (weak, nonatomic) IBOutlet UIImageView *imageview_logo;

@end

@implementation GWSDKAboutUSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"关于我们";
    
    UIImage * line = [UIImage imageWithContentsOfFile:[GWUtility getFilePathFromBound:@"chapter_line@2x"]];

    self.imageview_bg2.image = line;
    
    
    self.imageview_icon1.image = [UIImage imageWithContentsOfFile:[GWUtility getFilePathFromBound:@"gwsdk-kefu"]];
     
    self.imageview_icon2.image = [UIImage imageWithContentsOfFile:[GWUtility getFilePathFromBound:@"gwsdk-about-us"]];;
    
    [self border:self.label_bg];
    
    NSString * filePre = @"";
    switch ([GWObject sharedGWObject].GWSDKBundleTYPE) {
        case GWSDKBundleGameworks:
            filePre = @"gamworks";
            break;
        case GWSDKBundleForgame:
            filePre = @"forgame";
            break;
        case GWSDKBundleSkyDream:
            filePre = @"skydream";
            break;
            
        default:
            break;
    }
    
    NSString *logoname =  [NSString stringWithFormat:@"%@_logo",filePre];
    
    self.imageview_logo.image = [UIImage imageWithContentsOfFile:[GWUtility getFilePathFromBound:logoname]];
    // Do any additional setup after loading the view from its nib.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) border:(UIView * )view
{
    view.layer.borderWidth = 1;
    view.layer.cornerRadius = 4.0;
    view.layer.borderColor = [UIColor colorWithRed:29.0/255.0 green:211.0/255.0 blue:4.0/255.0 alpha:1].CGColor;
    view.layer.masksToBounds = YES;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
