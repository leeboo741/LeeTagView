//
//  LeeTagView.m
//  TagViewDemo
//
//  Created by YWKJ on 2018/9/4.
//  Copyright © 2018年 YWKJ. All rights reserved.
//

#import "LeeTagView.h"

#pragma mark -
#pragma mark Interface

@interface LeeTagView()

@property (nonatomic, strong) NSMutableArray<LeeTagItemViewModel *> * tags; // 数据源
@property (nonatomic, assign) BOOL didSetUp; // 是否设置,其实就是控制不要频繁的在layoutsubviews里面刷新，也是防着循环调用
@end

#pragma mark -
#pragma mark Static

static CGFloat kItemSpacingH = 8.0f; // 水平间距
static CGFloat kItemSpacingV = 8.0f; // 垂直间距

#pragma mark -
#pragma mark Implementation

@implementation LeeTagView

#pragma mark -
#pragma mark Rewrite

/**
 重写IntrinsicContentSize方法, 控制tagView的bounds

 @return 内置大小
 */
-(CGSize)intrinsicContentSize
{
    // 如果内容为空，内容宽高坍缩成零点状态
    if (!self.tags.count)
    {
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
        &&
        self.tagViewMaxWidth > 0)
    {
        // 行数
        NSInteger lineCount = 0;
        // 遍历 tagview 上的 itme
        for (UIView * tagItem in self.subviews)
        {
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
                    // 不折行 也要判断最大高度 进行高度变化
                    // 获取上一个item的高度
                    CGFloat preHeight = (self.itemRegularHeight != 0 ? self.itemRegularHeight : preTagItem.intrinsicContentSize.height);
                    // 如果当前item的高度大于上一个item的高度，当前内容高度需要加上增加的值，如果小于，说明上一个item已经加过高度了，高度不需要增加，因为高度只选择其中最高的计算
                    if (height > preHeight)
                    {
                        // 内容高度 因为在一行内，内容高度已经加上了原本的高度，只需要追加差值
                        intrinsicHeight += height - preHeight;
                    }
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
        // 行中最大高度
        CGFloat maxHeight = 0;
        for (UIView * tagItem in self.subviews)
        {
            // 当前item的内容宽高
            CGSize tagItemIntrinsicContentSize = tagItem.intrinsicContentSize;
            // 内容宽度 追加 item 的 内容宽度，如果有固定宽度追加固定宽度
            intrinsicWidth += ( self.itemRegularWidth != 0 ? self.itemRegularWidth : tagItemIntrinsicContentSize.width );
            // 如果最大高度 小于 内容高度
            if (maxHeight < tagItemIntrinsicContentSize.height) {
                // 最大高度 重赋值 内容高度
                maxHeight = tagItemIntrinsicContentSize.height;
            }
        }
        // 最终 内容宽度 等于 所有item内容宽度的和 加 每个item 的间距 和 最终右边距
        intrinsicWidth += ( self.itemSpacingH * (self.subviews.count - 1) + rightPadding );
        // 最终 内容高度 等于 最大内容高度 加 底部边距
        intrinsicHeight += ( maxHeight + bottomPadding );
    } // 结束 单行演示 和 最大宽度的 判断
    // 返回最终计算的内容宽高
    return CGSizeMake(intrinsicWidth, intrinsicHeight);
}

/**
 重写 layoutSubviews 方法
 */
-(void)layoutSubviews
{
    [super layoutSubviews];
    [self resetTags];
}

#pragma mark -
#pragma mark Set/Get

/**
 GET item 水平间隔

 @return item水平间隔
 */
-(CGFloat)itemSpacingH
{
    if (_itemSpacingH == 0)
    {
        return kItemSpacingH;
    }
    return _itemSpacingH;
}

/**
 GET item 垂直间隔

 @return item垂直间隔
 */
-(CGFloat)itemSpacingV
{
    if (_itemSpacingV == 0)
    {
        return kItemSpacingV;
    }
    return _itemSpacingV;
}

/**
 GET tags 数据模型对象数组

 @return tags
 */
-(NSMutableArray<LeeTagItemViewModel *> *)tags
{
    if (!_tags)
    {
        _tags = [NSMutableArray array];
    }
    return _tags;
}

/**
 设置最大宽度

 @param tagViewMaxWidth 最大宽度
 */
-(void)setTagViewMaxWidth:(CGFloat)tagViewMaxWidth
{
    if (_tagViewMaxWidth != tagViewMaxWidth)
    {
        _tagViewMaxWidth = tagViewMaxWidth;
        _didSetUp = NO;
        
        [self layoutIfNeeded];
        [self invalidateIntrinsicContentSize];
    }
}

#pragma mark -
#pragma mark Action

/**
 重置 刷新 tagview ，控制 tagItem 的frame
 */
-(void)resetTags
{
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
        &&
        self.tagViewMaxWidth > 0)
    {
        // 行数
        NSInteger lineCount = 0;
        // 上一行最大行高
        CGFloat maxUpLineHeight = 0;
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
                    // 如果上一个item 圈定的最大行高 小于当前 item 圈定的最大 行高， 替换最大行高的值
                    if (maxUpLineHeight < (CGRectGetMinY(preTagItem.frame)+height)) {
                        maxUpLineHeight = CGRectGetMinY(preTagItem.frame) + height;
                    }
                    // 移动 X 光标
                    X += ( width + self.itemSpacingH );
                }
                else // 范围外，折行，重新归零
                {
                    // 行数+1
                    lineCount ++;
                    // 新的一行，上一行的最大行高要加上垂直间距
                    maxUpLineHeight += self.itemSpacingV;
                    // X 光标归零
                    X = leftPadding;
                    // 获取宽度，在自有宽度和最大宽度减去左右边距中选择最小宽度
                    CGFloat itemWidth = MIN(width, self.tagViewMaxWidth - leftPadding - rightPadding);
                    // item 的 frame X = X 光标 Y == 上一行最大行高的值
                    tagItem.frame = CGRectMake(X,
                                               maxUpLineHeight,
                                               itemWidth,
                                               height);
                    // 移动 X 光标
                    X += ( width + self.itemSpacingH );
                    // 换了新的一行，最大行高要重新计算
                    maxUpLineHeight += height;
                }
            }
            else // 没有上一个 Item
            {
                // 行数 +1
                lineCount ++;
                // 第一个item 上一行最大行高 为 垂直间距
                maxUpLineHeight = self.itemSpacingV;
                // 获取宽度，在自有宽度和最大宽度减去左右边距中选择最小宽度
                CGFloat itemWidth = MIN(width, self.tagViewMaxWidth - leftPadding - rightPadding);
                // item 的 frame X = X 光标 Y = 垂直间距 , item 宽度 ，item 高度
                tagItem.frame = CGRectMake(X,
                                           maxUpLineHeight,
                                           itemWidth,
                                           height);
                // X 移动
                X += ( width + self.itemSpacingH );
                // 有 item 了  可以比较最大行高了， 给最大行高赋值
                maxUpLineHeight += height;
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


/**
 tag Button 点击事件

 @param action 点击手势
 */
-(void)tagButtonAction:(id)action
{
    UITapGestureRecognizer * tap = (UITapGestureRecognizer *)action;
    LeeTagItem * tagButton = (LeeTagItem *)tap.view;
    // 根据 选择样式 不同，做不同操作
    if (self.tagViewSelectionStyle == LeeTagViewStyleSelectSingle) // 单选
    {
        tagButton.selected = !tagButton.selected;
        // 取消其他按钮选中状态
        [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj,
                                                    NSUInteger idx,
                                                    BOOL * _Nonnull stop)
        {
            LeeTagItem * tempTagButton = (LeeTagItem *)obj;
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
    // 允许重新计算内置大小
    self.didSetUp = NO;
    
    [self layoutSubviews];
    [self invalidateIntrinsicContentSize];
    // delegate 往外通知点击事件
    if (self.delegate
        &&
        [self.delegate respondsToSelector:@selector(leeTagView:tapTagItem:atIndex:)])
    {
        [self.delegate leeTagView:self
                       tapTagItem:tagButton
                          atIndex:[self.subviews indexOfObject:tagButton]];
    }
}

#pragma mark -
#pragma mark Public

/**
 加入 tag

 @param tag tag
 */
-(void)addTag:(LeeTagItemViewModel *)tag
{
    NSParameterAssert(tag);
    // 追加tag
    LeeTagItem * tagButton = [LeeTagItem tagItemWithItemViewModel:tag];
    [tagButton addTapTarget:self action:@selector(tagButtonAction:)];
    [self addSubview:tagButton];
    [self.tags addObject:tag];
    self.didSetUp = NO;
    
    [self layoutIfNeeded];
    [self invalidateIntrinsicContentSize];
}

/**
 插入tag

 @param tag tag
 @param index 要插入的位置
 */
-(void)insertTag:(LeeTagItemViewModel *)tag atIndex:(NSInteger)index
{
    NSParameterAssert(tag);
    if (index + 1 > self.tags.count) // 如果 index 大于 数据源的长度，直接插入尾部
    {
        [self addTag:tag];
    }
    else // 如果 小于等于 数据源长度 ， 插入对应位置
    {
        LeeTagItem * tagButton = [LeeTagItem tagItemWithItemViewModel:tag];
        [tagButton addTapTarget:self action:@selector(tagButtonAction:)];
        [self insertSubview:tagButton
                    atIndex:index];
        [self.tags insertObject:tag
                        atIndex:index];
        self.didSetUp = NO;
        
        [self layoutIfNeeded];
        [self invalidateIntrinsicContentSize];
    }
}

/**
 移除tag

 @param tag 要移除的tag
 */
-(void)removeTag:(LeeTagItemViewModel *)tag
{
    NSParameterAssert(tag);
    // tag在数据源中的下标
    NSInteger index = [self.tags indexOfObject:tag];
    // 如果不存在 不许操作
    if (NSNotFound == index)
    {
        return;
    }
    // 移除数据源中数据
    [self.tags removeObjectAtIndex:index];
    // 移除subview
    if (self.subviews.count > index)
    {
        [self.subviews[index] removeFromSuperview];
    }
    // 允许并重新计算
    self.didSetUp = NO;
    
    [self layoutIfNeeded];
    [self invalidateIntrinsicContentSize];
}

/**
 移除对应位置的tag

 @param index tag对应的下标
 */
-(void)removeTagAtIndex:(NSInteger)index
{
    // 如果index 大于 tag的数量 不许移除
    if (index + 1 > self.tags.count)
    {
        return;
    }
    // 移除数据
    [self.tags removeObjectAtIndex:index];
    // 移除subview
    if (self.subviews.count > index)
    {
        [self.subviews[index] removeFromSuperview];
    }
    // 允许并重新计算
    self.didSetUp = NO;
    
    [self layoutIfNeeded];
    [self invalidateIntrinsicContentSize];
}

/**
 移除所有tag
 */
-(void)removeAllTags
{
    // 移除数据
    [self.tags removeAllObjects];
    // 移除subView
    for (UIView * view in self.subviews)
    {
        [view removeFromSuperview];
    }
    // 允许重新计算
    self.didSetUp = NO;
    // 重新计算内置大小
    
    [self layoutIfNeeded];
    [self invalidateIntrinsicContentSize];
}

@end
