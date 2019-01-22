//
//  LeeTagItem.m
//  TagViewDemo
//
//  Created by mac on 2019/1/7.
//  Copyright © 2019年 YWKJ. All rights reserved.
//

#import "LeeTagItem.h"
#import "leeTagItemViewModel.h"

#pragma mark -
#pragma mark Static

// image
static float Item_Image_MaxHeight = 15.0f;  // image 最大高度
static float Item_Image_WidhtAndHeightScale = 1.0f; // image 宽高比

// padding
static float Item_Padding_Left = 10.0f; // item 左内距
static float Item_Padding_Right = 10.0f; // item 右内距
static float Item_Padding_Top = 10.0f; // item 上内距
static float Item_Padding_Bottom = 10.0f; // item 下内距
static float Item_Image_Label_Padding = 10.0f; // item 图片和文本 间距

// state
typedef enum : NSUInteger {
    LeeTagItemStateNormal = 0, // 正常状态 (未选中、未禁用)
    LeetagItemStateSelected = 1, // 选中状态 (选中、未禁用)
    LeetagitemStateDisable = 2, // 禁用状态 (未选中、禁用)
    LeeTagItemStateSelectedDisable = 3, // 选中禁用（选中、禁用）
} LeeTagItemState; // 状态

#pragma mark -
#pragma mark Interface

@interface LeeTagItem()

// 子View
@property (nonatomic, strong) UIImageView * itemImageView; // 图片ImageView
@property (nonatomic, strong) UILabel * itemLabel; // 文本Label
@property (nonatomic, strong) UIImageView * backgroundImageView; // 背景图片ImageView

// 图片约束
@property (nonatomic, strong) NSLayoutConstraint * imageLeftConstraint; // 图片左约束
@property (nonatomic, strong) NSLayoutConstraint * imageHeightConstraint; // 图片高约束
@property (nonatomic, strong) NSLayoutConstraint * imageWidhtConstraint; // 图片宽约束
@property (nonatomic, strong) NSLayoutConstraint * imageCenterYConstraint; // 图片Y约束

// 文本约束
@property (nonatomic, strong) NSLayoutConstraint * labelRightConstraint; // 文本右约束
@property (nonatomic, strong) NSLayoutConstraint * labelTopConstraint; // 文本上约束
@property (nonatomic, strong) NSLayoutConstraint * labelBottomConstraint; // 文本下约束
@property (nonatomic, strong) NSLayoutConstraint * labelLeftConstraint; // 文本左约束

// 状态
@property (nonatomic, assign) LeeTagItemState itemState; // 状态

// 数据模型
@property (nonatomic, strong) LeeTagItemViewModel * itemViewModel; // 数据模型

@end

#pragma mark -
#pragma mark Implementation

@implementation LeeTagItem

#pragma mark -
#pragma mark Init

/**
 重写 Init 方法
 
 @return LeeTagItem
 */
-(instancetype)init
{
    self = [super init];
    if (self)
    {
        self.selected = NO;
        self.disable = YES;
        // 背景图片
        self.backgroundImageView = [[UIImageView alloc]init];
        [self addSubview:self.backgroundImageView];
        [self addBackgroundImageVIewConstraint];
        self.backgroundImageView.userInteractionEnabled = YES;
        // 图片
        self.itemImageView = [[UIImageView alloc]init];
        [self addSubview:self.itemImageView];
        [self addItemImageViewConstraint];
        self.itemImageView.userInteractionEnabled = YES;
        // 文字
        self.itemLabel = [[UILabel alloc]init];
        [self addSubview:self.itemLabel];
        [self addItemLabelConstraint];
        self.itemLabel.userInteractionEnabled = YES;
    }
    return self;
}

/**
 初始化方法
 
 @param itemViewModel LeeTagItemViewModel
 @return LeeTagItem 对象
 */
