//
//  ListViewController.m
//  TagViewDemo
//
//  Created by mac on 2019/1/21.
//  Copyright © 2019年 YWKJ. All rights reserved.
//

#import "ListViewController.h"
#import "TableViewCell.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "LeeTagView/TagViewModel/LeeTagItemViewModel.h"

@interface ListViewController ()<UITableViewDelegate,UITableViewDataSource,TableViewCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *listView;
@property (nonatomic, strong) NSArray * dataSource;

@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.listView.delegate = self;
    self.listView.dataSource = self;
    [self.listView registerNib:[UINib nibWithNibName:@"TableViewCell" bundle:nil] forCellReuseIdentifier:@"TableViewCell"];
    // Do any additional setup after loading the view from its nib.
}
-(void)configCell:(TableViewCell *)cell indexPath:(NSIndexPath *)indexPath{
    cell.dataSource = self.dataSource;
    cell.delegate = self;
}
-(void)tapTagAtCell:(TableViewCell *)cell tagItem:(LeeTagItem *)tagItem index:(NSInteger)index{
    NSIndexPath * indexPath = [self.listView indexPathForCell:cell];
    [self.listView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"TableViewCell"];
    [self configCell:cell indexPath:indexPath];
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [tableView fd_heightForCellWithIdentifier:@"TableViewCell" configuration:^(id cell) {
        [self configCell:cell indexPath:indexPath];
    }];
}

-(NSArray *)dataSource{
    if (!_dataSource){
        NSMutableArray * array = [NSMutableArray array];
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
            [array addObject:tagModel];
        }];
        _dataSource = [NSArray arrayWithArray:array];
    }
    return _dataSource;
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

@end
