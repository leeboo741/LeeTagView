//
//  LeeTagView.h
//  TagViewDemo
//
//  Created by YWKJ on 2018/9/4.
//  Copyright © 2018年 YWKJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeeTagItem.h"
#import "leeTagItemViewModel.h"

#pragma mark -
#pragma mark Enum

typedef enum : NSUInteger
{
    LeeTagViewStyleSelectDisable = 0, // 不可选
    LeeTagViewStyleSelectSingle = 1, // 单选
    LeeTagViewStyleSelectMulti = 2, // 多选
} LeeTagViewSelectionStyle; // tagview 选中 类型

typedef enum : NSUInteger
{
    LeeTagViewLineStyleSingle = 0, // 单行
    LeeTagViewLineStyleMulti = 1, // 多行
} LeeTagViewLineStyle; // tagview 样式 类型

@class LeeTagView;

#pragma mark -
#pragma mark Delegate

/**
 Delegate
 */
@protocol LeeTagViewDelegate<NSObject>

@optional

/**
 点击回调

 @param tagView tagView
 @param tagItem tagItem
 @param index 所在下标
 */
-(void)leeTagView:(LeeTagView *)tagView tapTagItem:(LeeTagItem *)tagItem atIndex:(NSInteger)index;

@end

#pragma mark -
#pragma mark DataSource

/**
 DataSource
 */
@protocol LeeTagViewDataSource<NSObject>

@end

#pragma mark -
#pragma mark Interface

@interface LeeTagView : UIView

#pragma mark -
#pragma mark Property

@property (nonatomic, weak) id<LeeTagViewDelegate> delegate; // tagview 协议
@property (nonatomic, weak) id<LeeTagViewDataSource> dataSource; // tagview 数据源 (暂不使用，稍后想明白了再说)
@property (nonatomic, assign) LeeTagViewSelectionStyle tagViewSelectionStyle; // tagview 选中 类型 单选|多选|不可选
@property (nonatomic, assign) LeeTagViewLineStyle tagViewLineStyle; // tagview 样式 类型 单行|多行
@property (nonatomic, assign) CGFloat tagViewMaxWidth; // tagview 最大宽度
@property (nonatomic, assign) UIEdgeInsets tagViewPadding; // tagView 边距
@property (nonatomic, assign) CGFloat itemSpacingV; // 内部元素 垂直间距
@property (nonatomic, assign) CGFloat itemSpacingH; // 内部元素 水平间距
@property (nonatomic, assign) CGFloat itemRegularWidth; // 内部元素 固定宽度
@property (nonatomic, assign) CGFloat itemRegularHeight; // 内部元素 固定高度

#pragma mark -
#pragma mark Function

/**
 添加 Tag

 @param tag 要添加的tag数据模型
 */
-(void)addTag:(LeeTagItemViewModel *)tag;

/**
 插入 Tag

 @param tag 要插入的tag数据模型
 @param index 想要出入的位置
 */
-(void)insertTag:(LeeTagItemViewModel *)tag atIndex:(NSInteger)index;

/**
 移除 Tag

 @param tag 要移除的tag数据模型
 */
-(void)removeTag:(LeeTagItemViewModel *)tag;

/**
 移除 Tag

 @param index 要移除哪个位置的Tag
 */
-(void)removeTagAtIndex:(NSInteger)index;

/**
 清空Tag
 */
-(void)removeAllTags;

@end
