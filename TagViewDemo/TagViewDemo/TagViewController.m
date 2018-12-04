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
        LeeTagViewModel * tagModel = [[LeeTagViewModel alloc]init];
        
        tagModel.data = obj;
        
        tagModel.tagText = obj;
        tagModel.tagTextColor = [UIColor blackColor];
        tagModel.tagTextFontSize = 13.0f;
        tagModel.tagBgColor = [UIColor whiteColor];
        tagModel.tagSelectTextColor = [UIColor redColor];
        tagModel.tagSelectBgColor = [UIColor yellowColor];
        
        tagModel.tagCornerRadius = 10.0f;
        tagModel.tagBorderColor = [UIColor grayColor];
        tagModel.tagSelectBorderColor = [UIColor greenColor];
        tagModel.tagBorderWidth = 2.0f;
        
        tagModel.contentPadding = UIEdgeInsetsMake(10, 10, 10, 10);
        
        [self.multiTagView addTag:tagModel];
    }];
    _testTagView.delegate = self;
    _testTagView.tagViewSelectionStyle = LeeTagViewStyleSelectSingle;
    _testTagView.tagViewLineStyle = LeeTagViewLineStyleMulti;
    _testTagView.tagViewPadding = UIEdgeInsetsMake(5, 5, 5, 5);
    _testTagView.tagViewMaxWidth = self.view.frame.size.width;
    [[self dataArray] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        LeeTagViewModel * tagModel = [[LeeTagViewModel alloc]init];
        
        tagModel.data = obj;
        
        tagModel.tagText = obj;
        tagModel.tagTextColor = [UIColor blackColor];
        tagModel.tagTextFontSize = 13.0f;
        tagModel.tagBgColor = [UIColor whiteColor];
        tagModel.tagImage = [UIImage imageNamed:@"deleteFullRed"];
        tagModel.tagSelectImage = [UIImage imageNamed:@"checkmark_full_green"];
        
        tagModel.tagSelectTextColor = [UIColor redColor];
        tagModel.tagSelectBgColor = [UIColor yellowColor];
        
        tagModel.tagCornerRadius = 10.0f;
        tagModel.tagBorderColor = [UIColor grayColor];
        tagModel.tagSelectBorderColor = [UIColor greenColor];
        tagModel.tagBorderWidth = 2.0f;
        
        tagModel.contentPadding = UIEdgeInsetsMake(0, 0, 0, 10);
        
        [self.testTagView addTag:tagModel];
    }];
    _disableTagView.tagViewSelectionStyle = LeeTagViewStyleSelectDisable;
    _disableTagView.tagViewLineStyle = LeeTagViewLineStyleMulti;
    _disableTagView.tagViewPadding = UIEdgeInsetsMake(10, 10, 10, 10);
    _disableTagView.tagViewMaxWidth = self.view.frame.size.width;
}
-(void)leeTagView:(LeeTagView *)tagView tapTagButton:(LeeTagButton *)tagButton atIndex:(NSInteger)index{
    if (tagView == _multiTagView){
        if (tagButton.tagViewModel.isSelect) {
            [self.selectDataArray addObject:tagButton.tagViewModel];
            [self.disableTagView addTag:tagButton.tagViewModel];
        }else{
            [self.selectDataArray removeObject:tagButton.tagViewModel];
            [self.disableTagView removeTag:tagButton.tagViewModel];
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
