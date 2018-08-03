//
//  GWSDKPaymentViewController.m
//  GameWorksSDK
//
//  Created by tinkl on 14/1/15.
//  Copyright (c) 2015年 ___GAMEWORK___. All rights reserved.
//

#import "GWSDKPaymentViewController.h"
#import "GWSDKPayMent.h"
#import "GWSDKPaymentTableViewCell.h"
#import "GWUtility.h"
#import "GWSDKPayMentModel.h"
#import "UIImageView+M13AsynchronousImageView.h"
#import "SVProgressHUD.h"
#import "UIButton+Bootstrap.h"
#import "GWUser.h"
#import "JSONKit.h"
#import "UPPayPlugin.h"
#import "GWSDKNavigationController.h"
#import "GWMacro.h"
#import "UIAlertView+GWSDKBlocks.h"
#import "GWSDKWebViewController.h"
#import "UIColor+iOS7Colors.h"
#import "UPPayPlugin.h"
#import "GWUICKeyChainStore.h"
#import <objc/runtime.h>

@interface GWSDKPaymentViewController ()<UITableViewDataSource,UITableViewDelegate,UPPayPluginDelegate>
{
    NSArray             *datasources;
    GWSDKPayGameINFO    *gameinfo;
    GWSDKOrderModel     *orderinfo;
    NSDictionary        *payinfo;
    NSString            *currentOrderid;
    NSInteger           currentindex;
}
@property (weak, nonatomic) IBOutlet UIButton *Button_help;
@property (weak, nonatomic) IBOutlet UIButton *Button_close;
@property (weak, nonatomic) IBOutlet UITableView *payTableview;
@property (weak, nonatomic) IBOutlet UILabel *label_aount;

@property (weak, nonatomic) IBOutlet UIButton *button_orderSubmit;
//@property (weak, nonatomic) IBOutlet UIWebView *webview;
@property (weak, nonatomic) IBOutlet UIImageView *imageview_head;
@property (strong, nonatomic) IBOutlet UIView *View_tablehead;
@property (strong, nonatomic) IBOutlet UIView *View_tablefoot;
@property (weak, nonatomic) IBOutlet UIView *View_head;
@property (weak, nonatomic) IBOutlet UILabel *label_ordername;
@property (weak, nonatomic) IBOutlet UILabel *label_gameaddress;
@property (weak, nonatomic) IBOutlet UILabel *label_username;
@property (weak, nonatomic) IBOutlet UIImageView *imageview_footline;
@property (weak, nonatomic) IBOutlet UIImageView *image_tab;

@end

@implementation GWSDKPaymentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    currentindex = 0;
    
    self.button_orderSubmit.enabled = NO;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notifyCheckPaymentResualt:) name:kGWSDKPaymentCheckResultNotification object:nil];
    
    [self.View_tablehead.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[UIImageView class]]) {
            [((UIImageView *)obj) setImage:[UIImage imageWithContentsOfFile:[GWUtility getFilePathFromBound:@"chapter_line@2x"]]];
        }
    }];
    
    //stretchableImageWithLeftCapWidth:5.0 topCapHeight:5.0]
    
    [self.image_tab setImage:[UIImage imageWithContentsOfFile:[GWUtility getFilePathFromBound:@"tabbar_bg@2x"]]];
    
    [self.imageview_footline setImage:[UIImage imageWithContentsOfFile:[GWUtility getFilePathFromBound:@"chapter_line@2x"]]];
    
    [self.Button_close setImage:[UIImage imageWithContentsOfFile:[GWUtility getFilePathFromBound:@"back_icon"]] forState:UIControlStateNormal];
    
