//
//  UIButton+Block.m
//  EasyGo
//
//  Created by ZZH on 16/4/12.
//  Copyright © 2016年 Ju. All rights reserved.
//

#import "UIButton+Block.h"

#import <objc/runtime.h>

static char *buttonCallBackBlockKey;

@implementation UIButton (Block)
/**
 * 
    @weakify(self);
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];  @weakify(self);
    [btn cj_clickActionBlock:^(UIButton *button) {
        @strongify(self);
        [self doAction];
    }];
 */
- (void)cj_clickActionBlock:(void (^)(UIButton *))clickCallBack {

    // 实现系统方法
    [self addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    if (clickCallBack) {
        
        // 替换系统方法
        objc_setAssociatedObject(self, &buttonCallBackBlockKey, clickCallBack, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
}

- (void)buttonClick:(UIButton *)sender {
    
    //取出替换后的方法
    void(^buttonClickBlock)(UIButton *button) = objc_getAssociatedObject(sender, &buttonCallBackBlockKey);
    
    //回调
    if (buttonClickBlock) {
        buttonClickBlock(sender);
    }

}

@end
