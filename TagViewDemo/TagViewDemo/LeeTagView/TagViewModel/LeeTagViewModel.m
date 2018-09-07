//
//  LeeTagViewModel.m
//  TagViewDemo
//
//  Created by YWKJ on 2018/9/4.
//  Copyright © 2018年 YWKJ. All rights reserved.
//

#import "LeeTagViewModel.h"

static CGFloat kTagTextFontSize = 13.0f;
static CGFloat kTagBorderWidth = 1.0f;

@implementation LeeTagViewModel

-(instancetype)init{
    self = [super init];
    if (self) {
        _tagTextFontSize = kTagTextFontSize;
//        _tagSelectTextFontSize = kTagTextFontSize;
//        _tagDisableTextFontSize = kTagTextFontSize;
//        _tagHighLightTextFontSize = kTagTextFontSize;
        
        _tagBgColor = [UIColor whiteColor];
        _tagTextColor = [UIColor blackColor];
        _tagBorderColor = [UIColor orangeColor];
        _tagBorderWidth = kTagBorderWidth;
        _enable = YES;
    }
    return self;
}

//-(UIFont *)tagSelectTextFont{
//    if (_tagSelectTextFont) {
//        return _tagSelectTextFont;
//    }else{
//        return _tagTextFont;
//    }
//}
@end
