//
//  LeeTagButton.m
//  TagViewDemo
//
//  Created by YWKJ on 2018/9/4.
//  Copyright © 2018年 YWKJ. All rights reserved.
//

#import "LeeTagButton.h"
#import "LeeTagViewModel.h"

@interface LeeTagButton()

@end

@implementation LeeTagButton
#pragma mark -
#pragma mark Init
+(LeeTagButton *)tagButtonWithTagViewModel:(LeeTagViewModel *)tagViewModel{
    // 初始化 Button
    LeeTagButton * tagButton = [super buttonWithType:UIButtonTypeCustom];
    // 赋值 TagViewModel
    tagButton.tagViewModel = tagViewModel;
    // 注册 KVO 监听 Button 的点击状态变化
    [tagButton addObserver:tagButton forKeyPath:@"selected" options:NSKeyValueObservingOptionNew context:nil];
    return tagButton;
}
#pragma mark -
#pragma mark Rewrite UIButton
/**
 重写内容宽高方法

 @return 内容宽高
 */
-(CGSize)intrinsicContentSize{
    // 因为设置了titleEdgeInsets，如果不重写该方法可能会造成文字显示不全，也就是sizeFit效果不一定还会存在哟。
    CGSize size = [super intrinsicContentSize];
    CGFloat width = size.width + self.titleEdgeInsets.left + self.titleEdgeInsets.right;
    CGFloat height = size.height + self.titleEdgeInsets.top + self.titleEdgeInsets.bottom;
    return CGSizeMake(width, height);
}
#pragma mark -
#pragma mark SET/GET
-(void)setTagViewModel:(LeeTagViewModel *)tagViewModel{
    _tagViewModel = tagViewModel;
    // 根据 TagViewModel 设置 Button 样式
    [self setUpButtonTextProperty:tagViewModel]; // 文字类属性
    [self setUpButtonImageProperty:tagViewModel]; // 图片类属性
    [self setUpButtonBgProperty:tagViewModel]; // 背景类属性
    [self setUpButtonEdgeInsets:tagViewModel]; // 边距类属性
    [self setUpButtonStatus:tagViewModel]; // 状态类属性
    [self setUpButtonBase:tagViewModel]; // 其他类属性
    [self setUpButtonLayer:tagViewModel]; // layer类属性
}
#pragma mark -
#pragma mark KVO Observer
// KVO 监听Button的点击状态变化
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    // 当Button的Selected属性发生变化时
    if (object == self && [keyPath isEqualToString:@"selected"]) {
        self.tagViewModel.isSelect = self.selected;
        // 根据Selected属性来改变 Button的样式
        if (self.selected) {
            if (self.tagViewModel.tagSelectBorderColor) // 如果有设置过 选中状态的 BorderColor
            {
                self.layer.borderColor = self.tagViewModel.tagSelectBorderColor.CGColor;
            }
        }else{
            if (self.tagViewModel.tagBorderColor) // 如果 有设置过 未选中状态 BorderColor
            {
                self.layer.borderColor = self.tagViewModel.tagBorderColor.CGColor;
            }
        }
    }
}
#pragma mark -
#pragma mark SetUp

/**
 设置 Button 的一些基本参数
 @param tagViewModel 可以为空，暂时没用上
 */
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

/**
 设置 Button 的 Layer 属性

 @param tagViewModel 数据模型对象
 */
-(void)setUpButtonLayer:(LeeTagViewModel *)tagViewModel{
    
    self.layer.borderWidth = tagViewModel.tagBorderWidth;
    self.layer.cornerRadius = tagViewModel.tagCornerRadius;
    
    if (tagViewModel.isSelect) // 数据是否是选中状态
    {
        if (tagViewModel.tagSelectBorderColor) // 如果有设置过 选中状态的 BorderColor
        {
            self.layer.borderColor = tagViewModel.tagSelectBorderColor.CGColor;
        }
    }
    else // 数据非选中状态
    {
        if (tagViewModel.tagBorderColor) // 如果 有设置过 未选中状态 BorderColor
        {
            self.layer.borderColor = tagViewModel.tagBorderColor.CGColor;
        }
    }// 结束 数据是否选中状态 判断
    
    self.layer.masksToBounds = YES;
}

/**
 设置 Button 的 状态 属性

 @param tagViewModel 数据模型对象
 */
-(void)setUpButtonStatus:(LeeTagViewModel *)tagViewModel{
    self.selected = tagViewModel.isSelect;
    self.enabled = tagViewModel.enable;
}

/**
 设置 Button 的 内边距 属性

 @param tagViewModel 数据模型对象
 */
-(void)setUpButtonEdgeInsets:(LeeTagViewModel *)tagViewModel{
    // padding
    CGFloat left = tagViewModel.contentPadding.left;
    CGFloat right = tagViewModel.contentPadding.right;
    CGFloat top = tagViewModel.contentPadding.top;
    CGFloat bottom = tagViewModel.contentPadding.bottom;
    CGFloat imageAndLabelPadding = tagViewModel.imageAndLabelPadding;
    self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    self.imageEdgeInsets = UIEdgeInsetsMake(top, left, bottom, right);
    self.titleEdgeInsets = UIEdgeInsetsMake(top, left + imageAndLabelPadding, bottom, right);
}

