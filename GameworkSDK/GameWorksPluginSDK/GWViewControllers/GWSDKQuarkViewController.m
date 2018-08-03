//
//  GWSDKQuarkViewController.m
//  GameWorksSDK
//
//  Created by tinkl on 14/1/15.
//  Copyright (c) 2015年 ___GAMEWORK___. All rights reserved.
//

#import "GWSDKQuarkViewController.h"
#import "UIButton+Bootstrap.h"
#import "UITableView+DataSourceBlocks.h"
#import "TableViewWithBlock.h"
#import "GWUtility.h"
#import "GWSDKQuarkTableViewCell.h"
#import "GWUICKeyChainStore.h"
#import "GWMacro.h"
#import "GWUser.h"
#import "SVProgressHUD.h"
#import "GWSDKFindPwdViewController.h"

#import "GWSDKRegisterViewController.h"
#import "UIAlertView+GWSDKBlocks.h"
#import "GWSDKLoginViewController.h"

#import <objc/runtime.h>

static NSString *DELETE_BUTTON_ASS_KEY = @"GWSDK.CELL.DELETEBUTTON";


@interface GWSDKQuarkViewController ()<UITextFieldDelegate>
{
    BOOL isOpened;
    NSMutableArray * newArray;
    NSUInteger index;
}

@property (weak, nonatomic) IBOutlet UILabel *label_bg;

@property (weak, nonatomic) IBOutlet UITextField *Txt_inputUserName;
@property (weak, nonatomic) IBOutlet UIButton *Button_exchange;
@property (weak, nonatomic) IBOutlet UIButton *Button_login;
@property (weak, nonatomic) IBOutlet UIButton *Button_signup;
@property (weak, nonatomic) IBOutlet TableViewWithBlock *tableview;
@property (weak, nonatomic) IBOutlet UIImageView *image_logo;
@property (weak, nonatomic) IBOutlet UIImageView *imageview_line;
@property (weak, nonatomic) IBOutlet UITextField *Txt_inputPwd;
@property (weak, nonatomic) IBOutlet UIButton *Button_ReadLogin;
@property (weak, nonatomic) IBOutlet UIImageView *imageview_Button_ReadLogin;
@property (weak, nonatomic) IBOutlet UIImageView *imageview_autoLoginBG;

@end

@implementation GWSDKQuarkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    isOpened=NO;
    
    self.tableview.hidden = YES;
    self.label_bg.layer.borderWidth = 0.5;
    self.label_bg.layer.cornerRadius = 4.0;
    self.label_bg.layer.borderColor = [UIColor grayColor].CGColor;
    self.label_bg.layer.masksToBounds = YES;
    
   // self.image_logo.image = [UIImage imageWithContentsOfFile:[GWUtility getFilePathFromBound:@"tlogo"]];
    
   
    
    index = 0;
    GWUICKeyChainStore * keyChainObj = [GWUICKeyChainStore keyChainStore];
    if ([keyChainObj stringForKey:KeyChain_GW_USER_UID]) {
        
        //找到原有数据源
        NSString * continString = [keyChainObj stringForKey:KeyChain_GW_USER_UID];
        
        NSArray *strArray = [continString componentsSeparatedByString:@"-"];
        
        newArray = [NSMutableArray arrayWithArray:strArray];
        
        [newArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            if ([NSString stringWithFormat:@"%@",obj].length == 0) {
                [newArray removeObject:obj];
            }
        }];
    }
    if ([GWUser isAuthenticated]) {
        [self readStatusWithUID:[keyChainObj stringForKey:KeyChain_GW_USERCURRENTLOGIN_UID]];
    }else{
         self.imageview_Button_ReadLogin.image  = nil;
    }
    
    
    self.imageview_autoLoginBG.image = [UIImage imageWithContentsOfFile:[GWUtility getFilePathFromBound:@"checkbox_unchecked_state"]];
    
    [self.navigationBar setShowCloseButtton:YES];
    
    UIImage *closeImage = [UIImage imageWithContentsOfFile:[GWUtility getFilePathFromBound:@"login_down"]];
    [self.Button_exchange setImage:closeImage forState:UIControlStateNormal];
    self.imageview_line.image = [UIImage imageWithContentsOfFile:[GWUtility getFilePathFromBound:@"chapter_line@2x"]];
    [self.Button_login infoStyle];
    [self.Button_signup defaultStyle];
    