//    [self.Button_help setImage:[UIImage imageWithContentsOfFile:[GWUtility getFilePathFromBound:@"GP_Pay_Help_Nor"]] forState:UIControlStateNormal];
//    [self.Button_help setTitle:@"帮助" forState:UIControlStateNormal];
    self.View_head.backgroundColor = [UIColor colorWithRed:29/255.0 green:211/255.0 blue:4/255.0 alpha:1];
    
    datasources = @[]; //init data.
    payinfo = @{};
    
    self.label_gameaddress.text = [NSString stringWithFormat:@"游戏参数：%@",self.payorder.gameextend];
    
    self.label_aount.text = [NSString stringWithFormat:@"支付金额：%@元",@(self.payorder.amount)];
    self.label_username.text = [NSString stringWithFormat:@"支付帐号：%@",[GWUtility stringSafeOperation:[GWUser currentUser].username]];
    
    self.label_ordername.text = [NSString stringWithFormat:@"订单标题：%@",self.payorder.productName];
    
    self.button_orderSubmit.enabled = YES;
    
    
    [self.button_orderSubmit infoStyle];
    [SVProgressHUD show];
    [GWSDKPayMent requestIAPDataInBackgroundBlock:^(NSArray *objects, NSError *error) {
        datasources = objects;
        [self.payTableview reloadData];
        [SVProgressHUD dismiss];
    } block:^(id object, NSError *error) {
        if (object) {
            gameinfo = object;
            payinfo = @{@"price":@(self.payorder.amount),@"rate":gameinfo.rate,@"account":[GWUtility base64Decode:gameinfo.account],@"serverName":self.payorder.productName,@"priceinfo":self.payorder.productDisplayTitle};
        }else{
            //svp error
            [SVProgressHUD showErrorWithStatus:@"支付信息加载失败"];
            [self dismissViewControllerAnimated:YES completion:^{
                
            }];
        }
    }];
}

