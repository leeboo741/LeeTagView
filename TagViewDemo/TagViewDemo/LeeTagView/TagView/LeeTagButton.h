//
//  LeeTagButton.h
//  TagViewDemo
//
//  Created by YWKJ on 2018/9/4.
//  Copyright © 2018年 YWKJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LeeTagViewModel;

@interface LeeTagButton : UIButton
/**
 初始化方法

 @param tagViewModel tagViewModel
 @return LeeTagButton 对象
 */
+(LeeTagButton *)tagButtonWithTagViewModel:(LeeTagViewModel *)tagViewModel;

@property (nonatomic, strong) LeeTagViewModel * tagViewModel; // 数据模型
@end
