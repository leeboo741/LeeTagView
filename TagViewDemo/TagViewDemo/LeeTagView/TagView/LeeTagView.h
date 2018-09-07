//
//  LeeTagView.h
//  TagViewDemo
//
//  Created by YWKJ on 2018/9/4.
//  Copyright © 2018年 YWKJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeeTagButton.h"
#import "LeeTagViewModel.h"

typedef enum : NSUInteger {
    LeeTagViewStyleSelectDisable = 0, // 不可选
    LeeTagViewStyleSelectSingle = 1, // 单选
    LeeTagViewStyleSelectMulti = 2, // 多选
} LeeTagViewSelectionStyle; // tagview 选中 类型

typedef enum : NSUInteger {
    LeeTagViewLineStyleSingle = 0, // 单行
    LeeTagViewLineStyleMulti = 1, // 多行
} LeeTagViewLineStyle; // tagview 样式 类型

@class LeeTagView;
@protocol LeeTagViewDelegate<NSObject>
-(void)leeTagView:(LeeTagView *)tagView tapTagButton:(LeeTagButton *)tagButton atIndex:(NSInteger)index;
@end

@protocol LeeTagViewDataSource<NSObject>

@end

@interface LeeTagView : UIView <UITableViewDelegate>

#pragma mark Delegate
@property (nonatomic, weak) id<LeeTagViewDelegate> delegate; // tagview 协议

#pragma mark DataSource
@property (nonatomic, weak) id<LeeTagViewDataSource> dataSource; // tagview 数据源 (暂不使用，稍后想明白了再说)

#pragma mark Style
@property (nonatomic, assign) LeeTagViewSelectionStyle tagViewSelectionStyle; // tagview 选中 类型 单选|多选|不可选
@property (nonatomic, assign) LeeTagViewLineStyle tagViewLineStyle; // tagview 样式 类型 单行|多行

#pragma mark Form
@property (nonatomic, assign) CGFloat tagViewMaxWidth; // tagview 最大宽度
@property (nonatomic, assign) UIEdgeInsets tagViewPadding; // tag展示View 边距
@property (nonatomic, assign) CGFloat itemSpacingV; // 内部元素 垂直间距
@property (nonatomic, assign) CGFloat itemSpacingH; // 内部元素 水平间距
@property (nonatomic, assign) CGFloat itemRegularWidth; // 内部元素 固定宽度
@property (nonatomic, assign) CGFloat itemRegularHeight; // 内部元素 固定高度


-(void)addTag:(LeeTagViewModel *)tag;
-(void)insertTag:(LeeTagViewModel *)tag atIndex:(NSInteger)index;
-(void)removeTag:(LeeTagViewModel *)tag;
-(void)removeTagAtIndex:(NSInteger)index;
-(void)removeAllTags;

@end
