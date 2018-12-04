//
//  LeeTagView.m
//  TagViewDemo
//
//  Created by YWKJ on 2018/9/4.
//  Copyright © 2018年 YWKJ. All rights reserved.
//
/*
 要做成自适应内容大小的View
 1.手动适应 计算内容的Size,再设置frame,实在很low
 2.自动适应 使用intrinsicContentSize属性
     instrinisicContentSize （固有大小）我知道自己的大小，如果你没有为我指定大小，我就按照自有大小排列
     UILabel/UIImageView/UIButton等这些组件以及某些包含他们的系统组件都具有此属性，遇到这些组件，你只需要为其指定位置即可。大小就使用Intrinsic Content Size就行了。
     上述系统控件都重写了UIView 中的 -(CGSize)intrinsicContentSize: 方法。
     并且在需要改变这个值的时候调用：invalidateIntrinsicContentSize 方法，通知系统这个值改变了
     编写继承自UIView的自定义组件时，也想要有Intrinsic Content Size的时候，就可以通过这种方法来轻松实现。
 */

#import "LeeTagView.h"

@interface LeeTagView()

@property (nonatomic, strong) NSMutableArray<LeeTagViewModel *> * tags;
@property (nonatomic, assign) BOOL didSetUp; // 是否设置,其实就是控制不要频繁的在layoutsubviews里面刷新，也是防着循环调用
@end

static CGFloat kItemSpacingH = 8.0f; // 水平间距
static CGFloat kItemSpacingV = 8.0f; // 垂直间距

@implementation LeeTagView
#pragma mark -
#pragma mark Rewrite
// 重写IntrinsicContentSize方法, 控制tagView的bounds
-(CGSize)intrinsicContentSize{
    // 如果内容为空，内容宽高坍缩成零点状态
    if (!self.tags.count) {
        return CGSizeZero;
    }
    // tagView padding
    CGFloat topPadding = self.tagViewPadding.top;
    CGFloat bottomPadding = self.tagViewPadding.bottom;
    CGFloat leftPadding = self.tagViewPadding.left;
    CGFloat rightPadding = self.tagViewPadding.right;
    // 上一个 tagItem
    UIView * preTagItem = nil;
    // X 光标 判断要不要换行能用的上
    CGFloat X = leftPadding;
    // 初始化 tagView 的内容宽度
    CGFloat intrinsicWidth = leftPadding;
    // 初始化 tagView 的内容高度
    CGFloat intrinsicHeight = topPadding;
    // 如果不是单行样式，并且tagView最大宽度超过0
    if (self.tagViewLineStyle != LeeTagViewLineStyleSingle
        && self.tagViewMaxWidth > 0)
    {
        // 行数
        NSInteger lineCount = 0;
        // 遍历 tagview 上的 itme
        for (UIView * tagItem in self.subviews) {
            // 获取 tagItem 的内容尺寸
            CGSize tagItemIntrinsicContentSize = tagItem.intrinsicContentSize;
            // 如果固定宽高不为 0 ，则使用固定宽高。否则使用 tagItem 自有内容宽高
            CGFloat width = (self.itemRegularWidth != 0 ? self.itemRegularWidth : tagItemIntrinsicContentSize.width);
            CGFloat height = (self.itemRegularHeight != 0 ? self.itemRegularHeight : tagItemIntrinsicContentSize.height);
            // 是否有上一个 item
            if (preTagItem)
            {
                // 当前 item宽度 + tagview距右宽度 + X 光标 是否在 tagview 最大宽度范围内
                if ((X + width + rightPadding) < self.tagViewMaxWidth)
                {
                    // 在范围内 不折行 光标移动 一个item距离
                    X += (width + self.itemSpacingH);
                }
                else // 超出最大宽度范围
                {
                    // 超出范围，折行
                    // 行数增加
                    lineCount ++;
                    // 光标归零 并移动一个 item 距离
                    X = (leftPadding + width + self.itemSpacingH);
                    // tagView 高度增加 一行 item 高度
                    intrinsicHeight += (height + self.itemSpacingV);
                } // 结束 范围 判断
            }
            else // 没有上一个 item
            {
                // 并无上一个item ,此item 为初始item
                // 行数加1
                lineCount ++;
                // tagView 高度增加 一行 item 高度
                intrinsicHeight += ( height + self.itemSpacingV );
                // 光标 归零 并移动 一个 item 距离
                X = width + leftPadding + self.itemSpacingH;
            } // 结束 上一个 item 的判断
            // 更新 上一个 item 为 当前 item
            preTagItem = tagItem;
            // 更新 tagView 内容宽度
            intrinsicWidth = MAX(intrinsicWidth, X + rightPadding);
        } // 结束 item 遍历
        // 更新 tagView 内容高度
        intrinsicHeight += bottomPadding;
    }
    else // 如果 是单行样式 或者 tagView最大宽度小于等于0
    {
        for (UIView * tagItem in self.subviews) {
            CGSize tagItemIntrinsicContentSize = tagItem.intrinsicContentSize;
            intrinsicWidth += ( self.itemRegularWidth != 0 ? self.itemRegularWidth : tagItemIntrinsicContentSize.width );
        }
        intrinsicWidth += ( self.itemSpacingH * (self.subviews.count - 1) + rightPadding );
        intrinsicHeight += ( ((UIView *)self.subviews.firstObject).intrinsicContentSize.height + bottomPadding );
    } // 结束 单行演示 和 最大宽度的 判断
    return CGSizeMake(intrinsicWidth, intrinsicHeight);
}
// 重写 layoutSubviews 方法
-(void)layoutSubviews{
    [self resetTags];
    if (self.tagViewLineStyle != LeeTagViewLineStyleSingle) {
        self.tagViewMaxWidth = self.frame.size.width;
    }
    [super layoutSubviews];
}

