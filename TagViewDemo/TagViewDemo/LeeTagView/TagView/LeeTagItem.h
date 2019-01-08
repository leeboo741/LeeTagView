//
//  LeeTagItem.h
//  TagViewDemo
//
//  Created by mac on 2019/1/7.
//  Copyright © 2019年 YWKJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LeeTagItemViewModel;

#pragma mark -
#pragma mark Interface

@interface LeeTagItem : UIView

#pragma mark -
#pragma mark Property

@property (nonatomic, strong, readonly) LeeTagItemViewModel * viewModel; // viewModel;
@property (nonatomic, assign) BOOL selected; // 是否选中
@property (nonatomic, assign) BOOL disable; // 是否可用

#pragma mark -
#pragma mark Function

/**
 初始化方法
 
 @param itemViewModel LeeTagItemViewModel
 @return LeeTagItem 对象
 */
+(LeeTagItem *)tagItemWithItemViewModel:(LeeTagItemViewModel *)itemViewModel;

/**
 设置点击事件
 
 @param target 目标
 @param action 方法
 */
-(void)addTapTarget:(id)target action:(SEL)action;

@end
