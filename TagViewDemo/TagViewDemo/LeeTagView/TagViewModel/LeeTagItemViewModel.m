//
//  LeeTagItemViewModel.m
//  TagViewDemo
//
//  Created by mac on 2019/1/7.
//  Copyright © 2019年 YWKJ. All rights reserved.
//

#import "LeeTagItemViewModel.h"

// text
static CGFloat defaultFontSize = 13.0f;  // 默认字体大小

// layer
static CGFloat defaultBorderWidth = 1.0f; // 默认边线宽度
static CGFloat defaultCornerRadius = 3.0f; // 默认圆角

// padding
static CGFloat defaultPaddingLeft = 10.0f; // 默认左边距
static CGFloat defaultPaddingRight = 10.0f; // 默认右边距
static CGFloat defaultPaddingTop = 10.0f; // 默认上边距
static CGFloat defaultPaddingBottom = 10.0f; // 默认下边距
static CGFloat defaultImageAndLabelPadding = 10.0f; // 默认图片和文字间距

// image
static CGFloat defaultImageHeightWidthHeight = 15.0f; // 默认图片宽高

@implementation LeeTagItemViewModel

/**
 初始化
 
 @return viewmodel
 */
-(instancetype)init
{
    self = [super init];
    if (self)
    {
        
        self.selected = NO;
        self.disable = NO;
        
        // padding
        self.contentPadding = UIEdgeInsetsMake(defaultPaddingTop,
                                               defaultPaddingLeft,
                                               defaultPaddingBottom,
                                               defaultPaddingRight);
        self.imageAndLabelPadding = defaultImageAndLabelPadding;
        self.imageHeightAndWidth = defaultImageHeightWidthHeight;
        
        // normal
        self.normalFontSize = defaultFontSize;
        self.normalColor = [UIColor blackColor];
        self.normalBGColor = [UIColor whiteColor];
        self.normalBorderColor = [UIColor orangeColor];
        self.normalBorderWidth = defaultBorderWidth;
        self.normalCornerRadius = defaultCornerRadius;
        
        // selected
        self.selectedFontSize = defaultFontSize;
        self.selectedColor = [UIColor blackColor];
        self.selectedBGColor = [UIColor whiteColor];
        self.selectedBorderColor = [UIColor orangeColor];
        self.selectedBorderWidth = defaultBorderWidth;
        self.selectedCornerRadius = defaultCornerRadius;
        
        // disable
        self.disableFontSize = defaultFontSize;
        self.disableColor = [UIColor blackColor];
        self.disableBGColor = [UIColor whiteColor];
        self.disableBorderColor = [UIColor orangeColor];
        self.disableBorderWidth = defaultBorderWidth;
        self.disableCornerRadius = defaultCornerRadius;
     
        // selectedDisable
        self.selectedDisableFontSize = defaultFontSize;
        self.selectedDisableColor = [UIColor blackColor];
        self.selectedDisableBGColor = [UIColor whiteColor];
        self.selectedDisableBorderColor = [UIColor orangeColor];
        self.selectedDisableBorderWidth = defaultBorderWidth;
        self.selectedDisableCornerRadius = defaultCornerRadius;
        
    }
    return self;
}


@end
