//
//  LeeTagItemViewModel.h
//  TagViewDemo
//
//  Created by mac on 2019/1/7.
//  Copyright © 2019年 YWKJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LeeTagItemViewModel : NSObject

#pragma mark -
#pragma mark Object 可携带数据
@property (nonatomic, strong) id data; // 可携带的数据对象

#pragma mark -
#pragma mark State 状态
@property (nonatomic, assign) BOOL selected; // 是否选中
@property (nonatomic, assign) BOOL disable; // 是否禁用

#pragma mark -
#pragma mark Padding 间距&约束
@property (nonatomic, assign) UIEdgeInsets contentPadding; // item 内边距
@property (nonatomic, assign) CGFloat imageAndLabelPadding; // item 图片文字间距
@property (nonatomic, assign) CGFloat imageHeightAndWidth; // item 图片宽高

#pragma mark -
#pragma mark Normal 正常
// 文本
@property (nonatomic, copy) NSString * normalTitle; // 正常状态文本
@property (nonatomic, strong) UIColor * normalColor; // 正常状态文本颜色
@property (nonatomic, assign) CGFloat normalFontSize; // 正常文本字体大小
@property (nonatomic, strong) UIFont * normalFont; // 正常文本字体
// 图片
@property (nonatomic, strong) UIImage * normalImage; // 正常状态图片
// 富文本
@property (nonatomic, copy) NSAttributedString * normalAttributeTitle; // 正常状态富文本
// 背景
@property (nonatomic, strong) UIColor * normalBGColor; // 正常状态背景颜色
@property (nonatomic, strong) UIImage * normalBGImage; // 正常状态背景图片
@property (nonatomic, assign) CGFloat normalCornerRadius; // 正常状态圆角半径
@property (nonatomic, assign) CGFloat normalBorderWidth; // 正常状态边线宽度
@property (nonatomic, strong) UIColor * normalBorderColor; // 正常状态边线颜色

#pragma mark -
#pragma mark Selected 选中
// 文本
@property (nonatomic, copy) NSString * selectedTitle; // 选中状态文本
@property (nonatomic, strong) UIColor * selectedColor; // 选中状态文本颜色
@property (nonatomic, assign) CGFloat selectedFontSize; // 选中文本字体大小
@property (nonatomic, strong) UIFont * selectedFont; // 选中文本字体
// 图片
@property (nonatomic, strong) UIImage * selectedImage; // 选中状态图片
// 富文本
@property (nonatomic, copy) NSAttributedString * selectedAttributeTitle; // 选中状态富文本
// 背景
@property (nonatomic, strong) UIColor * selectedBGColor; // 选中状态背景颜色
@property (nonatomic, strong) UIImage * selectedBGImage; // 选中状态背景图片
@property (nonatomic, assign) CGFloat selectedCornerRadius; // 选中状态圆角半径
@property (nonatomic, assign) CGFloat selectedBorderWidth; // 选中状态边线宽度
@property (nonatomic, strong) UIColor * selectedBorderColor; // 选中状态边线颜色

#pragma mark -
#pragma mark 禁用
// 文本
@property (nonatomic, copy) NSString * disableTitle; // 禁用状态文本
@property (nonatomic, strong) UIColor * disableColor; // 禁用状态文本颜色
@property (nonatomic, assign) CGFloat disableFontSize; // 禁用文本字体大小
@property (nonatomic, strong) UIFont * disableFont; // 禁用文本字体
// 图片
@property (nonatomic, strong) UIImage * disableImage; // 禁用状态图片
// 富文本
@property (nonatomic, copy) NSAttributedString * disableAttributeTitle; // 禁用状态富文本
// 背景
@property (nonatomic, strong) UIColor * disableBGColor; // 禁用状态背景颜色
@property (nonatomic, strong) UIImage * disableBGImage; // 禁用状态背景图片
@property (nonatomic, assign) CGFloat disableCornerRadius; // 禁用状态圆角半径
@property (nonatomic, assign) CGFloat disableBorderWidth; // 禁用状态边线宽度
@property (nonatomic, strong) UIColor * disableBorderColor; // 禁用状态边线颜色

#pragma mark -
#pragma mark 选中禁用
// 文本
@property (nonatomic, copy) NSString * selectedDisableTitle; // 选中禁用状态文本
@property (nonatomic, strong) UIColor * selectedDisableColor; // 选中禁用状态文本颜色
@property (nonatomic, assign) CGFloat selectedDisableFontSize; // 选中禁用文本字体大小
@property (nonatomic, strong) UIFont * selectedDisableFont; // 选中禁用文本字体
// 图片
@property (nonatomic, strong) UIImage * selectedDisableImage; // 选中禁用状态图片
// 富文本
@property (nonatomic, copy) NSAttributedString * selectedDisableAttributeTitle; // 选中禁用状态富文本
// 背景
@property (nonatomic, strong) UIColor * selectedDisableBGColor; // 选中禁用状态背景颜色
@property (nonatomic, strong) UIImage * selectedDisableBGImage; // 选中禁用状态背景图片
@property (nonatomic, assign) CGFloat selectedDisableCornerRadius; // 选中禁用状态圆角半径
@property (nonatomic, assign) CGFloat selectedDisableBorderWidth; // 选中禁用状态边线宽度
@property (nonatomic, strong) UIColor * selectedDisableBorderColor; // 选中禁用状态边线颜色

@end