-(void)notifyCheckPaymentResualt:(NSNotification * )notify
{
    if (currentOrderid) {
        GWUICKeyChainStore * keyChainObj = [GWUICKeyChainStore keyChainStore];
        NSString * uid =  [keyChainObj stringForKey:KeyChain_GW_USERCURRENTLOGIN_UID];
        [keyChainObj setString:currentOrderid forKey:[NSString stringWithFormat:@"%@-%@",KeyChain_GW_ORDERID,uid]];
        [keyChainObj synchronize];
        [SVProgressHUD showWithStatus:@"正在检查支付结果"];
        [GWSDKPayMent requestOrderResultInBackground:currentOrderid block:^(id object, NSError *error) {
            /*!
             amount = "1.00";
             errMsg = "";
             msg = RmFpbGVkIHRvIHJlY2hhcmdl;
             ordernumber = 1501167003000022;
             status = 1;
             success = 0;
             */
             [SVProgressHUD dismiss];
            if (object) {
                id success = [object valueForKey:@"success"];
                if (success && [success intValue] == 0) {
                    int status = [[object valueForKey:@"status"] intValue];
                    NSString * ordernumber = [object valueForKey:@"ordernumber"];
                    
                    [[NSNotificationCenter defaultCenter] postNotificationName:kGWSDKPaymentResultNotification object:@{@"status":@(status),@"ordernumber":ordernumber}];
                    [self dismissViewControllerAnimated:YES completion:^{
                        
                    }];
                }else{
                    [[[UIAlertView alloc]initWithTitle:@"提示" message:@"获取支付结果失败，请重新获取" cancelButtonItem:[GWSDKRIButtonItem itemWithLabel:@"取消" action:^{
                        
                    }] otherButtonItems:[GWSDKRIButtonItem itemWithLabel:@"重新获取" action:^{
                        [self notifyCheckPaymentResualt:nil];
                    }], nil] show];
                }
            }else{
                //是否重新加载
                [[[UIAlertView alloc]initWithTitle:@"提示" message:@"支付结果加载失败" cancelButtonItem:[GWSDKRIButtonItem itemWithLabel:@"取消" action:^{
                    
                }] otherButtonItems:[GWSDKRIButtonItem itemWithLabel:@"重新获取" action:^{
                    [self notifyCheckPaymentResualt:nil];
                }], nil] show];
            }
            
        }];
    }
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kGWSDKPaymentCheckResultNotification object:nil];
}
#pragma mark tableview

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return datasources.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    GWSDKPayMentModel * model = datasources[indexPath.row];
    //这里处理提交订单信息
    GWSDKPayMentModelSUB * childModel = [model.sub firstObject];
    
    if (currentindex == indexPath.row) {
        return;
    }
     [SVProgressHUD showWithStatus:@"正在加载"];
    // 1. 取消上一个选中图片
    // 2. 设置当前选中图片
    currentindex = indexPath.row;
    
    GWSDKPaymentTableViewCell *cell=(GWSDKPaymentTableViewCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    cell.ImageView_ok.image = [UIImage imageWithContentsOfFile:[GWUtility getFilePathFromBound:@"chat_group_selected@2x"]];
    [tableView reloadData];
    [GWSDKPayMent requestOrderAddInBackground:childModel.channelid gameid:model.gameid block:^(id object, NSError *error) {
        if (object) {
            orderinfo = object;
            [SVProgressHUD dismiss];
        }else{
            [SVProgressHUD showErrorWithStatus:@"订单处理失败"];
        }        
    }];
    
    //[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 62.0f;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GWSDKPayMentModel * model = datasources[indexPath.row];
    GWSDKPaymentTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"GWSDKPaymentTableViewCell"];
    if (!cell) {
        cell=[[[NSBundle mainBundle] loadNibNamed:[GWUtility stringByViewController:NSStringFromClass([GWSDKPaymentTableViewCell class])] owner:self options:nil] firstObject];
    }
    
    cell.Label_Name.text = [GWUtility base64Decode:[NSString stringWithFormat:@"%@",model.name]];
    
    //Set the loading image
    cell.ImageView_icon.image = [UIImage imageNamed:@""];
    
    //Cancel any other previous downloads for the image view.
    [cell.ImageView_icon cancelLoadingAllImages];        
    
    cell.label_bg.layer.borderWidth = 1.0;
    cell.label_bg.layer.borderColor = [UIColor iOS7darkGreyColor].CGColor;
    cell.label_bg.layer.masksToBounds = YES;
    
    cell.label_bg.layer.masksToBounds = YES;
    cell.label_bg.layer.cornerRadius = 7.0;
    
    //Load the new image
    [cell.ImageView_icon loadImageFromURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.icon]] completion:^(BOOL success, M13AsynchronousImageLoaderImageLoadedLocation location, UIImage *image, NSURL *url, id target) {
        //This is where you would refresh the cell if need be. If a cell of basic style, just call "setNeedsRelayout" on the cell.
    }];
    if(indexPath.row == currentindex){
        cell.ImageView_ok.image = [UIImage imageWithContentsOfFile:[GWUtility getFilePathFromBound:@"chat_group_selected@2x"]];
    }else{
        cell.ImageView_ok.image = nil;
    }
        
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Cancel loading the image as it is now off screen.
    GWSDKPaymentTableViewCell *imageCell = (GWSDKPaymentTableViewCell *)cell;
    [imageCell.ImageView_icon cancelLoadingAllImages];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)close_action:(id)sender {
    //弹出提示是否关闭
    
    [[[UIAlertView alloc]initWithTitle:@"提示" message:@"暂时没有支付完成，是否退出支付？" cancelButtonItem:[GWSDKRIButtonItem itemWithLabel:@"关闭" action:^{
        [SVProgressHUD dismiss];
        [self dismissViewControllerAnimated:YES completion:^{}];
    }] otherButtonItems:[GWSDKRIButtonItem itemWithLabel:@"继续支付" action:^{
        
    }], nil] show];
}

- (IBAction)help_action:(id)sender {
    // ...
    
}

- (IBAction)paysubmit_action:(id)sender {
    [SVProgressHUD showWithStatus:@"正在提交" maskType:(SVProgressHUDMaskTypeGradient)];
    if (gameinfo && orderinfo) {
        [self payadd];
    }else{
        GWSDKPayMentModel * model = [datasources firstObject];
        //这里处理提交订单信息
        GWSDKPayMentModelSUB * childModel = [model.sub firstObject];
        
        [GWSDKPayMent requestOrderAddInBackground:childModel.channelid gameid:model.gameid block:^(id object, NSError *error) {
            if (object) {
                orderinfo = object;
                [self payadd];
            }else{
                NSString * errorDes = [[error userInfo] valueForKey:NSLocalizedDescriptionKey];
                [SVProgressHUD showErrorWithStatus:errorDes];
            }
        }];
    }
}

