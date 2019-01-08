//
//  TagViewController.m
//  TagViewDemo
//
//  Created by YWKJ on 2018/9/5.
//  Copyright © 2018年 YWKJ. All rights reserved.
//

#import "TagViewController.h"
#import "LeeTagView.h"

@interface TagViewController ()<LeeTagViewDelegate>
@property (weak, nonatomic) IBOutlet LeeTagView *multiTagView;
@property (weak, nonatomic) IBOutlet LeeTagView *testTagView;
@property (weak, nonatomic) IBOutlet LeeTagView *disableTagView;

@property (nonatomic, strong) NSMutableArray * selectDataArray;
@end

@implementation TagViewController
- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _multiTagView.delegate = self;
    _multiTagView.tagViewSelectionStyle = LeeTagViewStyleSelectMulti;
    _multiTagView.tagViewLineStyle = LeeTagViewLineStyleMulti;
    _multiTagView.tagViewPadding = UIEdgeInsetsMake(5, 5, 5, 5);
    _multiTagView.tagViewMaxWidth = self.view.frame.size.width;
    
    [[self dataArray] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        LeeTagItemViewModel * tagModel = [[LeeTagItemViewModel alloc]init];
        
        tagModel.normalTitle = obj;
        tagModel.normalImage = [UIImage imageNamed:@"unSelected"];
        tagModel.normalBorderWidth = 1.0f;
        tagModel.normalCornerRadius = 8.0f;
        
        tagModel.selectedTitle = obj;
        tagModel.selectedFont = [UIFont systemFontOfSize:16.0f];
        tagModel.selectedFontSize = 15.0f;
        tagModel.selectedColor = [UIColor redColor];
        tagModel.selectedImage = [UIImage imageNamed:@"selected"];
        tagModel.selectedBGColor = [UIColor yellowColor];
        tagModel.selectedBorderColor = [UIColor greenColor];
        tagModel.selectedBorderWidth = 2.0f;
        tagModel.selectedCornerRadius = 8.0f;
        
        [self.multiTagView addTag:tagModel];
    }];
    _testTagView.delegate = self;
    _testTagView.tagViewSelectionStyle = LeeTagViewStyleSelectSingle;
    _testTagView.tagViewLineStyle = LeeTagViewLineStyleMulti;
    _testTagView.tagViewPadding = UIEdgeInsetsMake(5, 5, 5, 5);
    _testTagView.tagViewMaxWidth = self.view.frame.size.width;
    [[self dataArray] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        LeeTagItemViewModel * tagModel = [[LeeTagItemViewModel alloc]init];
        
        tagModel.normalTitle = obj;
        tagModel.normalImage = [UIImage imageNamed:@"unSelected"];
        tagModel.normalBorderWidth = 1.0f;
        tagModel.normalCornerRadius = 8.0f;
        
        tagModel.selectedTitle = obj;
        tagModel.selectedFont = [UIFont systemFontOfSize:16.0f];
        tagModel.selectedColor = [UIColor redColor];
        tagModel.selectedImage = [UIImage imageNamed:@"selected"];
        tagModel.selectedBGColor = [UIColor yellowColor];
        tagModel.selectedBorderColor = [UIColor greenColor];
        tagModel.selectedBorderWidth = 2.0f;
        tagModel.selectedCornerRadius = 8.0f;
        
        [self.testTagView addTag:tagModel];
    }];
    _disableTagView.tagViewSelectionStyle = LeeTagViewStyleSelectDisable;
    _disableTagView.tagViewLineStyle = LeeTagViewLineStyleMulti;
    _disableTagView.tagViewPadding = UIEdgeInsetsMake(10, 10, 10, 10);
    _disableTagView.tagViewMaxWidth = self.view.frame.size.width;
}
-(void)leeTagView:(LeeTagView *)tagView tapTagItem:(LeeTagItem *)tagItem atIndex:(NSInteger)index{
    if (tagView == _multiTagView){
        if (tagItem.selected) {
            [self.selectDataArray addObject:tagItem];
            [self.disableTagView addTag:tagItem.viewModel];
        }else{
            [self.selectDataArray removeObject:tagItem.viewModel];
            [self.disableTagView removeTag:tagItem.viewModel];
        }
    }
}
-(NSMutableArray *)selectDataArray{
    if (!_selectDataArray) {
        _selectDataArray = [NSMutableArray array];
    }
    return _selectDataArray;
}
-(NSArray *)dataArray{
    return @[
             @"测试字符1",
             @"测试字符2",
             @"测试中等长度字符1",
             @"测试中等长度字符2",
             @"https://github.com/leeboo741/LeeTagView",
             @"如果用了觉得还过得去",
             @"Orz,请赏个Star",
             @"如果用了觉得有问题",
             @"欢迎提交，尽快改正",
             @"如果用了觉得太low",
             @"诚邀指点，虚心接受"
             ];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