/**
 设置 Button 的 背景 属性

 @param tagViewModel 数据模型对象
 */
-(void)setUpButtonBgProperty:(LeeTagViewModel *)tagViewModel{
    // background color
    // 设置背景颜色不能根据状态改变，所以先把颜色改成image,再通过image进行设定
    if (tagViewModel.tagBgColor) {
        [self setBackgroundImage:[self getImageWithColor:tagViewModel.tagBgColor]
                        forState:UIControlStateNormal];
    }
    if (tagViewModel.tagSelectBgColor) {
        [self setBackgroundImage:[self getImageWithColor:tagViewModel.tagSelectBgColor]
                        forState:UIControlStateSelected];
    }
    if (tagViewModel.tagHighLightedBgColor) {
        [self setBackgroundImage:[self getImageWithColor:tagViewModel.tagHighLightedBgColor]
                        forState:UIControlStateHighlighted];
    }
    if (tagViewModel.tagDisableBgColor) {
        [self setBackgroundImage:[self getImageWithColor:tagViewModel.tagDisableBgColor]
                        forState:UIControlStateDisabled];
    }
    
    // background image
    if (tagViewModel.tagBgImage) {
        [self setBackgroundImage:tagViewModel.tagBgImage
                        forState:UIControlStateNormal];
    }
    if (tagViewModel.tagSelectBgImage) {
        [self setBackgroundImage:tagViewModel.tagSelectBgImage
                        forState:UIControlStateSelected];
    }
    if (tagViewModel.tagHighLightedBgImage) {
        [self setBackgroundImage:tagViewModel.tagHighLightedBgImage
                        forState:UIControlStateHighlighted];
    }
    if (tagViewModel.tagDisableBgImage) {
        [self setBackgroundImage:tagViewModel.tagDisableBgImage
                        forState:UIControlStateDisabled];
    }
}

/**
 设置 Button 的 文本属性

 @param tagViewModel viewmodel
 */
-(void)setUpButtonTextProperty:(LeeTagViewModel *)tagViewModel{
    
    // text normal
    if (tagViewModel.tagAttributedText) // 是否 设置过 未选中状态下 的富文本
    {
        [self setAttributedTitle:tagViewModel.tagAttributedText
                        forState:UIControlStateNormal];
    }
    else // 未设置过 选中状态下的 富文本 ，采取常规文本设置
    {
        self.titleLabel.font = tagViewModel.tagTextFont ? tagViewModel.tagTextFont : [UIFont systemFontOfSize:tagViewModel.tagTextFontSize];
        if (tagViewModel.tagText)
        {
            [self setTitle:tagViewModel.tagText
                  forState:UIControlStateNormal];
        }
        if (tagViewModel.tagTextColor)
        {
            [self setTitleColor:tagViewModel.tagTextColor
                       forState:UIControlStateNormal];
        }
    }// 结束 未选中状态下 富文本判断
    
    // text select
    if (tagViewModel.tagSelectAttributedText) // 是否 设置过 选中状态下 的富文本
    {
        [self setAttributedTitle:tagViewModel.tagSelectAttributedText
                        forState:UIControlStateSelected];
    }
    else
    {
        if (tagViewModel.tagSelectTextColor)
        {
            [self setTitleColor:tagViewModel.tagSelectTextColor forState:UIControlStateSelected];
        }
    }// 结束 选中状态下 富文本判断
    
    // text highlight
    if (tagViewModel.tagHighLightAttributedText)// 是否 设置过 高亮状态下 的富文本
    {
        [self setAttributedTitle:tagViewModel.tagHighLightAttributedText
                        forState:UIControlStateSelected];
    }
    else
    {
        if (tagViewModel.tagHighLightTextColor)
        {
            [self setTitleColor:tagViewModel.tagHighLightTextColor forState:UIControlStateSelected];
        }
    }// 结束 高亮状态下 富文本判断
    
    // text disable
    if (tagViewModel.tagDisableAttributedText)// 是否 设置过 禁用状态下 的富文本
    {
        [self setAttributedTitle:tagViewModel.tagDisableAttributedText forState:UIControlStateSelected];
    }
    else
    {
        if (tagViewModel.tagDisableTextColor)
        {
            [self setTitleColor:tagViewModel.tagDisableTextColor forState:UIControlStateSelected];
        }
    }// 结束 禁用状态下 富文本判断
}

/**
 设置 Button 的 image 属性

 @param tagViewModel <#tagViewModel description#>
 */
-(void)setUpButtonImageProperty:(LeeTagViewModel *)tagViewModel{
    
    if (tagViewModel.tagImage)
    {
        [self setImage:tagViewModel.tagImage
              forState:UIControlStateNormal];
    }
    
    if (tagViewModel.tagSelectImage)
    {
        [self setImage:tagViewModel.tagSelectImage
              forState:UIControlStateSelected];
    }
    
    if (tagViewModel.tagHighLightImage)
    {
        [self setImage:tagViewModel.tagHighLightImage
              forState:UIControlStateHighlighted];
    }
    
    if (tagViewModel.tagDisableImage)
    {
        [self setImage:tagViewModel.tagDisableImage
              forState:UIControlStateDisabled];
    }
}
#pragma mark -
#pragma mark Tools

/**
 通过颜色 获取 图片

 @param color 想要生成图片的颜色
 @return 根据颜色生成的图片
 */
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