/**
 重置 刷新 tagview ，控制 tagItem 的frame
 */
-(void)resetTags{
    if (self.didSetUp || !self.tags.count)
    {
        return;
    }
    // 参照 intrinsicContentSize 方法
    // tagView padding
    CGFloat topPadding = self.tagViewPadding.top;
    CGFloat leftPadding = self.tagViewPadding.left;
    CGFloat rightPadding = self.tagViewPadding.right;
    // 上一个 TagItem
    UIView * preTagItem = nil;
    // X 光标 初始
    CGFloat X = leftPadding;
    // 如果不是单行样式，并且tagView最大宽度超过0
    if (self.tagViewLineStyle != LeeTagViewLineStyleSingle
        && self.tagViewMaxWidth > 0)
    {
        // 行数
        NSInteger lineCount = 0;
        // 遍历 tagView 上的 item
        for (UIView *tagItem in self.subviews)
        {
            CGSize tagItemIntrinsicContentSize = tagItem.intrinsicContentSize;
            // 如果固定宽高不为 0 ，则使用固定宽高。否则使用tagItem 自有内容
            CGFloat width = ( self.itemRegularWidth != 0 ? self.itemRegularWidth : tagItemIntrinsicContentSize.width );
            CGFloat height = ( self.itemRegularHeight != 0 ? self.itemRegularHeight : tagItemIntrinsicContentSize.height );
            // 是否有上一个item
            if (preTagItem)
            {
                // X 光标 + 内容距右边边距 + 当前item的 宽度 是否超过了最大宽度
                if ((X + width + rightPadding) < self.tagViewMaxWidth) // 范围内，不折行，行内追加
                {
                    // item 的 frame X == X光标 Y == 上一个Item的顶部坐标
                    tagItem.frame = CGRectMake(X,
                                               CGRectGetMinY(preTagItem.frame),
                                               width,
                                               height);
                    // 移动 X 光标
                    X += ( width + self.itemSpacingH );
                }
                else // 范围外，折行，重新归零
                {
                    // 行数+1
                    lineCount ++;
                    // X 光标归零
                    X = leftPadding;
                    // 获取宽度，在自有宽度和最大宽度减去左右边距中选择最小宽度
                    CGFloat itemWidth = MIN(width, self.tagViewMaxWidth - leftPadding - rightPadding);
                    // item 的 frame X = X 光标 Y == 上一个Item的底部坐标 + 垂直间距
                    tagItem.frame = CGRectMake(X,
                                               CGRectGetMaxY(preTagItem.frame) + self.itemSpacingV,
                                               itemWidth,
                                               height);
                    // 移动 X 光标
                    X += ( width + self.itemSpacingH );
                }
            }
            else // 没有上一个 Item
            {
                // 行数 +1
                lineCount ++;
                // 获取宽度，在自有宽度和最大宽度减去左右边距中选择最小宽度
                CGFloat itemWidth = MIN(width, self.tagViewMaxWidth - leftPadding - rightPadding);
                // item 的 frame X = X 光标 Y == 上一个Item的底部坐标 + 垂直间距
                tagItem.frame = CGRectMake(X,
                                           CGRectGetMaxY(preTagItem.frame) + self.itemSpacingV,
                                           itemWidth,
                                           height);
                X += ( width + self.itemSpacingH );
            } // preTagItem 判断
            preTagItem = tagItem;
        } // for item 循环
    }
    else // 如果是单行样式，或者tagView最大宽度小于等于0
    {
        // 移动
        for (UIView *tagItem in self.subviews)
        {
            CGSize tagItemIntrinsicContentSize = tagItem.intrinsicContentSize;
            
            tagItem.frame = CGRectMake(X,
                                       topPadding,
                                       self.itemRegularWidth != 0 ? self.itemRegularWidth : tagItemIntrinsicContentSize.width,
                                       self.itemRegularHeight != 0 ? self.itemRegularHeight : tagItemIntrinsicContentSize.height);
            // 移动光标
            X += ((self.itemRegularWidth != 0 ? self.itemRegularWidth : tagItemIntrinsicContentSize.width) + self.itemSpacingH);
        }
    }
    self.didSetUp = YES;
}

