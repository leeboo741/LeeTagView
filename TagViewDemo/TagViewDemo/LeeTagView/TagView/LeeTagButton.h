//
//  LeeTagButton.h
//  TagViewDemo
//
//  Created by YWKJ on 2018/9/4.
//  Copyright © 2018年 YWKJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeeTagViewModel.h"

@interface LeeTagButton : UIButton
@property (nonatomic, strong) LeeTagViewModel * tagViewModel;
+(LeeTagButton *)tagButtonWithTagViewModel:(LeeTagViewModel *)tagViewModel;
@end
