//
//  UIAlertView+Blocks.h
//  Shibui
//
//  Created by Jiva DeVoe on 12/28/10.
//  Copyright 2010 Random Ideas, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GWSDKRIButtonItem.h"

@interface UIAlertView (GWSDKBlocks)

-(id)initWithTitle:(NSString *)inTitle message:(NSString *)inMessage cancelButtonItem:(GWSDKRIButtonItem *)inCancelButtonItem otherButtonItems:(GWSDKRIButtonItem *)inOtherButtonItems, ... NS_REQUIRES_NIL_TERMINATION;

- (NSInteger)addButtonItem:(GWSDKRIButtonItem *)item;

@end