#pragma mark     //首次填充数据
    
    NSString * uid = [keyChainObj stringForKey:KeyChain_GW_USERCURRENTLOGIN_UID];
    if (uid && uid.length > 0) {
        
    }else{
        uid =  [newArray firstObject];
    }
    
    {
        NSString * isTempUser = [keyChainObj stringForKey:[NSString stringWithFormat:@"%@_%@",KeyChain_GW_USER_STATUS_TEMP,uid]];
        if ([isTempUser isEqualToString:@"1"]) {
            // TURE
            self.Txt_inputUserName.text = self.Txt_inputUserName.text = [keyChainObj stringForKey:[NSString stringWithFormat:@"%@_%@",KeyChain_GW_USER_NICKNAME,uid]];
            
        }else{
            self.Txt_inputUserName.text = [keyChainObj stringForKey:[NSString stringWithFormat:@"%@_%@",KeyChain_GW_USER_USERNAME,uid]];
        }
        self.Txt_inputPwd.text = [keyChainObj stringForKey:[NSString stringWithFormat:@"%@_%@",KeyChain_GW_USER_PASSWORD,uid]];
        if (self.Txt_inputPwd.text.length == 0) {
            self.Txt_inputPwd.text  = @"test";
        }
    }

    [self.tableview initTableViewDataSourceAndDelegate:^(UITableView *tableView,NSInteger section){
        return (NSInteger)newArray.count;
        
    } setCellForIndexPathBlock:^(UITableView *tableView,NSIndexPath *indexPath){
        
        GWSDKQuarkTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"GWSDKQuarkTableViewCell"];
        if (!cell) {
            cell=[[[NSBundle mainBundle] loadNibNamed:[GWUtility stringByViewController:NSStringFromClass([GWSDKQuarkTableViewCell class])] owner:self options:nil] firstObject];
            [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
        }
        NSString * uid =  [newArray objectAtIndex:indexPath.row];
        NSString * isTempUser = [keyChainObj stringForKey:[NSString stringWithFormat:@"%@_%@",KeyChain_GW_USER_STATUS_TEMP,uid]];
        if ([isTempUser isEqualToString:@"1"]) {
            // TURE
             cell.Label_UserName.text =  [keyChainObj stringForKey:[NSString stringWithFormat:@"%@_%@",KeyChain_GW_USER_NICKNAME,uid]];;
        }else{
            cell.Label_UserName.text = [keyChainObj stringForKey:[NSString stringWithFormat:@"%@_%@",KeyChain_GW_USER_USERNAME,uid]];
        }
        UIImage *closeImage = [UIImage imageWithContentsOfFile:[GWUtility getFilePathFromBound:@"login_delete"]];
        [cell.Button_delete setImage:closeImage forState:UIControlStateNormal];
        [cell.Button_delete addTarget:self action:@selector(deleteUserFromLocalAction:) forControlEvents:UIControlEventTouchUpInside];
        //here.
        objc_setAssociatedObject(cell.Button_delete, (__bridge const void *)DELETE_BUTTON_ASS_KEY, @(indexPath.row), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
        return cell;
    } setDidSelectRowBlock:^(UITableView *tableView,NSIndexPath *indexPath){
        //1. 处理用户名和密码更换
        //2. 处理自动登录状态更改
        //3. 切换当前用户
        
        NSString * uid =  [newArray objectAtIndex:indexPath.row];
        index = indexPath.row;
        GWSDKQuarkTableViewCell *cell=(GWSDKQuarkTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
        self.Txt_inputUserName.text = cell.Label_UserName.text;
        self.Txt_inputPwd.text = [keyChainObj stringForKey:[NSString stringWithFormat:@"%@_%@",KeyChain_GW_USER_PASSWORD,uid]];
        if (self.Txt_inputPwd.text.length == 0) {
            self.Txt_inputPwd.text  = @"test";
        }
        [self.Button_exchange sendActionsForControlEvents:UIControlEventTouchUpInside];
        
        [self readStatusWithUID:uid];
        
    }];
    
    [self.tableview.layer setBorderColor:[UIColor grayColor].CGColor];
    [self.tableview.layer setBorderWidth:0.5];
    self.tableview.layer.masksToBounds = YES;
    
    // Do any additional setup after loading the view from its nib.
}


-(void) readStatusWithUID:(NSString *) uid
{
    if (uid && uid.length > 0) {
        GWUICKeyChainStore * keyChainObj = [GWUICKeyChainStore keyChainStore];
        UIImage * autoImage;
        // 1. 如果是已登录
        // 2. 获取当前登录中的UID的自动登录状态
        NSString * continString = [keyChainObj stringForKey:[NSString stringWithFormat:@"%@_%@",KeyChain_GW_CURRENT_AUTOREEMEBERUSRE,uid]];
        if ([continString isEqualToString:@"1"])
            autoImage = [UIImage imageWithContentsOfFile:[GWUtility getFilePathFromBound:@"write-icon-check"]];
        else
            autoImage = nil;
        
        if (autoImage) {
//            self.Button_ReadLogin.titleLabel.textColor = [UIColor greenColor];
        }else{
//            self.Button_ReadLogin.titleLabel.textColor = [UIColor groupTableViewBackgroundColor];
        }
        self.imageview_Button_ReadLogin.image =  autoImage;
    }else{
        self.imageview_Button_ReadLogin.image =  nil;
    }
    
    
}


-(void) exchangeAutoLogin
{
   
    if (self.imageview_Button_ReadLogin.image) {
        self.imageview_Button_ReadLogin.image = nil;
//        self.Button_ReadLogin.titleLabel.textColor = [UIColor groupTableViewBackgroundColor];
    }else{
        self.imageview_Button_ReadLogin.image = [UIImage imageWithContentsOfFile:[GWUtility getFilePathFromBound:@"write-icon-check"]];
//        self.Button_ReadLogin.titleLabel.textColor = [UIColor greenColor];
    }
    
}

- (IBAction)findpwd_action:(id)sender {
    GWSDKFindPwdViewController *  openViewcontr = [[GWSDKFindPwdViewController alloc] initWithNibName:    [GWUtility stringByViewController:NSStringFromClass([GWSDKFindPwdViewController class])] bundle:nil];
    GWSDKNavigationController * navitation = [GWSDKNavigationController shareInstance];
    [navitation pushGWSDKViewController:openViewcontr animated:YES];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField              // called when 'return' key pressed. return NO to ignore.
{
    [textField resignFirstResponder];
    
    return YES;
}
- (IBAction)dismisskeyboard:(id)sender {

    [self.Txt_inputPwd resignFirstResponder];
    [self.Txt_inputUserName resignFirstResponder];
}

-(IBAction)deleteUserFromLocalAction:(id)sender
{
    [[[UIAlertView alloc]initWithTitle:@"提示" message:@"是否从本地删除帐号记录" cancelButtonItem:[GWSDKRIButtonItem itemWithLabel:@"取消" action:^{
        
    }] otherButtonItems:[GWSDKRIButtonItem itemWithLabel:@"继续删除" action:^{
#pragma mark  delete click
        // 1. remove from keychain
        // 2. logout
        // 3. clear login status
        // 4. reload this tableView
        // 5. exchange tableview
        // 6. self.Txt_inputUserName.text fill
        
        NSNumber *  indexPathrow =  objc_getAssociatedObject(sender, (__bridge const void *)DELETE_BUTTON_ASS_KEY);

        NSString * uid =  [newArray objectAtIndex:[indexPathrow integerValue]];
        
        GWUICKeyChainStore * keyChainObj = [GWUICKeyChainStore keyChainStore];
        if ([keyChainObj stringForKey:KeyChain_GW_USER_UID]) {
            
            //找到原有数据源
            NSString * continString = [keyChainObj stringForKey:KeyChain_GW_USER_UID];
            
            NSArray *strArray = [continString componentsSeparatedByString:@"-"];
            [GWUtility printSystemLog:strArray];
            
            NSMutableArray * newArraykeychain = [NSMutableArray arrayWithArray:strArray];
            
            [newArraykeychain enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                //遍历所有元素 然后找到用户替换之.
                if([[NSString stringWithFormat:@"%@",obj] isEqualToString:uid]){
                    [newArraykeychain removeObject:obj];
                }
            }];
            /*!
             *       生成新的字符串
             */
            NSString * resultContinString = [[newArraykeychain valueForKey:@"description"] componentsJoinedByString:@"-"];
            //        resultContinString = [resultContinString stringByAppendingString:[NSString stringWithFormat:@"-%@",gwuser.userId]];
            [keyChainObj setString:resultContinString forKey:KeyChain_GW_USER_UID];
            [keyChainObj synchronize];
        }
        
        //[GWUser logOut];
        
        //注销当前登录中的UID
        [keyChainObj setString:@"" forKey:KeyChain_GW_USERCURRENTLOGIN_UID];
        [keyChainObj synchronize];
        
        [newArray removeObjectAtIndex:[indexPathrow integerValue]];
        [GWUtility printSystemLog:newArray];
        
        [self.tableview reloadData];
        
        [self.Button_exchange sendActionsForControlEvents:UIControlEventTouchUpInside];
        
        if (newArray && newArray.count > 0) {
            NSString * preUID = [newArray firstObject];
            self.Txt_inputUserName.text = [keyChainObj stringForKey:[NSString stringWithFormat:@"%@_%@",KeyChain_GW_USER_USERNAME,preUID]];
            self.Txt_inputPwd.text = [keyChainObj stringForKey:[NSString stringWithFormat:@"%@_%@",KeyChain_GW_USER_PASSWORD,uid]];
        }else {
            GWSDKLoginViewController* openViewcontr = [[GWSDKLoginViewController alloc] initWithNibName:[GWUtility stringByViewController:NSStringFromClass([GWSDKLoginViewController class])] bundle:nil];
            GWSDKNavigationController * navitation = [GWSDKNavigationController shareInstance];
            [navitation pushGWSDKViewController:openViewcontr animated:NO];
            [openViewcontr.navigationBar setShowBackButtton:NO];
        }
        
         [self readStatusWithUID:@""];
        
    }], nil] show];
    
}

- (IBAction)exchange_action:(id)sender {
    self.tableview.hidden = NO;
    if (isOpened) { 
        
        [UIView animateWithDuration:0.3 animations:^{
            UIImage *closeImage = [UIImage imageWithContentsOfFile:[GWUtility getFilePathFromBound:@"login_down"]];
            [self.Button_exchange setImage:closeImage forState:UIControlStateNormal];
            
            CGRect frame=self.tableview.frame;
            
            frame.size.height = 0;
            
            [self.tableview setFrame:frame];
            
        } completion:^(BOOL finished){
            
            isOpened=NO;
        }];
    }else{
        
        [UIView animateWithDuration:0.3 animations:^{
            UIImage *openImage = [UIImage imageWithContentsOfFile:[GWUtility getFilePathFromBound:@"login_up"]];
            [self.Button_exchange setImage:openImage forState:UIControlStateNormal];
            
            CGRect frame=self.tableview.frame;
            
            GWSDKNavigationController * navitation = [GWSDKNavigationController shareInstance];
            frame.size.height=navitation.size.height*0.35;
            
            [self.tableview setFrame:frame];
            /*
            UIBezierPath *maskPath=[UIBezierPath bezierPathWithRoundedRect:self.tableview.bounds byRoundingCorners:(UIRectCornerBottomLeft | UIRectCornerBottomRight) cornerRadii:CGSizeMake(5.0, 5.0)];
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
            maskLayer.frame = self.tableview.bounds;
            maskLayer.path=maskPath.CGPath;
            maskLayer.strokeColor = [UIColor grayColor].CGColor;
            maskLayer.lineWidth = 0.5f;
            
            self.tableview.layer.mask = maskLayer;
            */
        } completion:^(BOOL finished){
            
            isOpened=YES;
        }];
    }
}

- (IBAction)login_Action:(id)sender {
    
    if (self.Txt_inputUserName.text.length == 0) {
        [SVProgressHUD showInfoWithStatus:@"用户名不能为空"];
        return;
    }
    
    if (self.Txt_inputPwd.text.length == 0) {
        [SVProgressHUD showInfoWithStatus:@"密码不能为空"];
        return;
    }
    
    //NSString * uid = [newArray objectAtIndex:index];
    //GWUICKeyChainStore * keyChainObj = [GWUICKeyChainStore keyChainStore];
    
    NSString * username = self.Txt_inputUserName.text;// [keyChainObj stringForKey:[NSString stringWithFormat:@"%@_%@",KeyChain_GW_USER_USERNAME,uid]];
    
    NSString * password = self.Txt_inputPwd.text;//[keyChainObj stringForKey:[NSString stringWithFormat:@"%@_%@",KeyChain_GW_USER_PASSWORD,uid]];
    
    [SVProgressHUD showWithStatus:@"登录中" maskType:(SVProgressHUDMaskTypeBlack)];
    
    //NSString * isTempUser = [keyChainObj stringForKey:[NSString stringWithFormat:@"%@_%@",KeyChain_GW_USER_STATUS_TEMP,uid]];
    
    //NSString * nickname = [keyChainObj stringForKey:[NSString stringWithFormat:@"%@_%@",KeyChain_GW_USER_NICKNAME,uid]];
/*
    if ([isTempUser isEqualToString:@"1"] && [username isEqualToString:nickname] && NO) {
        
        //临时用户
        [GWUser logInWithTempUsernameInBackgroundblock:^(GWUser *user, NSError *error) {
            if (user) {
                [self saveAutoLoginStatus];
                [SVProgressHUD dismiss];
                GWSDKNavigationController * navitation = [GWSDKNavigationController shareInstance];
                [navitation show:NO animated:YES];
            }else{
                NSString * errorDes = [[error userInfo] valueForKey:NSLocalizedDescriptionKey];
                [SVProgressHUD showErrorWithStatus:errorDes];
            }
        }];
        
    }else{
 
    }*/
    
    //正式用户 or 临时用户
    [GWUser logInWithUsernameInBackground:username password:password block:^(GWUser *user, NSError *error) {
        if (user) {
            [self saveAutoLoginStatus];
            [SVProgressHUD dismiss];
            GWSDKNavigationController * navitation = [GWSDKNavigationController shareInstance];
            [navitation show:NO animated:YES];
        }else{
            NSString * errorDes = [[error userInfo] valueForKey:NSLocalizedDescriptionKey];
            [SVProgressHUD showErrorWithStatus:errorDes];
        }
    }];
}

/*!
 *  保存自动登录状态
 */
-(void) saveAutoLoginStatus
{

    GWUICKeyChainStore * keyChainObj = [GWUICKeyChainStore keyChainStore];
    if (self.imageview_Button_ReadLogin.image) {
        
        [keyChainObj setString:@"1" forKey:[NSString stringWithFormat:@"%@_%@",KeyChain_GW_CURRENT_AUTOREEMEBERUSRE,[keyChainObj stringForKey:KeyChain_GW_USERCURRENTLOGIN_UID]]];
    }else{
        [keyChainObj setString:@"0" forKey:[NSString stringWithFormat:@"%@_%@",KeyChain_GW_CURRENT_AUTOREEMEBERUSRE,[keyChainObj stringForKey:KeyChain_GW_USERCURRENTLOGIN_UID]]];
    }
    [keyChainObj synchronize];
}

- (IBAction)signup_Action:(id)sender {
    
    GWSDKRegisterViewController *  openViewcontr = [[GWSDKRegisterViewController alloc] initWithNibName:[GWUtility stringByViewController:NSStringFromClass([GWSDKRegisterViewController class])] bundle:nil];
    openViewcontr.isLoginAssgin = GWEXCHANGETYPE_Register;
    [self.gwSDKNavigationController pushGWSDKViewController:openViewcontr animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)changeButton_ReadLogin_action:(id)sender {
    [self exchangeAutoLogin];
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