+(LeeTagItem *)tagItemWithItemViewModel:(LeeTagItemViewModel *)itemViewModel
{
    LeeTagItem * tagItem = [[LeeTagItem alloc]init];
    tagItem.itemViewModel = itemViewModel;
    [tagItem addObserver:tagItem forKeyPath:@"selected" options:NSKeyValueObservingOptionNew context:nil];
    [tagItem addObserver:tagItem forKeyPath:@"disable" options:NSKeyValueObservingOptionNew context:nil];
    return tagItem;
}

/**
 设置点击事件
 
 @param target 目标
 @param action 方法
 */
-(void)addTapTarget:(id)target action:(SEL)action
{
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:target action:action];
    [self addGestureRecognizer:tap];
}

#pragma mark -
#pragma mark Constraint

/**
 添加背景图约束
 */
-(void)addBackgroundImageVIewConstraint
{
    
    // 为了避免和系统生成的自动伸缩的约束不冲突
    [self.backgroundImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    // 约束子View的上下左右之类的，要添加到父View
    // 约束子View的宽高，要添加到子View本身
    
    // 左边距
    NSLayoutConstraint * leftC = [NSLayoutConstraint constraintWithItem:self.backgroundImageView // 约束方 1
                                                              attribute:NSLayoutAttributeLeft // 约束方 1 约束 属性
                                                              relatedBy:NSLayoutRelationEqual // 约束关系 小于、相等、大于
                                                                 toItem:self // 约束方 2
                                                              attribute:NSLayoutAttributeLeft // 约束方 2 约束 属性
                                                             multiplier:1 // 系数
                                                               constant:0]; // 偏移量
    [self addConstraint:leftC];
    
    // 右边距
    NSLayoutConstraint * rightC = [NSLayoutConstraint constraintWithItem:self
                                                               attribute:NSLayoutAttributeRight
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self.backgroundImageView
                                                               attribute:NSLayoutAttributeRight
                                                              multiplier:1
                                                                constant:0];
    [self addConstraint:rightC];
    
    // 上边距
    NSLayoutConstraint * topC = [NSLayoutConstraint constraintWithItem:self.backgroundImageView
                                                             attribute:NSLayoutAttributeTop
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self
                                                             attribute:NSLayoutAttributeTop
                                                            multiplier:1
                                                              constant:0];
    [self addConstraint:topC];
    
    // 下边距
    NSLayoutConstraint * bottomC = [NSLayoutConstraint constraintWithItem:self
                                                                attribute:NSLayoutAttributeBottom
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:self.backgroundImageView
                                                                attribute:NSLayoutAttributeBottom
                                                               multiplier:1
                                                                 constant:0];
    [self addConstraint:bottomC];
}

/**
 添加imageView约束
 */
-(void)addItemImageViewConstraint
{
    
    [self.itemImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    // 图片左约束 贴 item 左边
    _imageLeftConstraint = [NSLayoutConstraint constraintWithItem:self.itemImageView
                                                        attribute:NSLayoutAttributeLeft
                                                        relatedBy:0
                                                           toItem:self
                                                        attribute:NSLayoutAttributeLeft
                                                       multiplier:1
                                                         constant:Item_Padding_Left];
    [self addConstraint:_imageLeftConstraint];
    
    // Y约束
    _imageCenterYConstraint = [NSLayoutConstraint constraintWithItem:self.itemImageView
                                                           attribute:NSLayoutAttributeCenterY
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:self
                                                           attribute:NSLayoutAttributeCenterY
                                                          multiplier:1
                                                            constant:0];
    [self addConstraint:_imageCenterYConstraint];
    
    // 图片高约束 最大高度
    _imageHeightConstraint = [NSLayoutConstraint constraintWithItem:self.itemImageView
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationLessThanOrEqual
                                                             toItem:nil
                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                         multiplier:1
                                                           constant:Item_Image_MaxHeight];
    [self.itemImageView addConstraint:_imageHeightConstraint];
    
    // 图片宽度约束 宽高比例
    _imageWidhtConstraint= [NSLayoutConstraint constraintWithItem:self.itemImageView
                                                        attribute:NSLayoutAttributeWidth
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.itemImageView
                                                        attribute:NSLayoutAttributeHeight
                                                       multiplier:Item_Image_WidhtAndHeightScale
                                                         constant:0];
    [self.itemImageView addConstraint:_imageWidhtConstraint];
}

/**
 添加label约束
 */
-(void)addItemLabelConstraint
{
    [self.itemLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    // label 右约束
    _labelRightConstraint = [NSLayoutConstraint constraintWithItem:self
                                                         attribute:NSLayoutAttributeRight
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self.itemLabel
                                                         attribute:NSLayoutAttributeRight
                                                        multiplier:1
                                                          constant:Item_Padding_Right];
    [self addConstraint:_labelRightConstraint];
    
    // label 上约束
    _labelTopConstraint = [NSLayoutConstraint constraintWithItem:self.itemLabel
                                                       attribute:NSLayoutAttributeTop
                                                       relatedBy:NSLayoutRelationEqual
                                                          toItem:self
                                                       attribute:NSLayoutAttributeTop
                                                      multiplier:1
                                                        constant:Item_Padding_Top];
    [self addConstraint:_labelTopConstraint];
    
    // label 下约束
    _labelBottomConstraint = [NSLayoutConstraint constraintWithItem:self
                                                          attribute:NSLayoutAttributeBottom
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.itemLabel
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1
                                                           constant:Item_Padding_Bottom];
    [self addConstraint:_labelBottomConstraint];
    
    // label 左约束
    _labelLeftConstraint = [NSLayoutConstraint constraintWithItem:self.itemLabel
                                                        attribute:NSLayoutAttributeLeft
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.itemImageView
                                                        attribute:NSLayoutAttributeRight
                                                       multiplier:1
                                                         constant:Item_Image_Label_Padding];
    [self addConstraint:_labelLeftConstraint];
}

#pragma mark -
#pragma mark SET/GET

/**
 GET ViewModel

 @return viewmodel
 */
-(LeeTagItemViewModel *)viewModel
{
    return _itemViewModel;
}

/**
 重写intrinsicContentSize

 @return 获取内置大小
 */
-(CGSize)intrinsicContentSize
{
    // 文本大小
    CGSize labelSize = self.itemLabel.intrinsicContentSize;
    // 宽 == 图片宽 + 文本宽 + 图片左 + 文本左 + 文本右
    // 高 == 文本高 > 图片高 ？ 文本高 : 图片高 + 文本上 + 文本下
    CGFloat height = labelSize.height > _imageHeightConstraint.constant ? labelSize.height : _imageHeightConstraint.constant;
    return CGSizeMake(_imageHeightConstraint.constant
                      + labelSize.width
                      + _imageLeftConstraint.constant
                      + _labelLeftConstraint.constant
                      + _labelRightConstraint.constant,
                      height
                      + _labelTopConstraint.constant
                      + _labelBottomConstraint.constant);
}

/**
 设置viewModel
 
 @param itemViewModel viewModel
 */
-(void)setItemViewModel:(LeeTagItemViewModel *)itemViewModel
{
    _itemViewModel = itemViewModel;
    [self setUpPadding];
    self.selected = itemViewModel.selected;
    self.disable = itemViewModel.disable;
}

/**
 设置selected状态
 
 @param selected 是否选中
 */
-(void)setSelected:(BOOL)selected
{
    _selected = selected;
    [self changeItemState];
}

/**
 设置disable状态
 
 @param disable 是否选中
 */
-(void)setDisable:(BOOL)disable
{
    _disable = disable;
    [self changeItemState];
}

/**
 设置itemState状态
 
 @param itemState item状态
 */
-(void)setItemState:(LeeTagItemState)itemState
{
    _itemState = itemState;
    [self changeShow];
}

#pragma mark -
#pragma mark Action

/**
 修改状态
 */
-(void)changeItemState
{
    // 根据 selected 和 disable 状态修改 state
    if (self.selected && self.disable) // 选中 并且 禁用
    {
        self.itemState = LeeTagItemStateSelectedDisable; // 选中禁用
    }
    else if (!self.selected && self.disable) // 未选中 并且 禁用
    {
        self.itemState = LeetagitemStateDisable; // 禁用
    }
    else if (self.selected && !self.disable) // 选中 并且 未禁用
    {
        self.itemState = LeetagItemStateSelected; // 选中
    }
    else if (!self.selected && !self.disable) // 未选中 并且 未禁用
    {
        self.itemState = LeeTagItemStateNormal; // 正常
    }
}

/**
 修改页面展示
 */
-(void)changeShow
{
    CGFloat tempCornerRadius;
    CGFloat tempBorderWidth;
    UIColor * tempBorderColor;
    UIColor * tempBGColor;
    UIImage * tempBGImage;
    NSString * tempTitle;
    CGFloat tempTitleFontSize;
    UIFont * tempTitleFont;
    UIColor * tempTitleColor;
    NSAttributedString * tempAttributeTitle;
    UIImage * tempImage;
    switch (self.itemState)
    {
        case LeeTagItemStateNormal:
            tempCornerRadius = _itemViewModel.normalCornerRadius;
            tempBorderWidth = _itemViewModel.normalBorderWidth;
            tempBorderColor = _itemViewModel.normalBorderColor;
            tempBGColor = _itemViewModel.normalBGColor;
            tempBGImage = _itemViewModel.normalBGImage;
            tempTitle = _itemViewModel.normalTitle;
            tempTitleFontSize = _itemViewModel.normalFontSize;
            tempTitleFont = _itemViewModel.normalFont;
            tempTitleColor = _itemViewModel.normalColor;
            tempAttributeTitle = _itemViewModel.normalAttributeTitle;
            tempImage = _itemViewModel.normalImage;
            break;
        case LeetagItemStateSelected:
            tempCornerRadius = _itemViewModel.selectedCornerRadius;
            tempBorderWidth = _itemViewModel.selectedBorderWidth;
            tempBorderColor = _itemViewModel.selectedBorderColor;
            tempBGColor = _itemViewModel.selectedBGColor;
            tempBGImage = _itemViewModel.selectedBGImage;
            tempTitle = _itemViewModel.selectedTitle;
            tempTitleFontSize = _itemViewModel.selectedFontSize;
            tempTitleFont = _itemViewModel.selectedFont;
            tempTitleColor = _itemViewModel.selectedColor;
            tempAttributeTitle = _itemViewModel.selectedAttributeTitle;
            tempImage = _itemViewModel.selectedImage;
            break;
        case LeetagitemStateDisable:
            tempCornerRadius = _itemViewModel.disableCornerRadius;
            tempBorderWidth = _itemViewModel.disableBorderWidth;
            tempBorderColor = _itemViewModel.disableBorderColor;
            tempBGColor = _itemViewModel.disableBGColor;
            tempBGImage = _itemViewModel.disableBGImage;
            tempTitle = _itemViewModel.disableTitle;
            tempTitleFontSize = _itemViewModel.disableFontSize;
            tempTitleFont = _itemViewModel.disableFont;
            tempTitleColor = _itemViewModel.disableColor;
            tempAttributeTitle = _itemViewModel.disableAttributeTitle;
            tempImage = _itemViewModel.disableImage;
            break;
        case LeeTagItemStateSelectedDisable:
            tempCornerRadius = _itemViewModel.selectedDisableCornerRadius;
            tempBorderWidth = _itemViewModel.selectedDisableBorderWidth;
            tempBorderColor = _itemViewModel.selectedDisableBorderColor;
            tempBGColor = _itemViewModel.selectedDisableBGColor;
            tempBGImage = _itemViewModel.selectedDisableBGImage;
            tempTitle = _itemViewModel.selectedDisableTitle;
            tempTitleFontSize = _itemViewModel.selectedDisableFontSize;
            tempTitleFont = _itemViewModel.selectedDisableFont;
            tempTitleColor = _itemViewModel.selectedDisableColor;
            tempAttributeTitle = _itemViewModel.selectedDisableAttributeTitle;
            tempImage = _itemViewModel.selectedDisableImage;
            break;
        default:
            break;
    }
    
    // 背景
    self.layer.cornerRadius = tempCornerRadius;
    self.layer.borderWidth = tempBorderWidth;
    if (tempBorderColor)
    {
        self.layer.borderColor = tempBorderColor.CGColor;
    }
    if (tempBGColor)
    {
        self.backgroundColor = tempBGColor;
    }
    self.backgroundColor = tempBGColor;
    if (tempBGImage)
    {
        self.backgroundImageView.hidden = NO;
        self.backgroundImageView.image = tempBGImage;
    }
    else
    {
        self.backgroundImageView.hidden = YES;
    }
    
    // 文本
    self.itemLabel.text = tempTitle;
    self.itemLabel.font = [UIFont systemFontOfSize:tempTitleFontSize];
    if (tempTitleFont)
    {
        self.itemLabel.font = tempTitleFont;
    }
    if (tempTitleColor) {
        self.itemLabel.textColor = tempTitleColor;
    }
    
    // 富文本
    if (tempAttributeTitle)
    {
        self.itemLabel.attributedText = tempAttributeTitle;
    }
    
    // 图片
    if (tempImage)
    {
        [self hideImage:NO];
        self.itemImageView.image = tempImage;
    }
    else
    {
        [self hideImage:YES];
    }
    
    [self setNeedsLayout];
    
    [self layoutIfNeeded];
    
    [self invalidateIntrinsicContentSize];
    
}

/**
 设置padding
 */
-(void)setUpPadding
{
    _imageLeftConstraint.constant = _itemViewModel.contentPadding.left;

    _labelTopConstraint.constant = _itemViewModel.contentPadding.top;
    _labelRightConstraint.constant = _itemViewModel.contentPadding.right;
    _labelBottomConstraint.constant = _itemViewModel.contentPadding.bottom;
    
    _imageHeightConstraint.constant = _itemViewModel.imageHeightAndWidth;
    
    _labelLeftConstraint.constant = _itemViewModel.imageAndLabelPadding;
    
    [self setNeedsLayout];
    
}

/**
 是否隐藏图片
 
 @param hideImage 是否隐藏 yes 隐藏 no 不隐藏
 */
-(void)hideImage:(BOOL)hideImage
{
    
    if (hideImage) // 如果隐藏图片，约束要归0
    {
        _imageHeightConstraint.constant = 0.0f;
        _labelLeftConstraint.constant = 0.0f;
    }
    else // 如果显示图片，根据ViewModel重塑约束
    {
        _imageHeightConstraint.constant = _itemViewModel.imageHeightAndWidth;
        _labelLeftConstraint.constant = _itemViewModel.imageAndLabelPadding;
    }
    
    [self setNeedsLayout];
}

#pragma mark -
#pragma mark KVO Observer

/**
 KVO 监听
 
 @param keyPath 属性名称
 @param object 监听对象
 @param change 改变
 @param context 上下文
 */
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if (object == self
        &&
        [keyPath isEqualToString:@"selected"]) // 监听selected属性变化
    {
        self.itemViewModel.selected = self.selected;
    }
    else if (object == self
             &&
             [keyPath isEqualToString:@"disable"]) // 监听disable属性变化
    {
        self.itemViewModel.disable = self.disable;
    }
}

@end
