//
//  LeeTagViewModel.m
//  TagViewDemo
//
//  Created by YWKJ on 2018/9/4.
//  Copyright © 2018年 YWKJ. All rights reserved.
//

#import "LeeTagViewModel.h"

// 默认初始值
static CGFloat kTagTextFontSize = 13.0f;  // 字体 大小
static CGFloat kTagBorderWidth = 1.0f; // 边线宽度

@implementation LeeTagViewModel

-(instancetype)init{
    self = [super init];
    if (self) {
        _tagBgColor = [UIColor whiteColor]; // 默认 背景颜色
        _tagTextFontSize = kTagTextFontSize; // 默认 字体大小
        _tagTextColor = [UIColor blackColor]; // 默认 字体颜色
        _tagBorderColor = [UIColor orangeColor]; // 默认 边线颜色
        _tagBorderWidth = kTagBorderWidth; // 默认 边线宽度
        _enable = YES; // 是否可用 默认 可用
    }
    return self;
}
@end
