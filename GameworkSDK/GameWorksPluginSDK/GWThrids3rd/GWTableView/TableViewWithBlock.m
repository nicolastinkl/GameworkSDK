//
//  TableViewWithBlock.m
//  ComboBox
//
//  Created by Eric Che on 7/17/13.
//  Copyright (c) 2013 Eric Che. All rights reserved.
//

#import "TableViewWithBlock.h"
#import "UITableView+DataSourceBlocks.h"
#import "UITableView+DelegateBlocks.h"
#import <UIKit/UIKit.h>

@implementation TableViewWithBlock

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(void)initTableViewDataSourceAndDelegate:(UITableViewNumberOfRowsInSectionBlock)numOfRowsBlock setCellForIndexPathBlock:(UITableViewCellForRowAtIndexPathBlock)cellForIndexPathBlock setDidSelectRowBlock:(UITableViewDidSelectRowAtIndexPathBlock)didSelectRowBlock{
   
    self.numberOfRowsInSectionBlock=numOfRowsBlock;
    self.cellForRowAtIndexPath=cellForIndexPathBlock;
    self.didDeselectRowAtIndexPathBlock=didSelectRowBlock;
    self.dataSource=self;
    self.delegate=self;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.cellForRowAtIndexPath(tableView,indexPath);
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.numberOfRowsInSectionBlock(tableView,section);
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.didDeselectRowAtIndexPathBlock(tableView,indexPath);
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[self tableView:tableView cellForRowAtIndexPath:indexPath];
    if (cell) {
        return cell.frame.size.height;
    }
    return 0;
}

/*!
 *  处理底部圆角问题
 *

- (void)drawRect:(CGRect)rect {
    
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [self drawGroupSeparatorLineWithContext:context rect:rect];
    
}
*/
- (void)drawGroupSeparatorLineWithContext:(CGContextRef)context rect:(CGRect)rect {
    
    UIColor * separatorCGColor = [UIColor colorWithRed:200/255.0 green:199/255.0 blue:204/255.0 alpha:1];
    
    UIEdgeInsets borderEdgeInsets = UIEdgeInsetsMake(0, -1, 0, -1);
    
    CGFloat borderInsetRight =  CGRectGetWidth(rect) - borderEdgeInsets.right;
    
    CGContextSetStrokeColorWithColor(context, separatorCGColor.CGColor);
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, 0, CGRectGetHeight(rect));
    CGContextAddLineToPoint(context, borderInsetRight, CGRectGetHeight(rect));
    CGContextStrokePath(context);
    
}




@end
