//
//  LeeTagViewModel.h
//  TagViewDemo
//
//  Created by YWKJ on 2018/9/4.
//  Copyright © 2018年 YWKJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LeeTagViewModel : NSObject

#pragma mark -
#pragma mark Tag Object
@property (nonatomic, strong) id data; // 可携带的数据对象

#pragma mark -
#pragma mark Tag Text
@property (nonatomic, copy) NSString * tagText; // 文本
@property (nonatomic, strong) UIFont * tagTextFont; // 文字字体
@property (nonatomic, assign) CGFloat tagTextFontSize; // 文字字体大小

@property (nonatomic, strong) UIColor * tagTextColor; // 未选中文本颜色
@property (nonatomic, strong) UIColor * tagSelectTextColor; // 选中文本颜色
@property (nonatomic, strong) UIColor * tagHighLightTextColor; // 选中文本颜色
@property (nonatomic, strong) UIColor * tagDisableTextColor; // 选中文本颜色

#pragma mark -
#pragma mark Tag Attribute Text
@property (nonatomic, copy) NSAttributedString * tagAttributedText; // 选中富文本
@property (nonatomic, copy) NSAttributedString * tagSelectAttributedText; // 未选中富文本
@property (nonatomic, copy) NSAttributedString * tagHighLightAttributedText; // 高亮富文本
@property (nonatomic, copy) NSAttributedString * tagDisableAttributedText; // 禁用富文本

#pragma mark -
#pragma mark Tag Image
@property (nonatomic, strong) UIImage * tagImage; // 未选中图片
@property (nonatomic, strong) UIImage * tagSelectImage; // 选中图片
@property (nonatomic, strong) UIImage * tagHighLightImage; // 高亮图片
@property (nonatomic, strong) UIImage * tagDisableImage; // 禁用图片

#pragma mark -
#pragma mark Tag Background
// tag background color
@property (nonatomic, strong) UIColor * tagBgColor; // 背景色
@property (nonatomic, strong) UIColor * tagHighLightedBgColor; // 高亮背景色
@property (nonatomic, strong) UIColor * tagSelectBgColor; // 选中背景色
@property (nonatomic, strong) UIColor * tagDisableBgColor; // 禁用背景颜色
// tag background image
@property (nonatomic, strong) UIImage * tagBgImage; // 背景图
@property (nonatomic, strong) UIImage * tagSelectBgImage; // 选中背景图
@property (nonatomic, strong) UIImage * tagHighLightedBgImage; // 高亮背景图
@property (nonatomic, strong) UIImage * tagDisableBgImage; // 禁用背景图

#pragma mark -
#pragma mark Tag Layer
@property (nonatomic, assign) CGFloat tagCornerRadius; // 圆角半径
@property (nonatomic, assign) CGFloat tagBorderWidth; // 边线宽度

@property (nonatomic, strong) UIColor * tagBorderColor; // 未选中边线颜色
@property (nonatomic, strong) UIColor * tagSelectBorderColor; // 选中边线颜色
@property (nonatomic, strong) UIColor * tagHighLightedBorderColor; // 高亮边线颜色
@property (nonatomic, strong) UIColor * tagDisableBorderColor; // 禁用边线颜色

#pragma mark -
#pragma mark Tag Padding
// UIEdgeInsetsMake (CGFloat top, CGFloat left, CGFloat bottom, CGFloat right)
// 里面的四个参数表示距离上边界、左边界、下边界、右边界的距离，默认都为零
@property (nonatomic, assign) UIEdgeInsets contentPadding; // button 内容边界距离

#pragma mark -
#pragma mark Tag Status
@property (nonatomic, assign) BOOL enable; // 是否可以操作
@property (nonatomic, assign) BOOL isSelect; // 是否选中

@end