#pragma mark -
#pragma mark Set/Get
// item 水平间隔
-(CGFloat)itemSpacingH{
    if (_itemSpacingH == 0) {
        return kItemSpacingH;
    }
    return _itemSpacingH;
}
//item 垂直间隔
-(CGFloat)itemSpacingV{
    if (_itemSpacingV == 0) {
        return kItemSpacingV;
    }
    return _itemSpacingV;
}
//数据模型对象数组
-(NSMutableArray<LeeTagViewModel *> *)tags{
    if (!_tags) {
        _tags = [NSMutableArray array];
    }
    return _tags;
}
// 最大宽度
-(void)setTagViewMaxWidth:(CGFloat)tagViewMaxWidth{
    if (_tagViewMaxWidth != tagViewMaxWidth) {
        _tagViewMaxWidth = tagViewMaxWidth;
        _didSetUp = NO;
        [self invalidateIntrinsicContentSize];
    }
}
#pragma mark -
#pragma mark Tag Action
// tag Button 点击事件
-(void)tagButtonAction:(LeeTagButton *)tagButton{
    // 根据 选择样式 不同，做不同操作
    if (self.tagViewSelectionStyle == LeeTagViewStyleSelectSingle) // 单选
    {
        tagButton.selected = !tagButton.selected;
        // 取消其他按钮选中状态
        [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj,
                                                    NSUInteger idx,
                                                    BOOL * _Nonnull stop) {
            LeeTagButton * tempTagButton = (LeeTagButton *)obj;
            if (tagButton != tempTagButton)
            {
                tempTagButton.selected = NO;
            }
        }];
    }
    else if (self.tagViewSelectionStyle == LeeTagViewStyleSelectMulti) // 多选
    {
        tagButton.selected = !tagButton.selected;
    }
    else if (self.tagViewSelectionStyle == LeeTagViewStyleSelectDisable) // 禁用点击
    {
        
    } // 结束 选择样式 判断
    // delegate 往外通知点击事件
    if (self.delegate && [self.delegate respondsToSelector:@selector(leeTagView:tapTagButton:atIndex:)]) {
        [self.delegate leeTagView:self
                     tapTagButton:tagButton
                          atIndex:[self.subviews indexOfObject:tagButton]];
    }
}
#pragma mark -
#pragma mark Public Action
-(void)addTag:(LeeTagViewModel *)tag{
    NSParameterAssert(tag);
    LeeTagButton * tagButton = [LeeTagButton tagButtonWithTagViewModel:tag];
    [tagButton addTarget:self
                  action:@selector(tagButtonAction:)
        forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:tagButton];
    [self.tags addObject:tag];
    self.didSetUp = NO;
    [self invalidateIntrinsicContentSize];
}
-(void)insertTag:(LeeTagViewModel *)tag atIndex:(NSInteger)index{
    NSParameterAssert(tag);
    if (index + 1 > self.tags.count)
    {
        [self addTag:tag];
    }
    else
    {
        LeeTagButton * tagButton = [LeeTagButton tagButtonWithTagViewModel:tag];
        [tagButton addTarget:self
                      action:@selector(tagButtonAction:)
            forControlEvents:UIControlEventTouchUpInside];
        [self insertSubview:tagButton
                    atIndex:index];
        [self.tags insertObject:tag
                        atIndex:index];
        self.didSetUp = NO;
        [self invalidateIntrinsicContentSize];
    }
}
-(void)removeTag:(LeeTagViewModel *)tag{
    NSParameterAssert(tag);
    NSInteger index = [self.tags indexOfObject:tag];
    if (NSNotFound == index)
    {
        return;
    }
    [self.tags removeObjectAtIndex:index];
    if (self.subviews.count > index)
    {
        [self.subviews[index] removeFromSuperview];
    }
    self.didSetUp = NO;
    [self invalidateIntrinsicContentSize];
}
-(void)removeTagAtIndex:(NSInteger)index{
    
    if (index + 1 > self.tags.count)
    {
        return;
    }
    [self.tags removeObjectAtIndex:index];
    if (self.subviews.count > index)
    {
        [self.subviews[index] removeFromSuperview];
    }
    self.didSetUp = NO;
    [self invalidateIntrinsicContentSize];
}

-(void)removeAllTags{
    [self.tags removeAllObjects];
    for (UIView * view in self.subviews)
    {
        [view removeFromSuperview];
    }
    self.didSetUp = NO;
    [self invalidateIntrinsicContentSize];
}

@end
