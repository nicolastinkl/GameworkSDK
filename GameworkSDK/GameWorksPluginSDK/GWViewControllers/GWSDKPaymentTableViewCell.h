//
//  GWSDKPaymentTableViewCell.h
//  GameWorksSDK
//
//  Created by tinkl on 15/1/15.
//  Copyright (c) 2015年 ___GAMEWORK___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GWSDKPaymentTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView    *ImageView_icon;
@property (weak, nonatomic) IBOutlet UILabel        *Label_Name;
@property (weak, nonatomic) IBOutlet UIImageView    *ImageView_ok;
@property (weak, nonatomic) IBOutlet UILabel        *label_bg;

@end
