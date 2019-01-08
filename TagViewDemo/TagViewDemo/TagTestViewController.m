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
        LeeTagItemViewModel * tagModel = [[LeeTagItemViewModel alloc]init];
        
        tagModel.normalTitle = obj;
        tagModel.normalFont = [UIFont systemFontOfSize:9.0f];
        tagModel.normalFontSize = 15.0f;
        tagModel.normalColor = [UIColor greenColor];
        tagModel.normalImage = [UIImage imageNamed:@"unSelected"];
        tagModel.normalBGColor = [UIColor yellowColor];
        tagModel.normalBorderColor = [UIColor redColor];
        tagModel.normalBorderWidth = 1.0f;
        tagModel.normalCornerRadius = 3.0f;
        
        tagModel.selectedTitle = obj;
        tagModel.selectedFont = [UIFont systemFontOfSize:20.0f];
        tagModel.selectedFontSize = 15.0f;
        tagModel.selectedColor = [UIColor redColor];
        tagModel.selectedImage = [UIImage imageNamed:@"selected"];
        tagModel.selectedBGColor = [UIColor yellowColor];
        tagModel.selectedBorderColor = [UIColor greenColor];
        tagModel.selectedBorderWidth = 5.0f;
        tagModel.selectedCornerRadius = 10.0f;
        
        [self.testTagView addTag:tagModel];
    }];
    
    _addTagView.tagViewSelectionStyle = LeeTagViewStyleSelectDisable;
    _addTagView.tagViewLineStyle = LeeTagViewLineStyleMulti;
    _addTagView.tagViewPadding = UIEdgeInsetsMake(5, 5, 5, 5);
    _addTagView.tagViewMaxWidth = self.view.frame.size.width;
}
-(void)leeTagView:(LeeTagView *)tagView tapTagItem:(LeeTagItem *)tagItem atIndex:(NSInteger)index{
    if (tagView == _testTagView){
        if (tagItem.selected) {
            [self.addTagView addTag:tagItem.viewModel];
        }else{
            [self.addTagView removeTag:tagItem.viewModel];
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
