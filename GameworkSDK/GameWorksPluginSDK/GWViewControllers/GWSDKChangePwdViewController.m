//
//  GWSDKChangePwdViewController.m
//  GameWorksSDK
//
//  Created by tinkl on 21/1/15.
//  Copyright (c) 2015年 ___GAMEWORK___. All rights reserved.
//

#import "GWSDKChangePwdViewController.h"

#import "UIButton+Bootstrap.h"
#import "GWUser.h"
#import "SVProgressHUD.h"
#import "GWUtility.h"

@interface GWSDKChangePwdViewController ()
@property (unsafe_unretained, nonatomic) IBOutlet UITextField *Txt_currentPwd;
@property (unsafe_unretained, nonatomic) IBOutlet UITextField *Txt_newPwd;
@property (unsafe_unretained, nonatomic) IBOutlet UITextField *Txt_newsurePwd;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *button_change;
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *image_line;
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *image_line1;
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *image_line2;
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *image_line3;

@end

@implementation GWSDKChangePwdViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"修改密码";
    
    UIImage * line = [UIImage imageWithContentsOfFile:[GWUtility  getFilePathFromBound:@"chapter_line@2x"]];
    
    self.image_line.image = line;
    self.image_line1.image = line;
    self.image_line2.image = line;
    self.image_line3.image = line;
    
    [self.button_change infoStyle];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)change_action:(id)sender {
    
    if (self.Txt_currentPwd.text.length == 0) {
        [SVProgressHUD showInfoWithStatus:@"当前密码不能为空"];
        return;
    }
    
    if (self.Txt_newPwd.text.length == 0) {
        [SVProgressHUD showInfoWithStatus:@"新密码不能为空"];
        return;
    }
    
    if (self.Txt_newsurePwd.text.length == 0) {
        [SVProgressHUD showInfoWithStatus:@"确认密码不能为空"];
        return;
    }
    
    
    
    if (![self.Txt_newsurePwd.text isEqualToString:self.Txt_newPwd.text]) {
        [SVProgressHUD showInfoWithStatus:@"两次密码输入不一致"];
        return;
    }     
    
    [SVProgressHUD showWithStatus:@"修改中" maskType:(SVProgressHUDMaskTypeBlack)];
    [GWUser requestPasswordResetForPasswordInBackground:self.Txt_currentPwd.text newpwd:self.Txt_newsurePwd.text block:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            //这里默认登录处理
            [SVProgressHUD dismiss];
            [self.gwSDKNavigationController popGWSDKViewControllerAnimated:YES];
        }else{
            NSString * errorDes = [[error userInfo] valueForKey:NSLocalizedDescriptionKey];
            [SVProgressHUD showErrorWithStatus:errorDes];
        }
    }];
    
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField              // called when 'return' key pressed. return NO to ignore.
{
    [textField resignFirstResponder];
    
    return YES;
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