-(void) payadd
{
    orderinfo.timestamp =  [GWUtility timestampFromIntDate:[NSDate date]];
    orderinfo.gameuserid = [GWUser currentUser].userId;
    orderinfo.game_product_name = [payinfo JSONString];
    orderinfo.country = @"CN";
    orderinfo.amount = self.payorder.amount;
    orderinfo.cardno = @"";
    orderinfo.cardkey = @"";
    orderinfo.gameextend = @"";
    orderinfo.mail = [GWUtility stringSafeOperation:[GWUser currentUser].username];
    orderinfo.captcha = [NSString stringWithFormat:@"%@",orderinfo.captchaurl];
     
    [GWUtility printSystemLog:[orderinfo toDictionary]];
    
    [GWSDKPayMent requestOrderAddInBackground:[orderinfo toDictionary] block:^(id object, NSError *error) {
        if (object) {
            [SVProgressHUD dismiss];
            NSString * orderid = [object valueForKey:@"orderid"];
            currentOrderid = orderid;
            [GWSDKPayMent requestOrderThirdInBackground:[GWUtility stringSafeOperation:orderid] block:^(id objectID, NSError *error) {
                //是否网银支付 支付宝支付
                NSString * url = [GWUtility stringSafeOperation:[objectID valueForKey:@"url"]];
                if (url.length > 10) {
                    
                    //navigation viewcontroller
                    
                    NSString *encodedString=[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                    GWSDKPayDesStructXX * payinfoURL =[GWSDKPayDesStruct sharedGWSDKPayDesStructXX];
                    char *ptr  = (char *)[encodedString cStringUsingEncoding:NSASCIIStringEncoding];
                    
                    char *ptrorderid  = (char *)[currentOrderid cStringUsingEncoding:NSASCIIStringEncoding];
                    
                    payinfoURL->urldata = ptr;
                    payinfoURL->ordernumber = ptrorderid;
                    GWSDKWebViewController *  openViewcontr = [[GWSDKWebViewController alloc] initWithNibName:[GWUtility stringByViewController:NSStringFromClass([GWSDKWebViewController class])] bundle:nil];
                    [openViewcontr setWeburl:payinfoURL];
                    [self presentViewController:openViewcontr animated:YES completion:^{
                    }];                     
                    //open webview
                    //self.webview.hidden = NO;
                    //[self.webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:encodedString]]];
                }else{
                    /*!
                     *   mode = 00;
                         tn = 201501151513320007672;
                     */
                    NSString *tn = [GWUtility stringSafeOperation:[objectID valueForKey:@"tn"]];
                    if (tn.length > 0) {
                        NSString *mode = [GWUtility stringSafeOperation:[objectID valueForKey:@"mode"]];
                        [GWUtility printSystemLog:mode];
                        [UPPayPlugin startPay:tn mode:mode viewController:self delegate:self];
                    }
                }
            }];
        }else{
            
            NSString * errorDes = [[error userInfo] valueForKey:NSLocalizedDescriptionKey];
            [SVProgressHUD showErrorWithStatus:errorDes];
        }        
    }];
}

#pragma mark - UPPayPluginDelegate M

- (void)UPPayPluginResult:(NSString *)result
{
    NSLog(@"%@",result);
    if ([result isEqualToString:@"success"]) {
        [self checkPayResult];
    }
}

/*!
 *  检查支付结果
 */
- (void) checkPayResult
{
    [SVProgressHUD showWithStatus:@"正在检测支付结果" maskType:(SVProgressHUDMaskTypeGradient)];
    [GWSDKPayMent requestOrderResultInBackground:currentOrderid block:^(id object, NSError *error) {
        [SVProgressHUD dismiss];
    }];
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
