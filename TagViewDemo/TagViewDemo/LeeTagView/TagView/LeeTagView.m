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
@property (nonatomic, strong) NSMutableArray * tags;
@property (nonatomic, assign) BOOL didSetUp; // 是否重新设置,其实就是控制不要频繁的在layoutsubviews里面刷新，也是防着循环调用
@end

static CGFloat kItemSpacingH = 8.0f;
static CGFloat kItemSpacingV = 8.0f;

@implementation LeeTagView
#pragma mark -
#pragma mark Rewrite
// 重写IntrinsicContentSize方法
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
    UIView * preTagItem = nil;
    // X 光标  判断要不要换行能用的上
    CGFloat X = 0;
    // 初始化 tagView 的内容宽度
    CGFloat intrinsicWidth = leftPadding;
    // 初始化 tagView 的内容高度
    CGFloat intrinsicHeight = topPadding;
    // 如果不是单行样式，并且tagView最大宽度超过0
    if (self.tagViewLineStyle != LeeTagViewLineStyleSingle && self.tagViewMaxWidth > 0) {
        // 行数
        NSInteger lineCount = 0;
        // 遍历 tagview 上的 itme
        for (UIView * tagItem in self.subviews) {
            CGSize tagItemIntrinsicContentSize = tagItem.intrinsicContentSize;
            // 如果固定宽高不为 0 ，则使用固定宽高。否则使用 tagItem 自有内容宽高
            CGFloat width = self.itemRegularWidth != 0 ? self.itemRegularWidth : tagItemIntrinsicContentSize.width;
            CGFloat height = self.itemRegularHeight != 0 ? self.itemRegularHeight : tagItemIntrinsicContentSize.height;
            // 是否有上一个 item
            if (preTagItem) {
                // 当前 item宽度 + tagview距右宽度 + X 光标 是否在 tagview 最大宽度范围内
                if (X + width + rightPadding <= self.tagViewMaxWidth) {
                    // 在范围内 不折行 光标移动 一个item距离
                    X += width + self.itemSpacingH;
                } else {
                    // 超出范围，折行
                    // 行数增加
                    lineCount ++;
                    // 光标归零 并移动一个 item 距离
                    X = leftPadding + width;
                    // tagView 高度增加 一行 item 高度
                    intrinsicHeight += height + self.itemSpacingV;
                }
            } else {
                // 并无上一个item ,此item 为初始item
                // 行数加1
                lineCount ++;
                // tagView 高度增加 一行 item 高度
                intrinsicHeight += height;
                // 光标 归零 并移动 一个 item 距离
                X = width + leftPadding;
            }
            // 更新 上一个 item 为 当前 item
            preTagItem = tagItem;
            // 更新 tagView 内容宽度
            intrinsicWidth = MAX(intrinsicWidth, X + rightPadding);
        }
        // 更新 tagView 内容高度
        intrinsicHeight += bottomPadding;
    }else {
        for (UIView * tagItem in self.subviews) {
            CGSize tagItemIntrinsicContentSize = tagItem.intrinsicContentSize;
            intrinsicWidth += self.itemRegularWidth != 0 ? self.itemRegularWidth : tagItemIntrinsicContentSize.width;
        }
        intrinsicWidth += self.itemSpacingH * (self.subviews.count - 1) + rightPadding;
        intrinsicHeight += ((UIView *)self.subviews.firstObject).intrinsicContentSize.height + bottomPadding;
    }
    return CGSizeMake(intrinsicWidth, intrinsicHeight);
}
-(void)layoutSubviews{
    if (self.tagViewLineStyle != LeeTagViewLineStyleSingle) {
        self.tagViewMaxWidth = self.frame.size.width;
    }
    [super layoutSubviews];
    [self resetTags];
}
-(void)resetTags{
    if (self.didSetUp || !self.tags.count) {
        return;
    }
    // tagView padding
    CGFloat topPadding = self.tagViewPadding.top;
    CGFloat leftPadding = self.tagViewPadding.left;
    CGFloat rightPadding = self.tagViewPadding.right;
    UIView * preTagItem = nil;
    CGFloat X = leftPadding;
    if (self.tagViewLineStyle != LeeTagViewLineStyleSingle && self.tagViewMaxWidth > 0) {
        for (UIView *view in self.subviews) {
            CGSize size = view.intrinsicContentSize;
            CGFloat width1 = self.itemRegularWidth != 0 ? self.itemRegularWidth : size.width;
            CGFloat height1 = self.itemRegularHeight != 0 ? self.itemRegularHeight : size.height;
            if (preTagItem) {
                X += self.itemSpacingH;
                if (X + width1 + rightPadding <= self.tagViewMaxWidth) {
                    view.frame = CGRectMake(X, CGRectGetMinY(preTagItem.frame), width1, height1);
                    X += width1;
                } else {
                    CGFloat width = MIN(width1, self.tagViewMaxWidth - leftPadding - rightPadding);
                    view.frame = CGRectMake(leftPadding, CGRectGetMaxY(preTagItem.frame) + self.itemSpacingV, width, height1);
                    X = leftPadding + width;
                }
            } else {
                CGFloat width = MIN(width1, self.tagViewMaxWidth - leftPadding - rightPadding);
                view.frame = CGRectMake(leftPadding, topPadding, width, height1);
                X += width;
            }
            preTagItem = view;
        }
    }else {
        for (UIView *view in self.subviews) {
            CGSize size = view.intrinsicContentSize;
            view.frame = CGRectMake(X, topPadding, self.itemRegularWidth != 0 ? self.itemRegularWidth : size.width, self.itemRegularHeight != 0 ? self.itemRegularHeight : size.height);
            X += self.itemRegularWidth != 0 ? self.itemRegularWidth : size.width;
            preTagItem = view;
        }
    }
    self.didSetUp = YES;
}
#pragma mark -
#pragma mark Set/Get
-(CGFloat)itemSpacingH{
    if (_itemSpacingH == 0) {
        return kItemSpacingH;
    }
    return _itemSpacingH;
}
-(CGFloat)itemSpacingV{
    if (_itemSpacingV == 0) {
        return kItemSpacingV;
    }
    return _itemSpacingV;
}
-(NSMutableArray *)tags{
    if (!_tags) {
        _tags = [NSMutableArray array];
    }
    return _tags;
}
-(void)setTagViewMaxWidth:(CGFloat)tagViewMaxWidth{
    if (_tagViewMaxWidth != tagViewMaxWidth) {
        _tagViewMaxWidth = tagViewMaxWidth;
        _didSetUp = NO;
        [self invalidateIntrinsicContentSize];
    }
}
#pragma mark -
#pragma mark Tag Action
-(void)tagButtonAction:(LeeTagButton *)tagButton{
    if (self.tagViewSelectionStyle == LeeTagViewStyleSelectSingle) {
        tagButton.selected = !tagButton.selected;
        [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            LeeTagButton * tempTagButton = (LeeTagButton *)obj;
            if (tagButton != tempTagButton) {
                tempTagButton.selected = NO;
            }
        }];
    }else if (self.tagViewSelectionStyle == LeeTagViewStyleSelectMulti){
        tagButton.selected = !tagButton.selected;
    }else if (self.tagViewSelectionStyle == LeeTagViewStyleSelectDisable){
        
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(leeTagView:tapTagButton:atIndex:)]) {
        [self.delegate leeTagView:self tapTagButton:tagButton atIndex:[self.subviews indexOfObject:tagButton]];
    }
}
#pragma mark -
#pragma mark Public Action
-(void)addTag:(LeeTagViewModel *)tag{
    NSParameterAssert(tag);
    LeeTagButton * tagButton = [LeeTagButton tagButtonWithTagViewModel:tag];
    [tagButton addTarget:self action:@selector(tagButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:tagButton];
    [self.tags addObject:tag];
    self.didSetUp = NO;
    [self invalidateIntrinsicContentSize];
}
-(void)insertTag:(LeeTagViewModel *)tag atIndex:(NSInteger)index{
    NSParameterAssert(tag);
    if (index + 1 > self.tags.count) {
        [self addTag:tag];
    }else{
        LeeTagButton * tagButton = [LeeTagButton tagButtonWithTagViewModel:tag];
        [tagButton addTarget:self action:@selector(tagButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self insertSubview:tagButton atIndex:index];
        [self.tags insertObject:tag atIndex:index];
        self.didSetUp = NO;
        [self invalidateIntrinsicContentSize];
    }
}
-(void)removeTag:(LeeTagViewModel *)tag{
    NSParameterAssert(tag);
    NSInteger index = [self.tags indexOfObject:tag];
    if (NSNotFound == index) {
        return;
    }
    [self.tags removeObjectAtIndex:index];
    if (self.subviews.count > index) {
        [self.subviews[index] removeFromSuperview];
    }
    self.didSetUp = NO;
    [self invalidateIntrinsicContentSize];
}
-(void)removeTagAtIndex:(NSInteger)index{
    if (index + 1 > self.tags.count) {
        return;
    }
    [self.tags removeObjectAtIndex:index];
    if (self.subviews.count > index) {
        [self.subviews[index] removeFromSuperview];
    }
    self.didSetUp = NO;
    [self invalidateIntrinsicContentSize];
}
-(void)removeAllTags{
    [self.tags removeAllObjects];
    for (UIView * view in self.subviews) {
        [view removeFromSuperview];
    }
    self.didSetUp = NO;
    [self invalidateIntrinsicContentSize];
}

@end
