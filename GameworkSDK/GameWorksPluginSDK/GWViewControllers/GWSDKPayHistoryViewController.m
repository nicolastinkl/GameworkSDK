//
//  GWSDKPayHistoryViewController.m
//  GameWorksSDK
//
//  Created by tinkl on 21/1/15.
//  Copyright (c) 2015年 ___GAMEWORK___. All rights reserved.
//

#import "GWSDKPayHistoryViewController.h"

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
#import "GDSDKPayHistoryTableViewCell.h"


static NSString *kCellIdentifierForTableOfContents	= @"GDSDKPayHistoryTableViewCell";

@interface GWSDKPayHistoryViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray * historyList;
}
@property (unsafe_unretained, nonatomic) IBOutlet UITableView *tableview;

@end

@implementation GWSDKPayHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    historyList = [NSMutableArray array];
    
    [self.tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:kCellIdentifierForTableOfContents];
    
    [GWSDKPayMent requestGameIdInBackgroundblock:^(id object, NSError *error) {
        if (object) {
            [GWSDKPayMent requestPayHistoryInBackground:0  gameid:[object integerValue] block:^(NSArray *objects, NSError *error)
            {
                [GWUtility printSystemLog:objects];
                [self.tableview reloadData];
            }];
        }else{
            [SVProgressHUD showErrorWithStatus:@"数据加载失败"];
        }
    }];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark tableview

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return historyList.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0f;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    GDSDKPayHistoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifierForTableOfContents forIndexPath:indexPath];
    
    return cell;
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
