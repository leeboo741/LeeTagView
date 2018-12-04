//
//  TagTestViewController.m
//  TagViewDemo
//
//  Created by mac on 2018/12/3.
//  Copyright © 2018年 YWKJ. All rights reserved.
//

#import "TagTestViewController.h"
#import "LeeTagView.h"

@interface TagTestViewController ()<LeeTagViewDelegate>
@property (weak, nonatomic) IBOutlet LeeTagView *testTagView;
@property (weak, nonatomic) IBOutlet LeeTagView *addTagView;

@end

@implementation TagTestViewController
- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _testTagView.delegate = self;
    _testTagView.tagViewSelectionStyle = LeeTagViewStyleSelectMulti;
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
        tagModel.tagSelectTextColor = [UIColor redColor];
        tagModel.tagSelectBgColor = [UIColor yellowColor];
        
        tagModel.tagCornerRadius = 10.0f;
        tagModel.tagBorderColor = [UIColor grayColor];
        tagModel.tagSelectBorderColor = [UIColor greenColor];
        tagModel.tagBorderWidth = 2.0f;
        
        tagModel.contentPadding = UIEdgeInsetsMake(8, 8, 8, 8);
        
        [self.testTagView addTag:tagModel];
    }];
    
    _addTagView.tagViewSelectionStyle = LeeTagViewStyleSelectDisable;
    _addTagView.tagViewLineStyle = LeeTagViewLineStyleMulti;
    _addTagView.tagViewPadding = UIEdgeInsetsMake(5, 5, 5, 5);
    _addTagView.tagViewMaxWidth = self.view.frame.size.width;
}
-(void)leeTagView:(LeeTagView *)tagView tapTagButton:(LeeTagButton *)tagButton atIndex:(NSInteger)index{
    if (tagView == _testTagView){
        if (tagButton.tagViewModel.isSelect) {
            [self.addTagView addTag:tagButton.tagViewModel];
        }else{
            [self.addTagView removeTag:tagButton.tagViewModel];
        }
    }
    
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
