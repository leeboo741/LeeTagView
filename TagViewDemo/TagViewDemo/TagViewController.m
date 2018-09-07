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
@end

@implementation TagViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _multiTagView.delegate = self;
    _multiTagView.tagViewSelectionStyle = LeeTagViewStyleSelectMulti;
    _multiTagView.tagViewLineStyle = LeeTagViewLineStyleMulti;
    _multiTagView.tagViewPadding = UIEdgeInsetsMake(5, 5, 5, 5);
    _multiTagView.tagViewMaxWidth = self.view.frame.size.width;
    [[self dataArray] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        LeeTagViewModel * tagModel = [[LeeTagViewModel alloc]init];
        
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
        
        tagModel.contentPadding = UIEdgeInsetsMake(3, 23, 3, 23);
        tagModel.imagePadding = UIEdgeInsetsMake(5, -10, 5, 0);
        
        [self.multiTagView addTag:tagModel];
    }];
    _testTagView.delegate = self;
    _testTagView.tagViewSelectionStyle = LeeTagViewStyleSelectSingle;
    _testTagView.tagViewLineStyle = LeeTagViewLineStyleMulti;
    _testTagView.tagViewPadding = UIEdgeInsetsMake(5, 5, 5, 5);
    _testTagView.tagViewMaxWidth = self.view.frame.size.width;
    [[self dataArray] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        LeeTagViewModel * tagModel = [[LeeTagViewModel alloc]init];
        
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
//        tagModel.imagePadding = UIEdgeInsetsMake(4, 0, 4, 20);
        
        [self.testTagView addTag:tagModel];
    }];
}
-(void)leeTagView:(LeeTagView *)tagView tapTagButton:(LeeTagButton *)tagButton atIndex:(NSInteger)index{
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
