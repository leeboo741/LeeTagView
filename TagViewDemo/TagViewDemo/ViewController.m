//
//  ViewController.m
//  TagViewDemo
//
//  Created by YWKJ on 2018/9/4.
//  Copyright © 2018年 YWKJ. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (nonatomic, assign) NSInteger flag;
@end

static NSInteger flagCircle = 3;

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _flag = 3;
    [self.button addObserver:self forKeyPath:@"state" options:NSKeyValueObservingOptionNew context:nil];
    [self.button addObserver:self forKeyPath:@"enable" options:NSKeyValueObservingOptionNew context:nil];
    [self.button addObserver:self forKeyPath:@"selected" options:NSKeyValueObservingOptionNew context:nil];
}
- (IBAction)buttonaction:(id)sender {
    
//    NSInteger i = _flag % flagCircle;
    if (_flag % flagCircle == 2) {
        self.button.enabled = NO;
        __weak typeof(self) weakSelf = self;
        dispatch_time_t t = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC));
        dispatch_after(t, dispatch_get_main_queue(), ^{
            [weakSelf resetButton];
        });
    }else if (_flag % flagCircle == 0){
        
    }else if (_flag % flagCircle == 1){
        self.button.selected = !self.button.selected;
        
    }
    _flag ++;
}
-(void)resetButton{
    self.button.enabled = YES;
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"state"] && object == self.button) {
        NSLog(@"state : %lu",(unsigned long)self.button.state);
        NSLog(@"%@",change.description);
    }else if ([keyPath isEqualToString:@"enable"] && object == self.button){
        NSLog(@"enable : %@",self.button.enabled?@"YES":@"NO");
        NSLog(@"%@",change.description);
    }else if ([keyPath isEqualToString:@"selected"] && object == self.button){
        NSLog(@"selected : %@",self.button.selected?@"YES":@"NO");
        NSLog(@"%@",change.description);
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
