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

@interface ViewController ()


@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (IBAction)buttonaction:(id)sender {
    TagViewController * tagViewController = [[TagViewController alloc] initWithNibName:@"TagViewController" bundle:nil];
    [self presentViewController:tagViewController
                       animated:YES
                     completion:nil];
}
- (IBAction)button2Action:(id)sender {
    TagTestViewController * tagTestViewController = [[TagTestViewController alloc]initWithNibName:@"TagTestViewController" bundle:nil];
    [self presentViewController:tagTestViewController
                       animated:YES
                     completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
