//
//  TableViewCell.m
//  TagViewDemo
//
//  Created by mac on 2019/1/21.
//  Copyright © 2019年 YWKJ. All rights reserved.
//

#import "TableViewCell.h"
#import "LeeTagView/TagView/LeeTagView.h"

@interface TableViewCell ()<LeeTagViewDelegate>
@property (weak, nonatomic) IBOutlet LeeTagView *tagView;

@end

@implementation TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _tagView.backgroundColor = [UIColor redColor];
    _tagView.delegate = self;
    _tagView.tagViewSelectionStyle = LeeTagViewStyleSelectMulti;
    _tagView.tagViewLineStyle = LeeTagViewLineStyleMulti;
    _tagView.tagViewPadding = UIEdgeInsetsMake(5, 5, 5, 5);
    CGFloat width = self.frame.size.width;
    _tagView.tagViewMaxWidth = width;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)leeTagView:(LeeTagView *)tagView tapTagItem:(LeeTagItem *)tagItem atIndex:(NSInteger)index{
    if (_delegate && [_delegate respondsToSelector:@selector(tapTagAtCell:tagItem:index:)]) {
        [_delegate tapTagAtCell:self tagItem:tagItem index:index];
    }
}
-(void)setDataSource:(NSArray *)dataSource{
    _dataSource = dataSource;
    
    [self.tagView removeAllTags];
    
    [_dataSource enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        LeeTagItemViewModel * item = (LeeTagItemViewModel *)obj;
        [self.tagView addTag:item];
    }];
    
//    NSMutableArray * deleteArray = [NSMutableArray arrayWithArray:self.tagView.subviews];
//    NSMutableArray * newArray = [NSMutableArray arrayWithArray:_dataSource];
//
//    for (NSInteger i = newArray.count - 1; i >= 0; i --) {
//        LeeTagItemViewModel * tempViewModel = newArray[i];
//        for (LeeTagItem * item in deleteArray) {
//            if (tempViewModel == item.viewModel) {
//                [newArray removeObject:tempViewModel];
//                [deleteArray removeObject:item];
//                break;
//            }
//        }
//    }
//
//    for (LeeTagItem * tempItem in deleteArray) {
//        [self.tagView removeTag:tempItem.viewModel];
//    }
//
//    for (LeeTagItemViewModel * tempViewModel in newArray) {
//        [self.tagView addTag:tempViewModel];
//    }
//
//    [self.tagView reset];
}

@end
