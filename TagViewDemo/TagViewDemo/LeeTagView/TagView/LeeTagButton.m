//
//  LeeTagButton.m
//  TagViewDemo
//
//  Created by YWKJ on 2018/9/4.
//  Copyright © 2018年 YWKJ. All rights reserved.
//

#import "LeeTagButton.h"

@implementation LeeTagButton
+(LeeTagButton *)tagButtonWithTagViewModel:(LeeTagViewModel *)tagViewModel{
    LeeTagButton * tagButton = [super buttonWithType:UIButtonTypeCustom];
    tagButton.tagViewModel = tagViewModel;
    [tagButton setUpButtonTextProperty:tagViewModel]; // 文字类属性
    [tagButton setUpButtonBgProperty:tagViewModel]; // 背景类属性
    [tagButton setUpButtonEdgeInsets:tagViewModel]; // 边距类属性
    [tagButton setUpButtonStatus:tagViewModel]; // 状态类属性
    [tagButton setUpButtonBase:tagViewModel]; // 其他类属性
    [tagButton setUpButtonLayer:tagViewModel]; // layer类属性
    
    [tagButton addObserver:tagButton forKeyPath:@"selected" options:NSKeyValueObservingOptionNew context:nil];
    return tagButton;
}
// 重写 UIButton 设置 imageView Rect 的方法
-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGFloat height = contentRect.size.height / 2;
    CGFloat width = height;
    CGFloat x = 10;
    CGFloat y = (contentRect.size.height - height) / 2;
    return CGRectMake(x, y, width, height);
}
-(void)setTagViewModel:(LeeTagViewModel *)tagViewModel{
    _tagViewModel = tagViewModel;
    
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if (object == self && [keyPath isEqualToString:@"selected"]) {
        if (self.selected) {
            if (self.tagViewModel.tagBorderColor) {
                self.layer.borderColor = self.tagViewModel.tagBorderColor.CGColor;
            }
        }else{
            if (self.tagViewModel.tagSelectBorderColor) {
                self.layer.borderColor = self.tagViewModel.tagSelectBorderColor.CGColor;
            }
        }
    }
}
-(void)setUpButtonBase:(LeeTagViewModel *)tagViewModel{
    /*
     NSLineBreakByCharWrapping     以字符为显示单位显示，后面部分省略不显示。
     NSLineBreakByClipping         剪切与文本宽度相同的内容长度，后半部分被删除。
     NSLineBreakByTruncatingHead   前面部分文字以……方式省略，显示尾部文字内容。
     NSLineBreakByTruncatingMiddle 中间的内容以……方式省略，显示头尾的文字内容。
     NSLineBreakByTruncatingTail   结尾部分的内容以……方式省略，显示头的文字内容。
     NSLineBreakByWordWrapping     以单词为显示单位显示，后面部分省略不显示。
     */
    self.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
}
-(void)setUpButtonLayer:(LeeTagViewModel *)tagViewModel{
    self.layer.borderWidth = tagViewModel.tagBorderWidth;
    if (tagViewModel.isSelect) {
        if (tagViewModel.tagBorderColor) {
            self.layer.borderColor = tagViewModel.tagBorderColor.CGColor;
        }
    }else{
        if (tagViewModel.tagSelectBorderColor) {
            self.layer.borderColor = tagViewModel.tagSelectBorderColor.CGColor;
        }
    }
    self.layer.cornerRadius = tagViewModel.tagCornerRadius;
    self.layer.masksToBounds = YES;
}
-(void)setUpButtonStatus:(LeeTagViewModel *)tagViewModel{
    self.selected = tagViewModel.isSelect;
    self.enabled = tagViewModel.enable;
}
-(void)setUpButtonEdgeInsets:(LeeTagViewModel *)tagViewModel{
    // padding
    self.contentEdgeInsets = tagViewModel.contentPadding;
    
//    self.imageEdgeInsets = tagViewModel.imagePadding;
//    self.titleEdgeInsets = tagViewModel.titleEdgeInsets;
}
-(void)setUpButtonBgProperty:(LeeTagViewModel *)tagViewModel{
    // background color
    // 设置背景颜色不能根据状态改变，所以先把颜色改成image,再通过image进行设定
    if (tagViewModel.tagBgColor) {
        [self setBackgroundImage:[self getImageWithColor:tagViewModel.tagBgColor] forState:UIControlStateNormal];
    }
    if (tagViewModel.tagSelectBgColor) {
        [self setBackgroundImage:[self getImageWithColor:tagViewModel.tagSelectBgColor] forState:UIControlStateSelected];
    }
    if (tagViewModel.tagHighLightedBgColor) {
        [self setBackgroundImage:[self getImageWithColor:tagViewModel.tagHighLightedBgColor] forState:UIControlStateHighlighted];
    }
    if (tagViewModel.tagDisableBgColor) {
        [self setBackgroundImage:[self getImageWithColor:tagViewModel.tagDisableBgColor] forState:UIControlStateDisabled];
    }
    // background image
    if (tagViewModel.tagBgImage) {
        [self setBackgroundImage:tagViewModel.tagBgImage forState:UIControlStateNormal];
    }
    if (tagViewModel.tagSelectBgImage) {
        [self setBackgroundImage:tagViewModel.tagSelectBgImage forState:UIControlStateSelected];
    }
    if (tagViewModel.tagHighLightedBgImage) {
        [self setBackgroundImage:tagViewModel.tagHighLightedBgImage forState:UIControlStateHighlighted];
    }
    if (tagViewModel.tagDisableBgImage) {
        [self setBackgroundImage:tagViewModel.tagDisableBgImage forState:UIControlStateDisabled];
    }
}
-(void)setUpButtonTextProperty:(LeeTagViewModel *)tagViewModel{
    // text normal
    if (tagViewModel.tagAttributedText) {
        [self setAttributedTitle:tagViewModel.tagAttributedText forState:UIControlStateNormal];
    }else{
        self.titleLabel.font = tagViewModel.tagTextFont ?: [UIFont systemFontOfSize:tagViewModel.tagTextFontSize];
        if (tagViewModel.tagText) {
            [self setTitle:tagViewModel.tagText forState:UIControlStateNormal];
        }
        if (tagViewModel.tagTextColor) {
            [self setTitleColor:tagViewModel.tagTextColor forState:UIControlStateNormal];
        }
    }
    // text select
    if (tagViewModel.tagSelectAttributedText) {
        [self setAttributedTitle:tagViewModel.tagSelectAttributedText forState:UIControlStateSelected];
    }else{
//        self.titleLabel.font = tagViewModel.tagSelectTextFont ?: [UIFont systemFontOfSize:tagViewModel.tagSelectTextFontSize];
//        if (tagViewModel.tagSelectText) {
//            [self setTitle:tagViewModel.tagSelectText forState:UIControlStateSelected];
//        }
        if (tagViewModel.tagSelectTextColor) {
            [self setTitleColor:tagViewModel.tagSelectTextColor forState:UIControlStateSelected];
        }
    }
    // text highlight
    if (tagViewModel.tagHighLightAttributedText) {
        [self setAttributedTitle:tagViewModel.tagHighLightAttributedText forState:UIControlStateSelected];
    }else{
//        self.titleLabel.font = tagViewModel.tagSelectTextFont ?: [UIFont systemFontOfSize:tagViewModel.tagSelectTextFontSize];
//        if (tagViewModel.tagHighLightText) {
//            [self setTitle:tagViewModel.tagHighLightText forState:UIControlStateSelected];
//        }
        if (tagViewModel.tagHighLightTextColor) {
            [self setTitleColor:tagViewModel.tagHighLightTextColor forState:UIControlStateSelected];
        }
//        self.titleLabel.font = tagViewModel.tagHighLightTextFont ?: [UIFont systemFontOfSize:tagViewModel.tagHighLightTextFontSize];
    }
    // text disable
    if (tagViewModel.tagDisableAttributedText) {
        [self setAttributedTitle:tagViewModel.tagDisableAttributedText forState:UIControlStateSelected];
    }else{
//        self.titleLabel.font = tagViewModel.tagDisableTextFont ?: [UIFont systemFontOfSize:tagViewModel.tagDisableTextFontSize];
//        if (tagViewModel.tagDisableText) {
//            [self setTitle:tagViewModel.tagDisableText forState:UIControlStateSelected];
//        }
        if (tagViewModel.tagDisableTextColor) {
            [self setTitleColor:tagViewModel.tagDisableTextColor forState:UIControlStateSelected];
        }
    }
    
    if (tagViewModel.tagImage) {
        [self setImage:tagViewModel.tagImage forState:UIControlStateNormal];
    }
    if (tagViewModel.tagSelectImage) {
        [self setImage:tagViewModel.tagSelectImage forState:UIControlStateSelected];
    }
    if (tagViewModel.tagHighLightImage) {
        [self setImage:tagViewModel.tagHighLightImage forState:UIControlStateHighlighted];
    }
    if (tagViewModel.tagDisableImage) {
        [self setImage:tagViewModel.tagDisableImage forState:UIControlStateDisabled];
    }
}

-(UIImage *)getImageWithColor:(UIColor *)color{
    CGRect rect = CGRectMake(0, 0, 1, 1);// 描述矩形
    UIGraphicsBeginImageContext(rect.size);// 开启位图上下文
    CGContextRef context = UIGraphicsGetCurrentContext(); // 获取位图上下文
    CGContextSetFillColorWithColor(context, color.CGColor);// 使用color演示填充上下文
    CGContextFillRect(context, rect);// 渲染上下文
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();// 从上下文中获取图片
    UIGraphicsEndImageContext();// 结束上下文
    return image;
}

@end
