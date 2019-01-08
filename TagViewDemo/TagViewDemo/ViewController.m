//
//  ViewController.m
//  TagViewDemo
//
//  Created by YWKJ on 2018/9/4.
//  Copyright © 2018年 YWKJ. All rights reserved.
//

#import "ViewController.h"
#import "TagViewController.h"
#import "TagTestViewController.h"
#import "LeeTagView/TagView/LeeTagItem.h"
#import "LeeTagView/TagViewModel/LeeTagItemViewModel.h"

@interface ViewController ()
@property (nonatomic, strong) LeeTagItemViewModel * tagViewModel;
@property (nonatomic, strong) LeeTagItem * tagItem;
@property (weak, nonatomic) IBOutlet UIButton *testTag;
@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tagViewModel = [[LeeTagItemViewModel alloc]init];
    _tagViewModel.normalTitle = @"UNSELECTED";
    _tagViewModel.normalFont = [UIFont systemFontOfSize:9.0f];
    _tagViewModel.normalFontSize = 15.0f;
    _tagViewModel.normalColor = [UIColor greenColor];
    _tagViewModel.normalImage = [UIImage imageNamed:@"unSelected"];
    _tagViewModel.normalBGColor = [UIColor yellowColor];
    _tagViewModel.normalBorderColor = [UIColor redColor];
    _tagViewModel.normalBorderWidth = 1.0f;
    _tagViewModel.normalCornerRadius = 3.0f;
    
    _tagViewModel.selectedTitle = @"SELECTED";
    _tagViewModel.selectedFont = [UIFont systemFontOfSize:20.0f];
    _tagViewModel.selectedFontSize = 15.0f;
    _tagViewModel.selectedColor = [UIColor redColor];
    _tagViewModel.selectedImage = [UIImage imageNamed:@"selected"];
    _tagViewModel.selectedBGColor = [UIColor yellowColor];
    _tagViewModel.selectedBorderColor = [UIColor greenColor];
    _tagViewModel.selectedBorderWidth = 5.0f;
    _tagViewModel.selectedCornerRadius = 10.0f;
    
    _tagItem = [LeeTagItem tagItemWithItemViewModel:_tagViewModel];
    _tagItem.frame = CGRectMake(100, 100, _tagItem.intrinsicContentSize.width, _tagItem.intrinsicContentSize.height);
    [_tagItem addTapTarget:self action:@selector(tapTag)];
    [self.view addSubview:_tagItem];
}
-(void)tapTag{
    _tagItem.selected = !_tagItem.selected;
    _tagItem.frame = CGRectMake(100, 100, _tagItem.intrinsicContentSize.width, _tagItem.intrinsicContentSize.height);
}
/**
 viewController1 点击

 @param sender 按钮
 */
- (IBAction)buttonaction:(id)sender {
    TagViewController * tagViewController = [[TagViewController alloc] initWithNibName:@"TagViewController"
                                                                                bundle:nil];
    [self presentViewController:tagViewController
                       animated:YES
                     completion:nil];
}

/**
 ViewController2 点击

 @param sender 按钮
 */
- (IBAction)button2Action:(id)sender {
    TagTestViewController * tagTestViewController = [[TagTestViewController alloc]initWithNibName:@"TagTestViewController"
                                                                                           bundle:nil];
    [self presentViewController:tagTestViewController
                       animated:YES
                     completion:nil];
}

- (IBAction)viewController3Action:(id)sender {
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
