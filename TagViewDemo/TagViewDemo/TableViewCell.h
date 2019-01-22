//
//  TableViewCell.h
//  TagViewDemo
//
//  Created by mac on 2019/1/21.
//  Copyright © 2019年 YWKJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TableViewCell;
@class LeeTagItem;

@protocol TableViewCellDelegate <NSObject>

-(void)tapTagAtCell:(TableViewCell *)cell tagItem:(LeeTagItem *)tagItem index:(NSInteger)index;

@end

@interface TableViewCell : UITableViewCell

@property (nonatomic, weak) id<TableViewCellDelegate> delegate;
@property (nonatomic, strong) NSArray * dataSource;

@end
